+++
date = "2022-01-17T15:43:01+04:00"
draft = false
slug = "rough-notes-2-axelar"
tags = ["roughnotes"]
title = "Rough notes #2: Axelar"

+++

[Axelar Network: Connecting Applications with Blockchain
Ecosystems](https://axelar.network/wp-content/uploads/2021/07/axelar_whitepaper.pdf)
by Sergey Gorbunov and Georgios Vlachos, published in January 2021.

<!--more-->

> "To enable applications to communicate across blockchain ecosystems
frictionlessly, we propose Axelar. Axelar stack provides a decentralized
network, protocols, tools, and APIs that allow simple cross-chain
communication. Axelar protocol suite consists of cross-border routing and
transfer protocols."

The two questions the authors pose are:

1. Can we enable application builders to build on the best platform for their needs while still communicating across multiple blockchain ecosystems?
2. Can we allow users to interact with any application on any blockchain directly from their wallets?

High-level goals:

- no heavy engineering work from ecosystem developers
- minimal effect to interoperability if a blockchain itself upgrades
- a simple protocol to lock, unlock, transfer tokens, and communicate with other applications

While [multiple interoperability
protocols](https://alexeizamyatin.medium.com/interoperability-deep-dive-xcmp-vs-ibc-vs-optics-e365c72180cb)
now exist, their adoption is still fairly limited. It's more or less clear that
the future is [multichain](https://vitalik.ca/general/2021/12/06/endgame.html),
but the road ahead is fuzzy. Most ecosystems currently racing towards biggest
adoption / market cap and their developers don't have time for any cross-chain
development. As a result, [many custom bridges had
appeared](https://medium.com/1kxnetwork/blockchain-bridges-5db6afac44f8).

Existing solutions do not scale well ("We have also seen a few
other single-purpose bridges by platform developers that rewrite
state-transition logic in smart contracts to bridge to other ecosystems [1, 7].
They suffer from multiple scalability issues, do not allow the ecosystem to
scale uniformly, and introduce additional dependencies for applications").

> Why just not use IBC?

There's a claim that IBC requires Tendermint consensus, which is false. Any
consensus with finality is supported. IBC does require in-protocol light
clients, but so does Axelar (see below). IBC does not provide any high-level
application protocols (see below).

## General info

{{< figure src="/images/posts/2022-01-17-routh-notes-2-axelar/axelar.jpg" title="" >}}

At the base layer there's a dPoS blockchain that is responsible for storing
the state of multiple blockchains that the platform is connected to.
"Governance rules allow network participants to enact protocol decisions such as
which blockchains to bridge and which assets to support."

"The validators collectively maintain threshold signature accounts
on other blockchains (e.g., 80% of validators must approve and co-sign any
transaction out of it), which allows them to lock and unlock assets and state
across chains and to post state on other blockchains, the “outgoing bridges."

NOTE that threshold signature bridges can be
[unsecure](https://medium.com/l2beat/is-the-6b-locked-in-l2-secure-895cba23d026),
but this is less the case here if the validator set is sufficiently large and
decentralized.

"As part of consensus, validators run light-client software of other
blockchains, allowing them to verify the state of other blockchains. The
validators report these states to the Axelar blockchain, and once enough of
them report, the state of Bitcoin, Ethereum, and other chains is recorded on
Axelar."

In the beginning validator generate threshold key for each outgoing bridge.
When the validator set changes, the key is regenerated.

"Axelar sets the safety threshold to 90%, meaning that almost all validators will need
to collude to withdraw any funds that are locked by its network or forge state proofs"

### Network synchrony assumptions

"When connecting chains through Axelar, the connection works assuming the
strongest network assumptions out of these chains, which is synchrony in the
case of connecting Bitcoin and Cosmos, for instance."

## What if the network stalls or a connected chain breaks?

"To address any potential stall of the Axelar network itself, each threshold
bridge account on a blockchain X that the Axelar validators collectively
control has an “emergency unlock key”"

"If chain X that is connected to Axelar breaks, there are a couple options:

- Impose limits on the USD value of assets that can be moved in/out of X on any single day. Thus
a malicious chain X can only steal a small fraction of all assets that are bridged to it before Axelar
validators detect this, and the governance mechanisms from the following bullets kick in.
- The Axelar governance module can be used to vote on what happens in those situations. For instance,
if there is a benign bug and the community restarts X, Axelar governance can determine to restart the
connection from where it left off.
- If ETH had moved to X, a custom Ethereum recovery key can determine what happens to the ETH
assets."

## Cross-Chain Gateway Protocol (CGP)

This protocol allows:

- posting info about the state of one blockchain into the
state of another blockchain
- transferring tokens

The user posts a request q on one of the bridge accounts. Validators who need
to validate both chains (what if they don't?) query the state. Once 2/3+
validators returns the same result, it's signed and returned to the user.

Transferring is more or less similar (pegged tokens are created for those
frozen on a bridge account).

## Cross-Chain Transfer Protocol (CTP)

"Applications can leverage cross-chain features by calling CTP queries
analogous to HTTP/HTTPS GET/POST methods. These queries are subsequently picked
up by CGP layer for execution and results are returned back to the users.

- CTP Queries. Application developers can host their applications on any chain
 and integrate their smart contracts with threshold bridge accounts to execute
 CTP queries.
- Threshold bridge accounts. Suppose an application developer builds their
 contracts on chain A. Then, they would reference threshold bridge contracts to
 obtain cross-chain support.

  This contract allows applications to:

  - Register a blockchain it would like to communicate with.
  - Register assets on that blockchain that it would like to leverage.
  - Perform operations over the assets such as accept deposits, process withdrawals, and other functions (similar to, say, ERC-20 contract calls)."

## Summary

Axelar is a common relay chain to forward messages from one blockchain to
another ("decentralized crosschain read/write oracle") using
threshold-signature based bridges and light clients.

The novelty comes from the set of high-level protocols (CGP and CTP) for
cross-chain application calls, which is unavailable in the existing protocols
(e.g. IBC).

---

To learn more, you can go to [their website](https://axelar.network/). Don't
forget to like this and subscribe. Joking :) I don't care. I read whitepapers
for fun.
