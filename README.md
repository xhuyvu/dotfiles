# Guide to installing
## Dependencies
font: nerd font fira code

```bash
sudo apt update

sudo apt install -y \
  openjdk-17-jdk \
  ripgrep \
  fd-find \
  unzip \
  zip \
  curl \
  wget \
  git \
  xclip \
  tar \
  gzip \
  make \
  gcc \
  g++ \
  python3 \
  python3-pip \
  maven \
  gradle \
  luarocks
```




## 1. Backup old config 
```bash
mv ~/.config/nvim ~/.config/nvim.bak
```

## 2. Copy new config 
```bash
cp -r <thư-mục-này>/* ~/.config/nvim/
```

Structure:
```
~/.config/nvim/
├── init.lua
├── ftplugin/
│   └── java.lua
└── lua/
    ├── core/
    │   ├── keymap.lua
    │   └── options.lua
    └── plugins/
        ├── cmp.lua
        ├── comment.lua
        ├── dap.lua
        ├── formatter.lua
        ├── jdtls.lua
        ├── lsp.lua
        ├── oil.lua
        ├── springboot.lua
        ├── telescope.lua
        ├── test.lua
        ├── themes.lua
        └── treesitter.lua
```

## 3. install Mason packages
Mở Neovim, run:
```
:MasonInstall jdtls java-debug-adapter java-test google-java-format
:MasonInstall typescript-language-server html-lsp css-lsp
:MasonInstall lua-language-server prettier stylua
```

or using : `ensure_installed`.
 

## 4.tesing 
```
:checkhealth
:Lazy
```

## Keymaps

| Key | Mô tả |
|-----|-------|
| `<leader>Jr` | Chạy Spring Boot app |
| `<leader>Jo` | Organize imports |
| `<leader>Jev` | Extract variable |
| `<leader>Jem` | Extract method |
| `<leader>Jec` | Extract constant |
| `<leader>Jgc` | Generate class mới |
| `<leader>Jgi` | Generate interface mới |
| `<leader>Jge` | Generate enum mới |
| `<leader>Jt` | Test method gần nhất (jdtls) |
| `<leader>JT` | Test cả class (jdtls) |
| `<leader>tn` | Test method gần nhất (neotest) |
| `<leader>tf` | Test cả file (neotest) |
| `<leader>ta` | Test toàn project (neotest) |
| `<leader>ts` | Mở test summary panel |
| `<F5>` | DAP: Continue / Start debug |
| `<F10>` | DAP: Step over |
| `<F11>` | DAP: Step into |
| `<leader>db` | DAP: Toggle breakpoint |
| `<leader>du` | DAP: Toggle UI |
| `<leader>lf` | Format buffer |
| `gd` | Go to definition |
| `gr` | Go to references |
| `K` | Hover docs |
| `<leader>ca` | Code action |
| `<leader>rn` | Rename |
| `-` | Mở oil file explorer |
| `<leader>ff` | Telescope: find files |
| `<leader>fg` | Telescope: live grep |
| `<leader>ha` | Harpoon: add file |
| `<leader>hh` | Harpoon: menu |
