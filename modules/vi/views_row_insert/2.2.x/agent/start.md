# Views Row Insert — agent index

A single Views **style plugin** `row_insert` (`Drupal\views_row_insert\Plugin\views\style\ViewsRowInsert`)
that interleaves an extra row — a rendered block or unrestricted custom HTML — after every Nth
view row. No config UI route (`configure: null`); you configure it in the view display's *Format*
section. Persistent state lives in the **view config entity** under
`display.<id>.display_options.style` (`type: row_insert`, `options: {...}`).

- **Enable the style on a view, all option keys, defaults, block vs custom content** →
  [configure/row-insert-style.md](configure/row-insert-style.md)
- **Template / preprocess output and how to override the markup** →
  [theming/template.md](theming/template.md)

Notes:
- Config schema: `views.style.row_insert` (see the option keys in the configure doc).
- Permission `administer views row insert` is declared in `views_row_insert.permissions.yml` but
  is **not checked anywhere in the module code** — it gates nothing in this release.
- The `custom_row_data` textarea is unrestricted HTML rendered with Twig `raw`.
