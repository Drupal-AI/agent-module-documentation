# Hotjar — configuration

## Settings form

- Route: `hotjar.admin_settings_form`
- Path: `/admin/config/system/hotjar`
- Permission: `administer hotjar`
- Class: `Drupal\hotjar\Form\HotjarAdminSettingsForm`

## Config object: `hotjar.settings`

Defaults ship in `config/install/hotjar.settings.yml`. Keys (schema in
`config/schema/hotjar.schema.yml`):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `account` | string | `''` | **Hotjar ID (`hjid`)**. No snippet is output while empty. |
| `snippet_version` | int | `6` | Hotjar embed version (`hjsv`). |
| `attachment_mode` | string | `build` | `build` = write JS file + `<script src>`; `drupal_settings` = pass ID via `drupalSettings` + `hotjar/hotjar` library. |
| `snippet_path` | string | `public://hotjar/hotjar.script.js` | where the generated JS file is written (build mode). |
| `visibility_pages` | int | `0` | `0` = every page **except** `pages`; `1` = **only** `pages`; `2` = nowhere. |
| `pages` | string | admin/batch/node-add/etc list (see below) | newline-separated path patterns. |
| `visibility_roles` | int | `0` | `0` = if `roles` selected, track **only** those; `1` = track all **except** selected. (Empty `roles` = all roles.) |
| `roles` | sequence | `{}` | selected role ids. |

Default `pages`:

```
/admin
/admin/*
/batch
/node/add*
/node/*/*
/user/*/*
```

Note: `HotjarSettings::getSettings()` reads `config->getOriginal()` and back-fills any missing
keys with the interface defaults (`HotjarSettingsInterface::HOTJAR_*`), then runs
`hook_hotjar_settings_alter()`.

## drush snippets

```bash
drush config:get hotjar.settings

# set the Hotjar ID and regenerate the snippet file
drush config:set hotjar.settings account 1234567 -y
drush cr     # hook_rebuild() rewrites public://hotjar/hotjar.script.js

# only track two landing pages
drush config:set hotjar.settings visibility_pages 1 -y
drush config:set hotjar.settings pages "/landing\n/promo" -y
```

## Visibility logic (summary)

`hotjar.access` grants output only when **all** of these hold:
1. `account` is non-empty.
2. HTTP status is not 403/404.
3. **Path** passes `visibility_pages` against `pages` (current path *and* its alias are matched).
4. **Role** passes `visibility_roles` against `roles` (empty selection ⇒ all roles allowed).
5. Cookie-consent check (eu_cookie_compliance) does not forbid it.
6. No `hook_hotjar_access[_alter]` implementation forbids it.

## Permission

```yaml
administer hotjar:
  title: 'Administer Hotjar'
  description: 'Perform maintenance tasks for Hotjar.'
```

Gates the settings form only; it does **not** control whether a visitor is tracked (that is the
visibility settings above).
