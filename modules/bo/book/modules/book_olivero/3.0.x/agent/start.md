# book_olivero — agent start

Submodule of **book** (`part_of: book`). Purely presentational: provides Olivero-theme
styling and Twig template overrides for Book navigation. Depends on `book:book`.
No config, permissions, services or plugins.

What it ships (`modules/book_olivero/`):
- `templates/book-navigation.html.twig` — Olivero override of the `book_navigation` theme hook.
- `templates/book-tree.html.twig` — Olivero override of the `book_tree` theme hook.
- `css/navigation.css` — Olivero book-navigation styles, loaded via `book_olivero.libraries.yml`.

Enable it (`drush en book_olivero`) only when the front-end theme is Olivero.
For the underlying theme hooks/variables see the parent's
[../../../../3.0.x/agent/theming/templates.md](../../../../3.0.x/agent/theming/templates.md).
