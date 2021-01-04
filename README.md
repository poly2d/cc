# cc

> [so·​lil·​o·​quy](https://www.merriam-webster.com/dictionary/soliloquy) | 1 : the act of talking to oneself

##### Organization

- [`master`](https://github.com/poly2d/cc/tree/master/) for source
- [`gh-pages`](https://github.com/poly2d/cc/tree/gh-pages) for published content

##### Components

- [gohugoio/hugo](https://github.com/gohugoio/hugo) for static site generation
- [umputun/remark42](https://github.com/umputun/remark42) as comment engine

##### Local Hosting

```sh
hugo server -D -v --theme er # where `er` is a git submodule under `themes`
```

##### Publish changes

```sh
./publish.sh
git push --all
```

##### Comment Server setup

```sh
sudo service docker start
docker-compose pull && docker-compose up -d # assuming a custom docker-compose.yml exists; refer to https://github.com/umputun/remark42
```

_TODO_
- add worktree for comment server configs
- automate comment server deploys with github actions

##### Favicon

`dice-d20` generated with [devgg/FontIcon](https://github.com/devgg/FontIcon).
