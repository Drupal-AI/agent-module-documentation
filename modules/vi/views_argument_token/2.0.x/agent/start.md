# Views Argument Token — agent index

Adds one Views **contextual-filter default-value plugin** (`argument_default` id `token`) that
fills a view argument from a Drupal token resolved against the current page/user. No settings
form, no configure route, no permissions, no Drush. Its only persistent state is the plugin's
options inside a **view config entity** (`views.view.<id>` → the display's
`arguments.<arg>.default_argument_type: token` + `default_argument_options`).

- **Configure the plugin, its option keys, and where they are stored** →
  [configure/token-argument.md](configure/token-argument.md)
- **How the token is resolved at runtime (current-user / route entity / raw values / cleanup)** →
  [api/resolution.md](api/resolution.md)

Key facts:
- Plugin class `Drupal\views_argument_token\Plugin\views\argument_default\TokenArgument`,
  annotation `@ViewsArgumentDefault(id = "token")`.
- Config schema id `views.argument_default.token`; option keys: `argument`, `process`,
  `and_or`, `all_option`, `debug`.
- Depends on `views` and `token` (Token module powers the token-tree browser only).
