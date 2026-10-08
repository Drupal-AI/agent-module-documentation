# ckeditor5_paste_filter — agent start

Cleans markup pasted into a CKEditor 5 editor (Word / Google Docs) by running the pasted
HTML through an ordered set of configurable regex search/replace filters. Ships a CKEditor 5
plugin (`ckeditor5_paste_filter_pasteFilter`) that intercepts the editor's clipboard
`inputTransformation` event. Depends on core `ckeditor5`. Configured **per text format** — no
site-wide settings form or `configure` route.

- Enable it, the default filters, adding/reordering/removing rules → [configure/ckeditor5_paste_filter.md](configure/ckeditor5_paste_filter.md)
- How the client-side plugin, library, and regex execution work → [theming/ckeditor5_paste_filter.md](theming/ckeditor5_paste_filter.md)
