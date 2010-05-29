" ---------------------------------------------------------------------------------------
"  .vimrc.py
"  @tasasaki
" ---------------------------------------------------------------------------------------

echo "Load python's settings."

" ---------------------------------------------------------------------------------------
" python
" ---------------------------------------------------------------------------------------

" python
autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl tabstop=8 shiftwidth=4 softtabstop=4

