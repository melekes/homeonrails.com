+++
date = "2018-03-03T13:47:11+04:00"
draft = false
slug = "choosing-a-type-for-blockchain-height"
tags = ["blockchain", "golang"]
title = "Choosing a type for blockchain height (beware of unsigned integers)"

+++

_This article was originally published on [Medium](https://medium.com/@anton.kalyaev/choosing-a-type-for-blockchain-height-beware-of-unsigned-integers-714804dddf1d)._

Before [this pull request](https://github.com/tendermint/tendermint/pull/914),
it was a mess. ABCI was using a `uint64` height on EndBlock. Tendermint Core
was using the same type for TxResult. Block and BlockStore, however, were using
`int` heights (remember that `int` is different depending on the processor
architecture: `int32` for x86, `int64` for amd64). There was no single standard
across our repositories as for what type to use for blockchain height.

<!--more-->

There was a need \[[1](https://github.com/tendermint/tendermint/issues/731)\].
If you have different types everywhere, you need to cast them, which can lead
to information loss:

- value — when casting bigger to smaller type
- sign — when casting signed to unsigned type

Users should be able to build upon Tendermint without worrying that some type
is going to change overnight.

So one day we sat down and decided to do a small research. Choosing between
`uint64` and `int64` was not an obvious choice. At least not back then.
Blockchain height should only go up, so it is logical to suggest `uint64`. And
with a maximum value being 18446744073709551615, a chain can live up to 584
million years (assuming one sec. blocks). Wow. That’s life! What about other
projects? [Parity](https://github.com/paritytech/parity) and
[chain](https://github.com/chain/chain) use `uint64`. Sounds like an obvious
choice? But if you look deep enough, there are dragons.

## Ruling out int type

`int` was ruled out almost immediately due to size (32 bits on x86) and
inconsistency between nodes with different architectures.

> Assuming a one second block time this means on a 32-bit architecture a Tendermint chain can only live 68 years, which is just under the worldwide mean life expectancy for a male. Surely a Tendermint chain should live longer!

## uint64 vs int64

**Benefits of uint64**

- good for bit-wise arithmetic (encryption algorithms, etc.)
- a form of self-documentation. The type indicates that the value which the
  unsigned int was intended to hold is never supposed to be negative.

**Downsides of uint64**

- you have to be careful with arithmetic. There are cases where we subtract
  heights or subtract 1 like getting the age of some piece of evidence or logic
  around checkpointing. With signed integers, we can just assert for `< 0`. With
  unsigned integers, we are risking to get a super huge value if we forget to
  check for underflow or make a mistake at some point.

> I am just saying that if we decrement an uninitialized height uint64(0), all of a sudden that’s a quick mess up. if we have code that can check if `height <= 0` then we are set with `int64`. but with `uint64` only code Jesus can help us

{{< figure src="/images/posts/2018-03-03-choosing-a-type-for-blockchain-height/jesus.jpg" title="" >}}

{{< highlight go >}}
package main
import (
    "fmt"
)
func main() {
    var a int64
    a = 10
    a -= 29
    if a < 0 {
        fmt.Println("panic")
    }
    fmt.Printf("a=%v\n", a)
    var b uint64
    b = 10
    if (29 - b) > 10 {
        fmt.Println("underflow")
    }
    b -= 29
    fmt.Printf("b=%v\n", b)
}
{{< /highlight >}}

[https://play.golang.org/p/YvQgJ6Bm2Xu](https://play.golang.org/p/YvQgJ6Bm2Xu)

**Note on uint64 and Java**

Java does not support unsigned ints. It means ABCI apps, that are written in
Java won’t be able to go beyond `int64` anyway. If you are curious about why read
[Why doesn’t Java support unsigned ints](https://stackoverflow.com/questions/430346/why-doesnt-java-support-unsigned-ints)?

**Benefits of int64**

- less chance of fuck up

**Downsides of int64**

- smaller max value (although, 292 million years are more than enough)

### In conclusion

Given above reasoning we decided to go with `int64`. “value should never be less
than zero” should not be a primary reason for picking `uint64` as a type for
blockchain height. If you are gonna use `uint64`, be extra careful with
arithmetic.

Resources:

- [You’re probably using “unsigned” incorrectly](https://codemines.blogspot.de/2007/10/youre-probably-using-unsigned.html)
