let &t_ut=''
let g:python3_host_prog='/usr/bin/python3'
let g:python2_host_prog='/usr/bin/python2'
let g:ruby_host_prog='~/.local/share/gem/ruby/2.7.0/bin/neovim-ruby-host'
let g:coc_node_path='/usr/bin/node'
set cursorline
set tabstop=4
set shiftwidth=4
set autoindent
"set guifont=Source\ Code\ Pro:h14
set cursorline
set showcmd
set wildmenu
"color
set termguicolors
"光标上下保留5行
set scrolloff=5
"禁用vi兼容模式
set nocompatible
"vim的内部编码
set encoding=utf-8
"vim在与屏幕和键盘交互师傅使用的编码（取决于实际的终端的设定）
set termencoding=utf-8
"vim打开文件时的尝试使用的编码
set fileencodings=utf-8,gbk,gb2312,default,latin1
"开启语法高亮功能
syntax enable
"允许用指定高亮替换方案
syntax on
"显示行号
set nu
"凸显当前行号
set norelativenumber
"括号匹配
set showmatch
"自动检测文件类型
filetype plugin indent on 
"在缩进和遇到Tab键时使用空格替代
set expandtab
"根据文件类型设置缩进格式
au FileType html,vim,javascript setl shiftwidth=2
au FileType html,vim,javascript setl tabstop=2
au FileType java,php,pathon setl shiftwidth=4
au FileType java,php,pathon setl tabstop=4
"启动vim时不要自动折叠代码
set foldlevel=100
"自动对齐
set ai
"根据下面的格式对齐
set si
set smarttab
set wrap
set lbr
set tw=0
set foldmethod=syntax
"总是显示状态栏
set laststatus=2
"显示光标当前位置
set ruler
"高亮显示当前行
set cursorline
"高亮显示搜索结果
set hlsearch
exec "nohlsearch"
set incsearch
set ignorecase
set smartcase
"禁止拆行
set nowrap
"设置backspace按键
set backspace=indent,eol,start
"Mode 光标 Settings
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)
"快捷键----------------------------------------------
"设置快捷键前最，即<Leader>
let mapleader=" "
"设置快捷键将选中文本块复制到系统剪贴板
map <Leader>y "+y
"设置快捷键将系统剪贴板内容粘帖到vim(不知道为什么不生效)
"map <Leader>p <C-V>

"系统剪切板设置
let g:clipboard = {
  \   'name': 'xclip',
  \   'copy': {
  \      '+': 'tmux load-buffer -',
  \      '*': 'tmux load-buffer -',
  \    },
  \   'paste': {
  \      '+': 'tmux save-buffer -',
  \      '*': 'tmux save-buffer -',
  \   },
  \   'cache_enabled': 1,
  \ }
"设置大写R重新加载配置
map R :source $MYVIMRC<CR>
noremap <LEADER><CR> :nohlsearch<CR>
"分页
map sh :set nosplitright<CR>:vsplit<CR>
map sl :set splitright<CR>:vsplit<CR>
map sj :set splitbelow<CR>:split<CR>
map sk :set nosplitbelow<CR>:split<CR>
"移动分页窗口
map <LEADER>h <C-w>h
map <LEADER>l <C-w>l
map <LEADER>j <C-w>j
map <LEADER>k <C-w>k
"改变分页窗口大小
map <up> :res -5<CR>
map <down> :res +5<CR>
map <left> :vertical resize-5<CR>
map <right> :vertical resize+5<CR>
"新tabe页
map tu :tabe<CR>
map tn :-tabnext<CR>
map ti :+tabnext<CR>
"
"-------------------------------------------------
"
"以下为插件安装
"--------------------------------------------------
call plug#begin('~/.vim/plugged')

"文件目录结构
Plug 'preservim/nerdtree'
"配色方案
Plug 'altercation/vim-colors-solarized'
"更快速的注释代码
Plug 'tpope/vim-commentary'
"删除括号内
Plug 'tpope/vim-surround'
"vim状态栏
Plug 'vim-airline/vim-airline'
"补全coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" fzf
Plug 'junegunn/fzf.vim'
" ranger
Plug 'kevinhwang91/rnvimr'
"omnisharp-vim
Plug 'OmniSharp/omnisharp-vim'
"ale
Plug 'dense-analysis/ale'
"格式化
Plug 'Chiel92/vim-autoformat'

call plug#end()
"-------------------------------------------------
"
"以下为插件配置
"--------------------------------------------------
"nerdtree配置
"--------------------------------------------------
"按F3开启/关闭
map TT :NERDTreeToggle<CR>
"在新tab中开启新文件
let NERDTreeMapOpenInTab='r'
"let NERDTreeMapOpenInTab='<ENTER>'
"--------------------------------------------------
"vim-colors-solarized配置
"--------------------------------------------------
set t_Co=256
let g:solarized_termcolors=256
if has('gui_running')
    set background=light
else
    set background=dark
endif
colorscheme solarized
"--------------------------------------------------
"vim-autoformat配置
"--------------------------------------------------
noremap FF :Autoformat<CR>
"--------------------------------------------------
"OmniSharp-Vim配置
"--------------------------------------------------
let g:OmniSharp_server_stdio = 1
let g:ale_linters = {
      \'cs': ['OmniSharp']
\}
let g:OmniSharp_selector_ui = 'fzf'
let g:OmniSharp_selector_findusages = 'fzf'
let g:OmniSharp_highlighting = 0
if has('patch-8.1.1880')
  set completeopt=longest,menuone,popuphidden
  " Highlight the completion documentation popup background/foreground the same as
  " the completion menu itself, for better readability with highlighted
  " documentation.
  set completepopup=highlight:Pmenu,border:off
else
  set completeopt=longest,menuone,preview
  " Set desired preview window height for viewing documentation.
  set previewheight=5
endif
augroup omnisharp_commands
  autocmd!

  " Show type information automatically when the cursor stops moving.
  " Note that the type is echoed to the Vim command line, and will overwrite
  " any other messages in this space including e.g. ALE linting messages.
  autocmd CursorHold *.cs OmniSharpTypeLookup

  " The following commands are contextual, based on the cursor position.
  autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfu <Plug>(omnisharp_find_usages)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfi <Plug>(omnisharp_find_implementations)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ospd <Plug>(omnisharp_preview_definition)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ospi <Plug>(omnisharp_preview_implementations)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ost <Plug>(omnisharp_type_lookup)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osd <Plug>(omnisharp_documentation)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfs <Plug>(omnisharp_find_symbol)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfx <Plug>(omnisharp_fix_usings)
  autocmd FileType cs nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
  autocmd FileType cs imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)

  " Navigate up and down by method/property/field
  autocmd FileType cs nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)
  autocmd FileType cs nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)
  " Find all code errors/warnings for the current solution and populate the quickfix window
  autocmd FileType cs nmap <silent> <buffer> <Leader>osgcc <Plug>(omnisharp_global_code_check)
  " Contextual code actions (uses fzf, vim-clap, CtrlP or unite.vim selector when available)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
  autocmd FileType cs xmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
  " Repeat the last code action performed (does not use a selector)
  autocmd FileType cs nmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)
  autocmd FileType cs xmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)

  autocmd FileType cs nmap <silent> <buffer> <Leader>os= <Plug>(omnisharp_code_format)

  autocmd FileType cs nmap <silent> <buffer> <Leader>osnm <Plug>(omnisharp_rename)

  autocmd FileType cs nmap <silent> <buffer> <Leader>osre <Plug>(omnisharp_restart_server)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osst <Plug>(omnisharp_start_server)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ossp <Plug>(omnisharp_stop_server)
augroup END
"--------------------------------------------------
"coc-nvim配置
"--------------------------------------------------
" 如果未设置 hidden，TextEdit可能会失败
set hidden

" 某些服务器的备份文件有问题, see #649.
set nobackup
set nowritebackup

" 给消息更多的显示空间.
set cmdheight=2

" 较长的更新时间(默认为4000毫秒= 4秒)会导致明显的延迟和糟糕的用户体验。
set updatetime=300

" 不要将消息传递给 |ins-completion-menu|.
set shortmess+=c

" 总是显示符号列，否则每当诊断出现/被解析时，它就会移位文本
if has("patch-8.1.1564")
  " 最近vim可以将符号列和数字列合并为一列
  set signcolumn=number
else
  set signcolumn=yes
endif

" 使用制表符来完成触发器，字符在前面和导航。
" NOTE: 使用命令 ':verbose imap <tab>' 来确保tab在放入配置之前没有被其他插件映射
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" 使用 <c-space> 去触发补完
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" 让 <CR> 自动选择第一个完成项目并通知 coc.nvim 在输入时格式化, <cr> 可以被其他vim插件重新映射
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" 使用 `[g` and `]g` 去导航诊断
" 使用 `:CocDiagnostics` 获取位置列表中当前缓冲区的所有诊断信息
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" 转到代码导航
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" 使用K在预览窗口显示文档
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" 按住光标时突出显示该符号及其参考。
autocmd CursorHold * silent call CocActionAsync('highlight')

" 重命名。
nmap <leader>rn <Plug>(coc-rename)

" 选择的代码格式化
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " 设置formatexpr指定的文件类型
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " 更新有关跳转占位符的签名帮助
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" 将 codeAction 应用到选定区域.
" Example: `<leader>aap` 应用到当前段落
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" 重新映射用于应用codeAction的键到当前缓冲区。
nmap <leader>ac  <Plug>(coc-codeaction)
" 对当前行上的问题应用自动修复。
nmap <leader>qf  <Plug>(coc-fix-current)

" 映射 function 和 class 文本对象
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" 重新映射 <C-f> 和 <C-b> 滚动浮动窗口/弹出窗口。
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" 使用CTRL-S选择范围
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" 添加 `:Format` 命令来格式化当前缓冲区。
command! -nargs=0 Format :call CocAction('format')

" 添加 `:Fold` 命令来折叠当前缓冲区
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" 添加 `:OR` 命令用于组织当前缓冲区的导入。
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" 添加(Neo)Vim的本地状态线支持。
" NOTE: 请参阅 `:h coc-status` 了解与提供自定义状态线的外部插件的集成: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

"--------------------------------------------------
"rnvimr配置
"--------------------------------------------------
" Make Ranger replace Netrw and be the file explorer
let g:rnvimr_enable_ex = 1

" Make Ranger to be hidden after picking a file
let g:rnvimr_enable_picker = 1

" Disable a border for floating window
let g:rnvimr_draw_border = 0

" Hide the files included in gitignore
let g:rnvimr_hide_gitignore = 1

" Change the border's color
let g:rnvimr_border_attr = {'fg': 14, 'bg': -1}

" Make Neovim wipe the buffers corresponding to the files deleted by Ranger
let g:rnvimr_enable_bw = 1

" Add a shadow window, value is equal to 100 will disable shadow
let g:rnvimr_shadow_winblend = 70

" Draw border with both
let g:rnvimr_ranger_cmd = 'ranger --cmd="set draw_borders both"'

" Link CursorLine into RnvimrNormal highlight in the Floating window
highlight link RnvimrNormal CursorLine

nnoremap <silent> <M-o> :RnvimrToggle<CR>
tnoremap <silent> <M-o> <C-\><C-n>:RnvimrToggle<CR>

" Resize floating window by all preset layouts
tnoremap <silent> <M-i> <C-\><C-n>:RnvimrResize<CR>

" Resize floating window by special preset layouts
tnoremap <silent> <M-l> <C-\><C-n>:RnvimrResize 1,8,9,11,5<CR>

" Resize floating window by single preset layout
tnoremap <silent> <M-y> <C-\><C-n>:RnvimrResize 6<CR>

" Map Rnvimr action
let g:rnvimr_action = {
            \ '<C-t>': 'NvimEdit tabedit',
            \ '<C-x>': 'NvimEdit split',
            \ '<C-v>': 'NvimEdit vsplit',
            \ 'gw': 'JumpNvimCwd',
            \ 'yw': 'EmitRangerCwd'
            \ }

" Add views for Ranger to adapt the size of floating window
let g:rnvimr_ranger_views = [
            \ {'minwidth': 90, 'ratio': []},
            \ {'minwidth': 50, 'maxwidth': 89, 'ratio': [1,1]},
            \ {'maxwidth': 49, 'ratio': [1]}
            \ ]

" Customize the initial layout
let g:rnvimr_layout = {
            \ 'relative': 'editor',
            \ 'width': float2nr(round(0.7 * &columns)),
            \ 'height': float2nr(round(0.7 * &lines)),
            \ 'col': float2nr(round(0.15 * &columns)),
            \ 'row': float2nr(round(0.15 * &lines)),
            \ 'style': 'minimal'
            \ }

" Customize multiple preset layouts
" '{}' represents the initial layout
let g:rnvimr_presets = [
            \ {'width': 0.600, 'height': 0.600},
            \ {},
            \ {'width': 0.800, 'height': 0.800},
            \ {'width': 0.950, 'height': 0.950},
            \ {'width': 0.500, 'height': 0.500, 'col': 0, 'row': 0},
            \ {'width': 0.500, 'height': 0.500, 'col': 0, 'row': 0.5},
            \ {'width': 0.500, 'height': 0.500, 'col': 0.5, 'row': 0},
            \ {'width': 0.500, 'height': 0.500, 'col': 0.5, 'row': 0.5},
            \ {'width': 0.500, 'height': 1.000, 'col': 0, 'row': 0},
            \ {'width': 0.500, 'height': 1.000, 'col': 0.5, 'row': 0},
            \ {'width': 1.000, 'height': 0.500, 'col': 0, 'row': 0},
            \ {'width': 1.000, 'height': 0.500, 'col': 0, 'row': 0.5}
            \ ]

" Fullscreen for initial layout
" let g:rnvimr_layout = {
"            \ 'relative': 'editor',
"            \ 'width': &columns,
"            \ 'height': &lines - 2,
"            \ 'col': 0,
"            \ 'row': 0,
"            \ 'style': 'minimal'
"            \ }
"
" Only use initial preset layout
" let g:rnvimr_presets = [{}]
