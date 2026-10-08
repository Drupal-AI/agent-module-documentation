# Views Flipped Table — agent index

One Views **style plugin**, `flipped_table` ("Flipped Table"), that transposes a core Views
table (results become columns, fields become rows). No settings form (`configure=null`), no
permissions, no Drush, no config of its own. Depends only on `views`.

- **Select/configure the style, the one extra option, how it stores in a view** →
  [configure/flipped-style.md](configure/flipped-style.md)
- **The template & theme hook, how the flip is computed** →
  [theming/template.md](theming/template.md)

Key facts:
- Plugin `#[ViewsStyle(id: "flipped_table", theme: "views_view_flipped_table")]` in
  `src/Plugin/views/style/FlippedTable.php`, **extends** `Drupal\views\Plugin\views\style\Table`.
- Extra option `flipped_table_header_first_field` (bool, default TRUE).
- In a view config: `display.<id>.display_options.style.type = flipped_table`,
  options under `style.options` (inherits all core Table options; `row_class`/
  `default_row_class` are hidden).
- Template `views-view-flipped-table.html.twig`; preprocess
  `template_preprocess_views_view_flipped_table()` → `ViewsFlippedTableThemeHooks`.
