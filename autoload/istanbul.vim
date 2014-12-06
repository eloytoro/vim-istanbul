" to load json generate from : istabul report

let s:plugin_path = escape(expand('<sfile>:p:h'), '\')

function! s:ClearSigns() abort
    exe ":sign unplace *"
endfunction

function! s:SetHighlight()
    hi SignColumn guifg=#004400 guibg=green ctermfg=40 ctermbg=40
    hi uncovered guifg=#ff2222 guibg=red ctermfg=1 ctermbg=1
    hi covered guifg=#004400 guibg=green ctermfg=40 ctermbg=40
    sign define uncovered text=XX texthl=uncovered
    sign define covered text=XX texthl=covered
endfunction

fun! s:istanbulShow() "{{{
    call s:SetHighlight()
    " if report not exists : istabul report
    exe 'pyfile ' . s:plugin_path . '/istanbul.py'
    python load_json()
endf "}}}

fun! istanbul#IstanbulShow() "{{{
    call s:istanbulShow()
endf "}}}

fun! istanbul#IstanbulHide() "{{{
    call s:ClearSigns()
endf "}}}