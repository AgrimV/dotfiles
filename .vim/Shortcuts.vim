" Formatting
nnoremap <leader>p :CocCommand prettier.forceFormatDocument<Enter>


" Web
autocmd FileType html nnoremap <silent><F6> :!xdg-open %<Enter><Enter>

" Python
let g:pymode_run_bind = '<C-r>'
autocmd Filetype python nnoremap <F6> :!clear && python3 %<Enter>

" C/CPP
autocmd FileType cpp nnoremap <C-b> :!g++ -o  %:r %<Enter>
autocmd FileType cpp nnoremap <F6> :!g++ -o  %:r % && clear && ./%:r<Enter>
autocmd FileType c nnoremap <C-b> :!g++ -o  %:r % -lgraph<Enter>
autocmd FileType c nnoremap <F6> :!g++ -o  %:r % -lgraph && clear && ./%:r<Enter>

" C#
autocmd FileType cs nnoremap <C-b> :!mcs %<Enter>
autocmd FileType cs nnoremap <F6> :!mcs % && clear && ./%:r.exe<Enter>

" Dart
let g:dart_format_on_save = 1
autocmd FileType dart nnoremap <C-b> :!dart %<Enter>

" Flutter
autocmd FileType dart nnoremap <C-g> :!flutter pub get<Enter>
autocmd FileType dart nnoremap <silent><F5> :!emulator -avd Pixel_3a_API_30_x86 &> /dev/null &<Enter><Enter>
