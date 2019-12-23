+++
date = "2017-01-14T21:14:14+04:00"
draft = false
slug = "signing-git-commits"
tags = ["git", "tutorials"]
title = "Подписываем git коммиты"

+++
Решили у себя в команде, что будем подписывать коммиты и тэги. У git'а уже
давно имеется данная возможность. Но мало кто ей пользуется. Благодаря этому
возможны такие смешные поделки как
[git-blame-someone-else](https://github.com/jayphelps/git-blame-someone-else).
Если же вы подписываете коммит своей подписью, то уверенности в том, что автор
действительно вы, прибавляется.

Github в [апреле прошлого
года](https://github.com/blog/2144-gpg-signature-verification) начал показывать
зеленый бейджик когда коммит подписан. Вот как он выглядит:

{{< figure src="/images/posts/2017-01-14-signing-git-commits/github.png" title="" >}}

<!--more-->

Создать подпись и настроить git очень просто. Итак, давайте сделаем это:

### 1. Создаем подпись

Ставим gpg:

```
# Ubuntu
sudo apt-get install gpa seahorse
# Mac
brew install gpg
```

Создаем RSA пару (публичный и приватный ключ):

```
gpg --gen-key
```
(размер не ниже 2048, но и [больше не особо
нужно](https://gnupg.org/faq/gnupg-faq.html#no_default_of_rsa4096); срок
годности по желанию)

Копируем полученный публичный ключ на [Github](https://github.com/settings/keys):

```
gpg --list-secret-keys --keyid-format LONG

-------------------------------
sec   2048R/<COPY_LONG_KEY>  2017-01-14 [expires: 2019-01-14]
uid                          User Name <user.name@email.com>
ssb   2048R/098AA7C27DD57ACC 2017-01-14

gpg --armor --export <PASTE_LONG_KEY_HERE>
```

### 2. Настраиваем git

```
gpg --list-secret-keys

-------------------------------
sec   2048R/<COPY_SHORT_KEY> 2017-01-14 [expires: 2019-01-14]
uid                          User Name <user.name@email.com>
ssb   2048R/7DD57ACC         2017-01-14

git config --global user.signingKey <PASTE_SHORT_KEY_HERE>
git config --global commit.gpgsign true
git config --global tag.gpgsign true
```
(можно настроить индивидуально под каждый репозиторий).

### 3. Кэшируем пароль

чтобы не вводить его каждый раз при подписи.

Если вы пользователь Mac OS, то ставим [GPG Suite](https://gpgtools.org/),
который интегрируется с Mac OS keychain. Переходим к шагу 4.

Если пользуетесь Linux, то придется воспользоваться встроенным `gpg-agent`.

Создаем конфиг `.gnupg/gpg-agent.conf` со следующим содержимым:

```
default-cache-ttl 28800
max-cache-ttl 28800
```

28800 - 8 часов (кто-то ставит 1 час).

В конфиге `.gnupg/gpg.conf` указываем:

```
use-agent
batch
```

`batch` убирает противные сообщения вида: `You need a passphrase to unlock the
secret key`. Да, они по неведомой причине появляются даже, если агент
закэшировал пароль.

Не забываем запустить `gpg-agent`:

fish:

```
if not begin
    # Is the agent running already? Does the agent-info file exist, and if so,
    # is there a process with the pid given in the file?
    [ -f ~/.gpg-agent-info ]
    and kill -0 (cut -d : -f 2 ~/.gpg-agent-info) ^/dev/null
end
    # no, it is not running. Start it!
    gpg-agent --daemon --no-grab --write-env-file ~/.gpg-agent-info >/dev/null ^&1
end
# get the agent info from the info file, and export it so GPG can see it.
set -gx GPG_AGENT_INFO (cut -c 16- ~/.gpg-agent-info)
set -gx GPG_TTY (tty)
```

или [bash](https://github.com/ErinCall/Dotfiles/blob/master/.bashrc#L32-L40)
или напрямую `gpg-agent --daemon`.

## 4. Коммитим что угодно и идем смотреть результат на Github

Материалы:

- [Signing Your Git Commits With GPG](https://blog.erincall.com/p/signing-your-git-commits-with-gpg)
- [Github : Signing commits using GPG (Ubuntu/Mac)](https://gist.github.com/ankurk91/c4f0e23d76ef868b139f3c28bde057fc)
- [Automatic Git commit signing with GPG on OSX](https://gist.github.com/bmhatfield/cc21ec0a3a2df963bffa3c1f884b676b)
