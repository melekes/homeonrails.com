+++
comments = true	# set false to hide Disqus
date = "2018-11-04T09:03:09+04:00"
draft = false
share = true	# set false to hide share buttons
slug = "october-tech-picks"
tags = ["picks"]
title = "October Tech Picks"

+++
"Excellent hand-picked articles & videos about programming from all over the Internet".

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr"><a href="https://twitter.com/hashtag/golang?src=hash&amp;ref_src=twsrc%5Etfw">#golang</a> defer makes you sloppy. Try to avoid when dealing with mutexes</p>&mdash; Anton Kaliaev (@akaliaev) <a href="https://twitter.com/akaliaev/status/1058384359844204544?ref_src=twsrc%5Etfw">November 2, 2018</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet" data-conversation="none" data-lang="en"><p lang="en" dir="ltr">defer + mutexes makes you forget that<br><br>a) while we&#39;re locked, nobody else can access the object (unless its read lock) -&gt; better to unlock earlier<br>b) when you put more code &amp; call other functions between lock / unlock, it becomes easier to deadlock<br>c) defers are slow</p>&mdash; Anton Kaliaev (@akaliaev) <a href="https://twitter.com/akaliaev/status/1058384638362771462?ref_src=twsrc%5Etfw">November 2, 2018</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet" data-conversation="none" data-lang="en"><p lang="en" dir="ltr">More times you don&#39;t need a defer <a href="https://t.co/DYrbJQJwgS">pic.twitter.com/DYrbJQJwgS</a></p>&mdash; Anton Kaliaev (@akaliaev) <a href="https://twitter.com/akaliaev/status/1058387780563333120?ref_src=twsrc%5Etfw">November 2, 2018</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<!--more-->

**Articles**

* [What nobody tells you about documentation](https://www.divio.com/blog/documentation/)

Must read for anyone writing docs.

* [Writing system software: code comments.](http://antirez.com/news/124)

Must read for anyone writing code.

* [You don't need standup](https://medium.com/@jsonpify/you-dont-need-standup-9a74782517c1)

  1. No stand-ups
  2. No planning at regular intervals
  3. No retros
  4. All meetings are optional

  This may sound extreme. But there is some logic to this madness.

* [Software disenchantment](http://tonsky.me/blog/disenchantment/)

"where we are today is bullshit. As engineers, we can, and should, and will do better."

**Threads**

* [What are the unsolved issues of Remote Working and Distributed Teams?](https://www.indiehackers.com/forum/what-are-the-unsolved-issues-of-remote-working-and-distributed-teams-ec37ec323e)

**Videos**

* "Uncle" Bob Martin - "The Future of Programming"

<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/ecIWPzGEbFc" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Reflection on the history of programming (from 1948).
