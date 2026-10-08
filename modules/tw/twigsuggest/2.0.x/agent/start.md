# Twig Template Suggester — agent index

Adds the theme/template **suggestions** Drupal core omits (block-per-region, page/html-per-node-type,
user-per-role, field-per-view-mode, form/container/menu templates, …) so themers can add a
`.html.twig`. Pure theme-layer module: **no admin UI, no `configure` route, no permissions, no
config schema, no Drush.** Installs at **weight 100** so its suggestions win.

- **Every suggestion it adds, per theme hook, with the template file patterns** →
  [theming/suggestions.md](theming/suggestions.md)
- **The one setting (`alternate_ds_suggestions`), the `base_path` variable, the helper service** →
  [configure/settings.md](configure/settings.md)

Key facts:
- All logic is `hook_theme_suggestions_HOOK()` / `_alter()` in `twigsuggest.module`, plus a global
  `twigsuggest_preprocess()` that sets a **`base_path`** variable on every template.
- Only setting: **`twigsuggest.settings:alternate_ds_suggestions`** (bool, normally set in
  `settings.php`) — enables the optional Display Suite layout-suggestion fix. No config/install
  ships, so the config object is absent until set.
- Service **`twigsuggest.helper_functions`** (`HelperFunctions::getCurrentNode()`) resolves the
  current node across canonical/preview/revision routes; used by the html/page suggestions.
- Also de-duplicates core block suggestions (`array_unique`).
