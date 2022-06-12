" Description: Keymaps

" fuzzy find
nnoremap <silent> <leader>f <cmd>Telescope find_files<cr>
nnoremap <silent> <leader>r <cmd>Telescope live_grep<cr>
nnoremap <silent> <leader>b <cmd>Telescope buffers<cr>
nnoremap <silent> <leader>; <cmd>Telescope help_tags<cr>


nnoremap <silent> <leader>m <Plug>MarkdownPreviewToggle

nnoremap <silent> <leader>n :lua require("nabla").popup()<CR>
nnoremap <silent> <leader>e :MdEval<CR>
