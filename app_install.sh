sudo pacman -Sy zsh nvim git lazygit python python2 python-pip python2-pip ruby nodejs npm fzf bat ranger the_silver_searcher go ctag neofetch

# china source
# nodejs npm
npm config set registry https://registry.npm.taobao.org/

# go
SETX GOGO111MODULE on
go env -w GOPROXY=https://goproxy.cn,direct

# ruby gem
gem sources --remove https://rubygems.org/
gem sources -a https://gems.ruby-china.com/

# nvim
pip install pynvim ranger-fm
pip2 install pynvim 
npm install -g neovim
gem install neovim

# ccat
go get -u github.com/owenthereal/ccat
