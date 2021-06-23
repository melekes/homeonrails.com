+++
date = "2020-05-07T15:49:01+04:00"
draft = false
slug = "rough-notes-1-lazy-ledger"
tags = ["roughnotes"]
title = "Rough notes #1: Celestia"

+++

[LazyLedger: A Distributed Data Availability Ledger With Client-Side Smart
Contracts](https://arxiv.org/abs/1905.09274) by Mustafa Al-Bassam, published in
May 2019.

<!--more-->

> "We propose LazyLedger, a design for distributed ledgers where the blockchain is optimized for solely ordering and guaranteeing the availability of transaction data. Responsibility for executing and validating transactions is shifted to only the clients that have an interest in specific transactions relating to blockchain applications that they use."

Sounds intriguing, right? Let's dive in!

Offloading responsibility to a client is not a novel approach and been used in
client-server architecture for [quite some
time](https://en.wikipedia.org/wiki/Fat_client). In the world of blockchains,
the concept again appeared with Mastercoin.

This design choice has some interesting properties:

- lower resource requirements for full nodes;
- faster consensus - no need to check/execute transactions + for BFT protocols you only need a simple majority to achieve consensus, rather than 2/3+;
- applications can be written in any language (same can be archived with
  [Tendermint ABCI
  ](https://docs.tendermint.com/master/introduction/what-is-tendermint.html#intro-to-abci));
- applications can be written in different languages (no need to have a common
  runtime);
- forking/upgrading becomes easy => just run a new version of your application.

The downsides include:

- higher resource requirements for the clients, which execute transactions (note light clients have low resource usage);
- upgrading requires additional coordination (i.e., if there's a new version of a contract deployed on Ethereum, everybody can see it; here, if you start using a new version, nobody knows; there needs to be some kind of application registry). Furthermore, if other apps need to communicate with your app, the users of the other apps need to upgrade your app too.

---

June 2021: LazyLedger project is now called Celestia.

In Celestia, the client ONLY verifies & executes transactions, which are
related to the application it's running. When a client requests transactions,
it uses the namespace ID (e.g., "cryptokitties") to tell which transactions
it's interested in. Namespace IDs, therefore, are used as shard keys (virtual
shards).

Consensus nodes use either PoW or PoS consensus to agree on the order of
transactions.

## On Availability

To familiarize yourself with the data availability problem, read ["A note on
data availability and erasure
coding"](https://github.com/ethereum/research/wiki/A-note-on-data-availability-and-erasure-coding)
or [this
article](https://medium.com/nearprotocol/unsolved-problems-in-blockchain-sharding-2327d6517f43)
from Near protocol.

For light clients, we want to guarantee not only that the headers form a valid
chain (like in Tendermint), but have the guarantee that corresponding blocks
are valid too. To solve this, Celestia makes use of [erasure coding][2],
[fraud proofs, and random sampling][3].

What differentiates Celestia from earlier approaches ([1][1]) is using data
availability proofs to prevent clients from having to download everyone else's
transactions to validate the (data availability) of the chain, thus truly
offloading responsibility.

A block header contains a Merkle tree root of the erasure coded block data.
Light clients randomly sample the block parts to ensure data availability.
While 100% guarantee is possible, in practice probabilistic guarantee is given
(99%).

> "if an adversarial block producer has withheld k out of n shares, then there is a high probability that the client will sample an unavailable piece and reject the block"

> "a block ... divided into 4096 shares, only 15 samples corresponding to 0.4% of the block data needs to be downloaded by a node to achive a 99% guarantee"

> "because all applications in Celestia share the same chain, the availability of the data of all their transactions are equally and uniformly guaranteed by the same consensus group, unlike in traditional sidechains where each sidechain may have a different (smaller) consensus group"

There's no "Plasma" sharding, just a single chain.

> "clients gossip downloaded samples to full nodes that request it, so that they can recover the full block with enough shares"

Clients and full nodes form a single p2p network, communicating block parts on demand.

> "sufficient minimum number of nodes in the network making a sufficient number of sample requests"

Celestia has an interesting property: as the number of clients grows, the
security of the network strengthens. More clients => more requests proving
block availability => better guarantee that block is indeed available. With the
number of clients increasing, block size can be increased too.

## On Liveness and Safety

> "We assume that honest nodes not under an eclipse attack and are thus connected to at least one other honest node"

> "We also assume that there is a maximum network delay Y"

Celestia assumes a synchronous gossiping network for both liveness and
safety.

## On Security

Because consensus nodes do not validate transactions, it's possible for a
malicious block producer to create a block filled with bad transactions.
Clients won't accept it, but it will still be created and stored by full nodes.

Therefore, it's important for applications to have a way to punish the
malicious block producer in PoS networks.

## Social coordination

Social or other means of coordination are required when upgrading an
application to a new version. Since here we don't have a common runtime (e.g.
EVM), we need a way for applications to signal that a new version is available.

This can be done through some off-chain registry or another application.

The Celestia team plans to provide tooling for deployment, so deploying an
application is "easily as deploying a smart contract on eth or spinning
up a docker container".

## Future plans

The Celestia team plans to use optimistic rollups. Each application will have
a state root (along w/ fraud proofs), which will be used by light clients.

---

To learn more, you can go to [their website](https://celestia.org/). Don't
forget to like this and subscribe.

_Thanks to [Ismail Khoffi](https://twitter.com/KreuzUQuer) and [Mustafa
Al-Bassam](https://twitter.com/musalbas) for answering my questions!_

[1]: <https://www.cs.cornell.edu/lorenzo/papers/sosp03.pdf> "Separating Agreement from Execution for Byzantine Fault Tolerant Services"
[2]: https://en.wikipedia.org/wiki/Erasure_code
[3]: <https://arxiv.org/pdf/1809.09044.pdf> "Fraud and Data Availability Proofs: Maximising Light Client Security and Scaling Blockchains with Dishonest Majorities"
