# Views Extras — agent index

Adds Views plugins only — no config UI, no permissions, no Drush. Three contextual-filter
**default argument** plugins (`session`, `cookie`, `tempstore`) that source a filter value from
`$_SESSION` / `$_COOKIE` / private TempStore with a token-aware fallback, plus one Views **area**
handler `extra_result` ("Extra Result summary").

- **Use the plugins in a view; option keys; where they land in `views.view.*` config** →
  [configure/views-plugins.md](configure/views-plugins.md)
- **Reference: every plugin id, its option keys, and the `extra_result` token list** →
  [reference/plugins.md](reference/plugins.md)

Key facts:
- Argument-default plugin ids: `session`, `cookie`, `tempstore` (`@ViewsArgumentDefault`).
- Area handler id: `extra_result` (`@ViewsArea`, added via `views_extras_views_data()`).
- Cookie plugin auto-prefixes the key with `Drupal_visitor_` (reads `$_COOKIE['Drupal_visitor_'.$key]`).
- Fallback values are passed through the token service with `user` = current user.
- Stored inside a view: `display.*.display_options.arguments.<arg>.default_argument_type` =
  `session|cookie|tempstore`, with `default_argument_options`.
