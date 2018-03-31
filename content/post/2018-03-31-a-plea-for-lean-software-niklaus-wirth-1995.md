+++
comments = true	# set false to hide Disqus
date = "2018-03-31T15:46:21+02:00"
draft = false
image = ""
share = true	# set false to hide share buttons
slug = "a-plea-for-lean-software-niklaus-wirth-1995"
tags = ["programming","papers"]
title = "A Plea for Lean Software by Niklaus Wirth (1995)"
+++

<img class="img-rounded" src="/images/posts/2018-03-31-a-plea-for-lean-software-niklaus-wirth-1995/plea.jpg" alt="" title="Plea for Greek Independence by Eugène Delacroix (1826)"/>

In 1889, [Anton Chekhov](https://en.wikipedia.org/wiki/Anton_Chekhov) writes to
his brother Alexander: "My advice: in the play try to be original and as clever
as possible, but do not be afraid to seem silly; we need free-thinking, but
only the freethinker who is not afraid to write nonsense. Do not grind it, but
be clumsy and impudent. Brevity is the soul of wit.”

I think we can apply the same principles to academic papers as well.

One of the papers, that is concise, well thought and just fun to read
is A Plea for Lean Software by Niklaus Wirth (1995). It is only five pages
long, but it touches a great variety of topics including software complexity,
language design, and others.

> “With a touch of humor, the following two laws reflect the state of the art admirably well:

> 1) Software expands to fill the available memory. (Parkinson)

> 2) Software is getting slower more rapidly than hardware becomes faster. (Reiser)”

Nowadays computers have so much memory the prevailing style of developing
programs seems to become “ship something, which works more or less, quick and,
later, fix it". Why the web page takes 1GB of RAM? Why [the desktop
client](https://medium.com/@matt.at.ably/wheres-all-my-cpu-and-memory-gone-the-answer-slack-9e5c39207cab)
takes 1GB of RAM?

> “What drives software toward complexity? A primary cause of complexity is that software vendors uncritically adopt almost any feature that users want. Another important reason lies in monolithic design. Increased hardware power has undoubtedly been the primary incentive for vendors to tackle more complex problems, and more complex problems inevitably require more complex solutions.”

First and third points are still valid and will never go away. Microservices
architecture, which became super popular lately, is intended to solve the
second point. At the same time, it brings the new problems and challenges
([distribution, operational complexity,
...](https://martinfowler.com/articles/microservice-trade-offs.html)).

> “Customer dependence is more profitable than customer education.”

Here he complains about the lack of intuitive, easy to use products. This seems
to be improving over time due to increased competition.

> “Time pressure is probably the foremost reason behind the emergence of bulky software.”

At the same time, he acknowledges that first product in a niche has a
considerable advantage:

> “The tendency to adopt the “first” as the de facto standard is a deplorable phenomenon, based on the same time pressure.”

On C and C++ programming languages:

> “Given this situation, programmers struggle with a language that discourages structured thinking and disciplined programs construction (and denies basic compiler support). They also resort to makeshift tools that chiefly add to software’s bulk.”

C++ has improved a lot apparently since then, but (as far as my limited
knowledge of C++ goes) it still lacks Algebraic Data Types, Type Inference, and
some other things, making new languages like Rust more attractive.

The original paper is available [here](https://cr.yp.to/bib/1995/wirth.pdf).
