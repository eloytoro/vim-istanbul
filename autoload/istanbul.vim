" to load json generate from : istabul report

if !has('python')
    echohl WarningMsg|echomsg "python interface to vim not found."
    finish
endif

if !exists('g:coverage_json_path')
    let json_path=getcwd().'/coverage/coverage.json'
    if filereadable(json_path)
        let g:coverage_json_path=json_path
    else
        echohl WarningMsg|echomsg "coverage.json file not found."
        finish
    end
end

let s:plugin_path = escape(expand('<sfile>:p:h'), '\')

function! s:ClearSigns() abort
    exe ":sign unplace *"
endfunction

function! s:SetHighlight()
    hi clear SignColumn
    hi link SignColumn Normal
    hi uncovered guibg=#680000
    hi covered guibg=#0b3800
    hi fstatno guifg=#ffc520 guibg=#ffc520
    hi branch_true guibg=#383838
    hi branch_false guibg=#383838
    sign define uncovered    linehl=uncovered
    sign define fstatno      linehl=fstatno
    sign define covered      linehl=covered
    sign define branch_true  linehl=branch_true  text=T
    sign define branch_false linehl=branch_false text=F
endfunction

fun! s:istanbulShow() "{{{
    call s:SetHighlight()
    " if report not exists : istabul report
    exe 'py g_coverage_json_path = "' . g:coverage_json_path . '"'
    exe 'pyfile ' . s:plugin_path . '/istanbul.py'
    python sign_covered_lines()
endf "}}}

fun! istanbul#IstanbulShow() "{{{
    call s:istanbulShow()
endf "}}}

fun! istanbul#IstanbulHide() "{{{
    call s:ClearSigns()
endf "}}}
