+++
author = ""
comments = true	# set false to hide Disqus
date = "2019-04-15T09:00:12+04:00"
draft = false
image = "images/posts/2019-04-15-basicblockradio-68-corrections/bbr.png"
menu = ""		# set "main" to add this content to the main menu
share = true	# set false to hide share buttons
slug = "basicblockradio-68-corrections"
tags = ["podcast"]
title = "Базовый Блок 68: поправки и дополнения"
+++

Сегодня опубликовали выпуск со мной в подкасте ["Базовый
Блок"](https://basicblockradio.com/e068/).

Учитывая, что это был мой первый опыт участия в подкасте, вышло неплохо. НО я
допустил несколько ошибок (ввиду волнения, ошибки перевода, тысячу других
отмазок можно придумать) и хотелось бы их разобрать.

<!--more-->

> в распределенных системах есть два основных понятия - безопасность (safety) и доступность (availability)

Availability это из
[CAP](https://ru.wikipedia.org/wiki/%D0%A2%D0%B5%D0%BE%D1%80%D0%B5%D0%BC%D0%B0_CAP)
теоремы. Правильно - Liveness (живучесть).
https://en.wikipedia.org/wiki/Liveness

См. также https://en.wikipedia.org/wiki/Safety_property

> ты можешь экономикой или инструментами воздействовать (на децентрализацию стейка)

См. [On the decentralization of the Cosmos
Hub](https://forum.cosmos.network/t/on-the-decentralization-of-the-cosmos-hub/1726)
и [RESEARCH: Slashing incentives for validator
decentralization](https://forum.cosmos.network/t/research-slashing-incentives-for-validator-decentralization/1835).

> в Tendermint есть похожая механика, где за генерацию блока участники получают награду

В Cosmos, да. Помимо награды за блок есть также комиссии транзакций. Малая
часть достается валидатору (у некоторых валидаторов сейчас установлена 0%
комиссия), большая часть уходит делегаторам. См.
[Cosmos Validator Economics - Bridging the Economic System of Old into the New Age of Blockchains](https://blog.cosmos.network/economics-of-proof-of-stake-bridging-the-economic-system-of-old-into-the-new-age-of-blockchains-3f17824e91db)

> Sybil attacks в Tendermint

Можно рассматривать [атаку Сивиллы](https://ru.wikipedia.org/wiki/%D0%90%D1%82%D0%B0%D0%BA%D0%B0_%D0%A1%D0%B8%D0%B2%D0%B8%D0%BB%D0%BB%D1%8B) на двух уровнях:

- уровне алгоритма
- сетевом уровне

На уровне алгоритма, как и в любом другом PoS алгоритме, чтобы стать
валидатором (участвовать в консенсусе) тебе нужно **купить** попугаев и если ты
отступаешь от протокола (например, голосуешь за форк и основную цепочку), ты
можешь лишиться части или всех попугаев (slashing).

На сетевом уровне, можно пользоваться инструментами Cloudflare или Google или
блокировать по IP.

> типичный пример отсылки транзакции из Bitcoin в Ethereum в сети Cosmos

Напишу отдельную статью, чтобы было понятнее и самому прояснить некоторые
вопросы для себя. Если вкратце, то:

```
Bob -> [Ethereum Smart Contract] -> [Eth 1.0 Zone] -> [Cosmos Hub] -> [Bitcoin Zone]

[Bitcoin Zone] -> [Binance DEX] -> [Bitcoin Zone] -> Bitcoin Contract -> Alisa
```

Боб хочет отправить 55 ETH на свой счет в Bitcoin Zone:

1. Он отправляет эквивалент 55 ETH на смарт контракт.
2. Eth 1.0 Zone ждет 100 блоков чтобы убедиться что транзакция не будет откачена
3. Eth 1.0 Zone начисляет 55 CETH (Cosmos ETH) на счет Боба (адрес Боб указал когда посылал средства на смарт контракт)
4. Боб посылает 55 CETH в Bitcoin Zone. 55 CETH сжигаются на Eth 1.0 Zone! IBC транзакция уходит в Cosmos Hub и далее в Bitcoin Zone.
5. 55CETH начисляются на счет Боба в Bitcoin Zone. Т.е 55CETH теперь существуют в Bitcoin Zone!

Боб хочет отправить 1 BTC Алисе:

1. Он отправляет эквивалент 1 BTC в ETH (скажем 900 ETH) на смарт контракт.
2. Eth 1.0 Zone ждет 100 блоков чтобы убедиться что транзакция не будет откачена
3. Eth 1.0 Zone начисляет 900 CETH (Cosmos ETH) на счет Боба (адрес Боб указал когда посылал средства на смарт контракт)
4. Боб посылает 900 CETH в Binance DEX. 900 CETH сжигаются на Eth 1.0 Zone! IBC транзакция уходит в Binance DEX и далее в Bitcoin Zone.
5. 1 CBTC (Cosmos BTC) начисляются на счет Боба в Bitcoin Zone
6. Боб посылает транзакцию о выходе (exit) из Bitcoin Zone. Bitcoin Contract перечисляет 1 BTC Алисе.
