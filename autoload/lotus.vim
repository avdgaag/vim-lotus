" lotus.vim - Shortcuts and settings for project with the Lotus web framework
" Maintainer: Arjan van der Gaag <http://arjanvandergaag.nl>
" Version: 0.1

function! s:shellslash(path) abort
  if exists('+shellslash') && !&shellslash
    return substitute(a:path, '\\', '/', 'g')
  else
    return a:path
  endif
endfunction

function! s:find_root(path) abort
  let root = s:shellslash(simplify(fnamemodify(a:path, ':p:s?[\/]$??')))
  let previous = ''
  while root !=# previous && root !=# '/'
    if filereadable(root.'/.lotusrc')
      return root
    end
    let previous = root
    let root = fnamemodify(root, ':h')
  endwhile
  return ''
endfunction

function! s:Detect(path) abort
  if !exists('b:lotus_root')
    let dir = s:find_root(a:path)
    if dir !=# ''
      let b:lotus_root = dir
    endif
  endif
endfunction

function! lotus#Setup(path) abort
  call s:Detect(a:path)
  if exists('b:lotus_root')
    doautocmd User Lotus
  endif
endfunction

function! s:Lotus(bang, ...) abort
  let l:cmd = 'lotus'
  if executable(b:lotus_root . '/bin/lotus')
    let l:cmd = 'bin/lotus'
  elseif filereadable(b:lotus_root . '/Gemfile')
    let l:cmd = 'bundle exec lotus'
  else
    let l:cmd = 'lotus'
  endif
  exe '!' . l:cmd . ' ' . join(copy(a:000), ' ')
endfunction

function! s:LotusComplete(ArgLead, CmdLine, CursorPos, ...) abort
  return "generate\nroutes\nserver\ndb\nversion\nconsole"
endfunction

function! lotus#DefineLotusCommand() abort
  command! -buffer -bar -bang -nargs=? -complete=custom,s:LotusComplete Lotus
    \ execute s:Lotus('<bang>',<q-args>)
endfunction

" Take a single projection object of properties and values and replace a
" placeholder in each of the property values with a given value.
function! s:ReplaceProjectionPlaceholder(projection, placeholder, replacement) abort
  let retval = {}
  for [prop,value] in items(a:projection)
    let retval[prop] = substitute(value, a:placeholder, a:replacement, "g")
  endfor
  return retval
endfunction

" Loop over a given set of projections and replace a single placeholder in all
" keys and property values with a given value.
function! s:ReplaceProjectionsPlaceholder(projections, placeholder, replacement) abort
  let l:projections = {}
  for [key, projection] in items(a:projections)
    if stridx(key, a:placeholder) > -1
      let k = substitute(key, a:placeholder, a:replacement, "g")
      let l:projections[k] = s:ReplaceProjectionPlaceholder(projection, a:placeholder, a:replacement)
    else
      let l:projections[key] = projection
    endif
  endfor
  return l:projections
endfunction

" Look for a placeholder value in a set of projections and repeat each
" projection for every value in `values`, replacing the placeholder with the
" next value from `values`.
function! s:MultiplyProjectionsPlaceholders(projections, placeholder, values) abort
  let l:projections = {}
  for [key, projection] in items(a:projections)
    if stridx(key, a:placeholder) > -1
      for value in a:values
        let k = substitute(key, a:placeholder, value, "g")
        let l:projections[k] = s:ReplaceProjectionPlaceholder(projection, a:placeholder, value)
      endfor
    else
      let l:projections[key] = projection
    endif
  endfor
  return l:projections
endfunction

" Find the name of this Lotus project by looking for its entities directory.
"
" For example, when this directory exists, relative to `b:lotus_root`:
"
"    ./lib/foobar/entities
"
" Then this function will return 'foobar'.
function! s:ProjectName() abort
  return fnamemodify(split(globpath(b:lotus_root, "lib/**/entities"), '\n')[0], ":h:t")
endfunction

" List all the apps avaialble in this Lotus project. This returns a list with
" the names of all directories in `b:lotus_root`./apps.
function! s:ProjectApps() abort
  return map(split(globpath(b:lotus_root, "apps/*"), "\n"), 'fnamemodify(v:val, ":t")')
endfunction

" Take `s:projections` and use placholders within to create a set of
" projections suitable for a Lotus project with the right project name and
" names of apps.
function! s:LotusProjections(projections) abort
  return s:MultiplyProjectionsPlaceholders(
        \  s:ReplaceProjectionsPlaceholder(a:projections, "{project}", s:ProjectName()),
        \  "{app}", s:ProjectApps()
        \ )
endfunction

" Hook function that gets run when vim-projectionist looks up available
" projections. This allows us to inject our own, custom projections.
"
" This function handles inserting our projections for buffers in a Lotus
" project.
function! lotus#ProjectionistDetect(projections) abort
  if exists('b:lotus_root')
    call projectionist#append(b:lotus_root, s:LotusProjections(a:projections))
  endif
endfunction

function! lotus#SetupSnippets() abort
  let snippetsDir = expand('<sfile>', ':h') . '/snippets'
  if exists('g:UltiSnipsSnippetsDir')
    call add(g:UltiSnipsSnippetsDir, snippetsDir)
  else
    let g:UltiSnipsSnippetsDir = [snippetsDir]
  endif
endfunction

function! lotus#SetupSurround() abort
  if exists('g:loaded_surround')
    if !exists('b:surround_45')
      let b:surround_45 = "<% \r %>"
    endif
    if !exists('b:surround_61')
      let b:surround_61 = "<%= \r %>"
    endif
    if !exists('b:surround_35')
      let b:surround_35 = "<%# \r %>"
    endif
    if !exists('b:surround_5')
      let b:surround_5 = "<% \r %>\n<% end %>"
    endif
  endif
endfunction
