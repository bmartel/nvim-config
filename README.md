# nvim-config
Current neovim config

![image](https://user-images.githubusercontent.com/2242258/125203683-12228000-e23f-11eb-84eb-e3509c9b30a7.png)

## Install

Clone the directory to the nvim config path (back up any existing files first)
```bash
git clone https://github.com/bmartel/nvim-config.git ~/.config/nvim
```

Run the language server dependencies setup
```bash
 ~/.config/nvim/setup.sh
```

Install [minpac](https://github.com/k-takata/minpac#installation)
```bash
git clone https://github.com/k-takata/minpac.git ~/.config/nvim/pack/minpac/opt/minpac
```

Open neovim
```bash
nvim
```
Run :PackUpdate from within neovim
```bash
:PackUpdate
```
