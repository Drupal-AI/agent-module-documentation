# book theming

Theme hooks registered in `src/Hook/BookThemeHooks.php` (with default templates in
`templates/`). Override a template by copying it into your theme, or preprocess via
`hook_preprocess_HOOK`.

| Theme hook | Template | Variables (key ones) |
|---|---|---|
| `book_navigation` | `book-navigation.html.twig` | `book_link`, `show_tree`; preprocess also adds `book_id`, `book_title`, `book_url`, `current_depth`, prev/next/up links, `tree`. |
| `book_tree` | `book-tree.html.twig` | `items`, `attributes` (recursive tree markup). |
| `book_all_books_block` | `book-all-books-block.html.twig` | `book_menus` (render element; each item: `id`, `menu`, `title`). |
| `book_export_html` | `book-export-html.html.twig` | `title`, `book_title`, `contents`, `depth` (printer-friendly whole-book page). |
| `book_node_export_html` | `book-node-export-html.html.twig` | `node`, `content`, `children` (a single page inside the export). |

CSS/JS libraries are declared in `book.libraries.yml` (`css/book.css`,
`css/book-edit-form.css`, `css/book-parent-selector.css`, `js/book.js`,
`js/book-parent-selector.js`). For Olivero-specific navigation styling and template
overrides, enable the `book_olivero` submodule.
