+++
date = "2017-12-11T23:48:31-05:00"
draft = false
slug = "note-on-security"
tags = ["security"]
title = "Заметка о безопасности"

+++

[English](https://medium.com/@anton.kalyaev/personal-security-in-the-age-of-cryptocurrencies-904c9bedae01)

Недавно начал все больше интересоваться темой безопасности. Наверное, я, как и
многие люди из поколения Y, выросшие во времена бума компьютерных технологий,
Сноудена и fsociety всегда был параноиком по части безопасности, но, признаться
честно, я мало что делал для обеспечения ее как таковой. AdBlock, HTTPS
Everywhere, и еще пара плагинов для Chrome - джентльменский набор нуба, так
сказать.

Но грядут новые времена. Времена, где [твои криптоденежки можно увести у тебя
из под носа просто подсунув тебе фейковую версию
кошелька](https://www.coindesk.com/nicehash-ceo-confirms-bitcoin-theft-worth-78-million/).
Поэтому лучше предпринять некие меры, которые, конечно, не гарантируют 100%
безопасности, но хотя бы значительно уменьшают вектор атаки.

DISCLAIMER: я ну вот вообще не эксперт в безопасности, поэтому запускайте,
устанавливайте и используйте перечисленные инструменты на свой страх и риск.

## Mac

Базовое руководство (обязательно): [A practical guide to securing macOS](https://github.com/drduh/macOS-Security-and-Privacy-Guide)

Плюс шаги, которых нет в ^^^: https://www.macworld.co.uk/feature/mac/22-tricks-improve-mac-security-best-tips-3643100/

Советы от John Galt: https://discussions.apple.com/docs/DOC-8841

Немного устаревшая, но все еще полезная статья с советами от NSA: https://www.macworld.com/article/2048160/how-the-nsa-snoop-proofs-its-macs.html

Выключите Java и удалите Flash Player: https://www.hackread.com/tips-to-secure-mac-against-hackers/

> Как увеличить шансы найти спизженный мак?

Find My Mac (обратите внимание на то, что гостевой аккаунт должен быть
включен). Неужели воры до сих пор не догадываются об этом!? Более интересные
проекты http://orbicule.com/undercover/mac/ и https://www.preyproject.com/. Но
увы, они не работают с FileVault 2 (встроенным шифрованием).

**Malware detector и другие полезности**

https://objective-see.com/products.html

**Network monitor**

Little Snitch https://www.obdev.at/products/littlesnitch/index.html

## Поисковый движок

DuckDuckGo https://duckduckgo.com/

## VPN

NordVPN https://nordvpn.com/

[@andy_one](https://twitter.com/andy_one) Некотролируемый VPN это не про
безопасность совсем. AWS/DO/Azure/GoogleCE + Algo VPN.

## Secure communication

- Signal https://www.signal.org/
- ProtonMail https://protonmail.com/
- PGP https://ssd.eff.org/en/playlist/mac-user#how-use-pgp-mac-os-x

## Браузер

Chrome или Firefox

Еще хочу попробовать https://brave.com/.

## Плагины

- HTTPS Everywhere https://www.eff.org/https-everywhere
- uBlock https://www.ublock.org/
- ScriptSafe https://www.andryou.com/scriptsafe
- Punycode Alert https://chrome.google.com/webstore/detail/punycode-alert/djghjigfghekidjibckjmhbhhjeomlda?hl=en
- EtherAddressLookup (для крипты) https://github.com/409H/EtherAddressLookup
- MetaMask (для крипты) https://metamask.io

Если ScriptSafe кажется слишком радикальным движением, то можно поступить как
я: создать два профиля (1) стандартный для проверенных ресурсов (2) безопасный
c ScriptSafe, отключенным Javascript и Cookies.

## Ubuntu

Все еще думаю, а не вернуться ли мне к старому доброму Linux. Купить Lenovo и
накатить Ubuntu. Что интересно, руководств в интернете меньше для Linux. Значит
ли это, что его труднее взломать? Наверное нет, просто количество пользователей
на порядок меньше.

Базовое руководство (обязательно): https://spreadprivacy.com/linux-privacy-tips/

Набор утилит: https://help.ubuntu.com/community/Security

## iPhone

- [How To Protect Your Privacy On iPhone](https://spreadprivacy.com/iphone-privacy-tips/)

## Android

- [How To Protect Your Privacy On Android](https://spreadprivacy.com/android-privacy-tips/)
- [10 best security apps for Android that aren’t antivirus apps](https://www.androidauthority.com/best-security-apps-android-687799/)

## 2FA

[Yubikey](https://www.yubico.com/) или [OnlyKey](https://crp.to)

<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/r8tHr3p14BU" frameborder="0" gesture="media" allow="encrypted-media" allowfullscreen></iframe>

## Password manager

[KeePassX](https://www.keepassx.org/)  или [1Password](https://1password.com/)

Большинство 2FA могут быть использованы в качестве замены менеджера паролей или
как дополнение к нему
[1](https://www.yubico.com/why-yubico/for-individuals/password-managers/),
[2](https://crp.to/2016/10/is-the-entire-password-strategy-flawed-the-short-answer-yes/).

## Tor

[Tor](https://www.torproject.org/) объединяет в себе браузер, мессенджер и сеть.

## Другие ОС

[Qubes OS](https://www.qubes-os.org/)
