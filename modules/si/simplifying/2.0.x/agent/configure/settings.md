# Configure Simplifying

Everything lives in the single config object **`simplifying.settings`**. UI at
`/admin/config/development/simplifying` (route `simplifying.settings`, permission
`access simplifying setting`). Read/write with `drush config:get simplifying.settings` /
`drush config:set`, or via the `simplifying.settings` service
(`SettingsActions::getSettings($key)` / `setSettings($key, $value)`).

Defaults are hardcoded in `SettingsActions::getDefaultsSettings()` and used when a key is unset.

## Config keys (`simplifying.settings`)

- `design` (mapping): toolbar look — `small_button` (int), `top_background`, `top_color`,
  `submenu_background` (hex color strings). Defaults `#50ab09` / `#ffe30b` / `#d6e1ea`.
- `toolbar_tabs` (mapping): per-tab visibility flags — keys `home`, `administration`, `shortcuts`,
  `user`, `devel`, `contextual`, `administration-search`. A truthy string value = hide that tab
  (default hides `devel`).
- `menu_links` (sequence of strings): admin menu-link **paths** to hide from the toolbar menu
  (e.g. `admin/modules`, `admin/config`, `admin/flush/views`). Applied in `hook_preprocess_menu__toolbar`.
- `entity_fields` (mapping): fields to hide on entity forms, grouped by type —
  `nodes` (author, format, options, revision_information, url_redirects, menu, path, simple_sitemap,
  drupal_seo), `users` (format, status, notify, roles, path), `comments` (format),
  `taxonomy` (format, relations, path, simple_sitemap, tvi), `blocks` (format, revision_information).
  A truthy value hides that field/group on the matching entity form via `EntityFields::hideFields()`.
- `entity_field_groups` (mapping): auto-detected "advanced" field-group metadata (`title`, `path`).
- `local_tasks` (mapping): `show_triggers` (bool — render the per-tab hide/show buttons) and
  `hidden_tabs` (sequence of local-task route keys to prune via `hook_menu_local_tasks_alter`).
- `contextual_links` (sequence of route names): contextual (pencil) links to remove
  (`hook_contextual_links_view_alter`). `contextual_links_list` holds the discovered candidate list.
- `basket_menu` (sequence): admin menu link IDs for the optional contrib `basket` module integration.

## Full-administration bypass (cookie)

`SettingsActions::isFullAdministration()` returns `!empty($_COOKIE['simplifying'])`. When that
browser cookie is present, tab/field/contextual hiding is skipped and the full admin UI is shown.
This is a per-browser convenience toggle (set client-side via the `js_cookie` library), not a
server-side permission. Cache is varied on the `cookies:simplifying` context.

## Notes

- `hook_module_implements_alter` forces Simplifying's `form_*_alter` to run **last** so it can hide
  fields other modules just added.
- Settings values were historically serialized; `SettingsActions::maybeUnserialize()` and update
  `simplifying_update_8003` convert legacy scalar/serialized values to native arrays.
- `configure` route target is `simplifying.settings`; also exposes static pages
  `simplifying.services` (`/admin/services`) and `simplifying.training` (`/admin/training`).
