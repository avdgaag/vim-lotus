" lotus.vim - Shortcuts and settings for project with the Lotus web framework
" Maintainer: Arjan van der Gaag <http://arjanvandergaag.nl>
" Version: 0.1

if exists('g:loaded_lotus') || &cp
  finish
endif
let g:loaded_lotus = 1

augroup lotus
  autocmd!

  " Setup when openening a file without a filetype
  autocmd BufNewFile,BufReadPost *
    \ if empty(&filetype) |
    \   call lotus#Setup(expand('<amatch>:p')) |
    \ endif

  " Setup when launching Vim for a file with any filetype
  autocmd FileType * call lotus#Setup(expand('%:p'))

  " Setup when launching Vim without a buffer
  autocmd VimEnter *
    \ if expand('<amatch>') == '' |
    \   call lotus#Setup(getcwd()) |
    \ endif
augroup END

let s:projections = {
  \ 'apps/{app}/controllers/*.rb': {
  \   'type': '{app}Action',
  \   'alternate': 'spec/{app}/controllers/{}_spec.rb'
  \ },
  \ 'apps/{app}/views/*.rb': {
  \   'type': '{app}View',
  \   'alternate': 'spec/{app}/views/{}_spec.rb'
  \ },
  \ 'apps/{app}/templates/*': {
  \   'type': '{app}Template'
  \ },
  \ 'apps/{app}/config/*.rb': {
  \   'type': '{app}Config'
  \ },
  \ 'apps/{app}/application.rb': {
  \   'type': '{app}Config'
  \ },
  \ 'apps/{app}/presenters/*.rb': {
  \   'type': '{app}Presenter',
  \   'alternate': 'spec/{app}/presenters/{}_spec.rb'
  \ },
  \ 'spec/{app}/*.rb': {
  \   'type': '{app}Spec'
  \ },
  \ 'spec/spec_helper.rb': {
  \   'type': 'spec'
  \ },
  \ 'lib/{project}/entities/*.rb': {
  \   'type': 'entity',
  \   'alternate': 'spec/{project}/entities/{}_spec.rb'
  \ },
  \ 'lib/{project}/repositories/*.rb': {
  \   'type': 'repository',
  \   'alternate': 'spec/{project}/repositories/{}_spec.rb'
  \ },
  \ 'lib/*.rb': {
  \   'type': 'lib',
  \   'alternate': 'spec/{project}/{}_spec.rb'
  \ },
  \ 'lib/{project}.rb': {
  \   'type': 'lib'
  \ },
  \ 'db/migrations/*.rb': {
  \   'type': 'migration'
  \ },
  \ 'db/schema.sql': {
  \   'type': 'migration'
  \ }
\ }

augroup lotus_projections
  autocmd!
  autocmd User ProjectionistDetect call lotus#ProjectionistDetect(s:projections)
augroup END

augroup lotus_path
  autocmd!
  autocmd User Lotus call lotus#DefineLotusCommand()
  autocmd User Lotus call lotus#SetupSnippets()
  autocmd User Lotus call lotus#SetupSurround()
  autocmd User Lotus
        \ let &l:path = 'lib/**,apps/**,spec/**,' . &path |
        \ let &l:suffixesadd = '.html,.html.erb,.rb' . &suffixesadd
augroup END
