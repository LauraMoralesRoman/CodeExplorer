colorscheme industry

" C/C++ formatting settings
setlocal expandtab
setlocal shiftwidth=4
setlocal tabstop=4
setlocal softtabstop=4

" Keep indentation consistent with clang-format
setlocal autoindent
setlocal smartindent

" Visual guide matching clang-format's ColumnLimit
setlocal textwidth=100
setlocal colorcolumn=100

" Don't insert extra whitespace
setlocal listchars=tab:>-,trail:·
setlocal formatoptions-=c
setlocal formatoptions-=r
setlocal formatoptions-=o

" C indentation
setlocal cindent

command! CMake !
			\ cmake -B build -G Ninja
			\ -DCMAKE_BUILD_TYPE=Debug

command! Build AsyncRun
			\ cmake --build build
			\ --target code-explorer
			\ -- -j10

command! Run !
			\ ./build/code-explorer

lua << EOF
	function init_menu()
		return {
			{ name = 'Build', cmd = 'Build' },
			{ name = 'Run CMake', cmd = 'CMake' },
			{ name = 'Run', cmd = 'Run' },
		}
	end
	_G.init_menu = init_menu
EOF

nnoremap <C-p> :lua require'menu'.open(_G.init_menu(), { border = true })<cr>

command! -nargs=1 Man vsplit term man <args>
