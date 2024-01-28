# coding-env


## Setup
1) Install XQuartz

2) Create workspace symbolic link

```sh
ln -s {workspace} workdir
```

3) Run init script

```sh
./init.sh
```

## for global vim
Add alias to `.zshrc`

```sh
alias mvim='sh ~/coding-env/run_vim.sh /root/workdir'
```

## Config

Edit `custom/setup_config.json`

## Support language

- Node.js
- Python
- Golang
- Java
