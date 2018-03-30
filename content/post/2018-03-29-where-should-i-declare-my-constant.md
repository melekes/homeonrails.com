+++
comments = true	# set false to hide Disqus
date = "2018-03-29T15:18:47+02:00"
draft = false
image = ""
share = true	# set false to hide share buttons
slug = "where-should-i-declare-my-constant"
tags = ["programming"]
title = "Where should I declare my constant?"
+++

_This article was originally published on [Medium](https://medium.com/@anton.kalyaev/where-should-i-declare-my-constant-4675d2c87496)._

Quick question: where should I declare my constant? Most developers would say:
“top of the file”. And that would be the wrong answer. As for the majority of
the questions in software engineering, the right answer is “it depends”. I
would try to prove to you, in this post, that, if the constant is private and
is used only in one place, it’s far better to declare it right above the line,
where it’s used.

### Public constants

Declare public constants at the top of the package or module or whatever is
your languages defines along with documentation. That’s where most people would
hope to find them. That’s where other developers would hope to find them. In
most languages, there is an agreement (written or spoken) on how a code within
a file should be structured. Most commonly, first, there are constants, then
variables, then public structures (or class definition), then public functions
and private functions in the end.

Note sometimes people put constants, representing a common group, in a separate
file (e.g. “errors.go” file in Golang).

### Private constants

If the private constant is used in many files (not just one), then again
declare it at the top of the file. Which one? How do I know?) It’s your code.
The reasoning is the same as for public constants above.

If the private constant is used within one file, declare it close to where it’s
used. Of course, there are all different caveats. For example, in Ruby, there
is a private modifier, and you are supposed to put private constants and
methods under it.

{{< highlight ruby >}}
private

  MY_SECRET_CONST = "secret"

  def method_a
  end

  def method_b
  end
{{< /highlight >}}

You can also mark them as private though: `private :method_a, :method_b`.

Be sure to watch [an episode of “On Writing
Software”](https://www.youtube.com/watch?v=H5i1gdwe1Ls&feature=youtu.be&t=9m16s)
by David Heinemeier Hansson, where he shares his thoughts on the subject.

If you have a specification (the definition of how the thing works), any
constant (public or private) that is part of it, should also be at the top of
the file.

The advantage of having a private constant close to its usage is no context
loss and no need for scrolling to the top of the file. The context loss is
probably the main one. When you scrolled to the top and went back, you may not
remember all the details that were in your head the moment you were reading the
function/method body in the beginning.

The argument that developers will search for a constant at the top of the file
is invalid if the constant is declared within this method. In 99% of cases,
they will notice it with a lateral vision.

{{< highlight go >}}
func A() {
  const MY_SECRET_CONST = "secret"
  methodA(MY_SECRET_CONST)
}
{{< /highlight >}}

<img class="img-rounded" src="/images/posts/2018-03-29-where-should-i-declare-my-constant/flowchart.png" alt="" title=""/>

The flowchart above is simplified, of course. But at the very least, it
provides some guidance.

Hope this clarifies things! Be sure to comment on this article if you disagree
on something.
