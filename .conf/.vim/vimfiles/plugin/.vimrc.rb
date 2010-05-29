" ---------------------------------------------------------------------------------------
"  .vimrc.rb
"  @tasasaki
" ---------------------------------------------------------------------------------------

echo "Load ruby's settings."

" ---------------------------------------------------------------------------------------
" ruby
" ---------------------------------------------------------------------------------------

" ruby
autocmd FileType ruby,eruby,yaml set softtabstop=2 shiftwidth=2 tabstop=2
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
let g:rails_level = 4


