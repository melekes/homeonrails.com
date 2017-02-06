+++
image = ""
title = "CircleCI config for multipackage Golang projects"
comments = true
slug = "circleci-config-for-multipackage-golang-projects"
tags = ["golang","ci"]
date = "2017-02-06T10:54:24+04:00"
draft = false
share = true

+++

Multipackage Golang project - project, consisting of several packages. When
testing you usually do something like `go test ./...`, when getting all the
dependencies - `go get ./...`. There may be or may not be a Go package at the
root level. Examples: [1](https://github.com/hashicorp/consul),
[2](https://github.com/tendermint/tendermint).

<!--more-->

If you are using [glide](https://github.com/Masterminds/glide) or other package
manager:

```yaml
---
machine:
  environment:
    PROJECT_GOPATH: "${HOME}/.go_project"
    PROJECT_PARENT_PATH: "${PROJECT_GOPATH}/src/github.com/${CIRCLE_PROJECT_USERNAME}"
    PROJECT_PATH: "${PROJECT_PARENT_PATH}/${CIRCLE_PROJECT_REPONAME}"
    GOPATH: "${HOME}/.go_workspace:/usr/local/go_workspace:${PROJECT_GOPATH}"

dependencies:
  pre:
    - go get -u -v github.com/Masterminds/glide
  override:
    - mkdir -p "$PROJECT_PARENT_PATH"
    - ln -sf "$HOME/$CIRCLE_PROJECT_REPONAME/" "$PROJECT_PATH"
    - glide install
  post:
    - go version
    - glide -v

test:
  override:
    - cd "$PROJECT_PATH" && go test -v $(glide novendor)
```

Also, if you want to store your test's output as CircleCI artifact on S3:

```yaml
test:
  override:
    - cd "$PROJECT_PATH" && go test -v $(glide novendor) 2>&1 | tee test.log
  post:
    - cd "$PROJECT_PATH" && mv test.log "${CIRCLE_ARTIFACTS}"
```

`$(glide novendor)` could be replaced with `$(shell go list ./... | grep -v
'/vendor/')`. The former is just shorter.

You might be asking yourself: where is the example using simple `go get`? I
won't give you one because [I was not able to get `go get` working on CircleCI
for our
  project](https://discuss.circleci.com/t/using-own-packages-in-go-project/4073/8).

The errors were as follows:

```
package _/home/ubuntu/.go_project/src/github.com/tendermint/tendermint/benchmarks: unrecognized import path "_/home/ubuntu/.go_project/src/github.com/tendermint/tendermint/benchmarks" (import path does not begin with hostname)
...
```

**One small advice:**

install [yamllint](https://github.com/adrienverge/yamllint) and check your
config file. If your config contains the syntax errors, CircleCI will output
"Action failed: Configure the build". Very descriptive, right?

Resources:

- https://subosito.com/posts/golang-circleci/
