# coding-env


## Setup
### 1) Install X11
For macOS
- https://www.xquartz.org/

### 2) Setup config file
Copy `custom/setup_config_default.json` to create `custom/setup_config.json`

And, edit versions.

> If `custom/setup_config.json` doesn't exist, `custom/setup_config_default.json` is used.

Support languages

| language |
|---|
| Node.js |
| Python |
| Golang |
| Java |

### 3) Run init script

```sh
./init.sh filepath
```

## for global vim
Add alias to `.zshrc`

```sh
alias mvim='sh ~/coding-env/run_vim.sh'
```

