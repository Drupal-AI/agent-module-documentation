<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity 404 — configuration

## Install / enable

`composer require drupal/entity_404` then enable `entity_404`. No module dependencies
(`entity_404.info.yml` declares none); `HasTranslation` uses the core `content_translation` /
`language` classes only when present. Core `^10.1 || ^11 || ^12`.

## Config object

`entity_404.settings` (simple config, type `config_object`). Two booleans, each enabling one
check (see `mechanism/access-and-404.md`):

| Key | Enables | Install default |
| --- | --- | --- |
| `no_full_view` | 404 an entity whose bundle has no `full` view mode | `true` |
| `no_translation` | 404 an entity not translated in the current/fallback language | `true` |

- Install defaults: `config/install/entity_404.settings.yml`.
- Schema: `config/schema/entity_404.settings.schema.yml` (both keys `type: boolean`).
- Update hook `entity_404_update_10101` (in `entity_404.install`) seeds these keys on sites
  upgrading from a version before the settings existed (`no_full_view: TRUE`,
  `no_translation: FALSE`).

A check that is disabled here returns `allowed()` from its access check (with cache tag
`config:entity_404.settings`), so the entity page renders normally.

## Settings form

- Class `src/Form/SettingsForm.php` (`ConfigFormBase`, form id `entity_404_settings_form`).
- Route `entity_404.admin.settings` at `/admin/config/system/entity-404`
  (`entity_404.routing.yml`), permission `configure entity 404`
  (`entity_404.permissions.yml`). Menu link under *Configuration → System*
  (`entity_404.links.menu.yml`).
- Two checkboxes ("Full view mode" → `no_full_view`, "Translation" → `no_translation`) inside a
  `404_if` details group; each uses `#config_target` so core writes the config. `getEditableConfigNames()`
  returns `['entity_404.settings']`.

## Notes

- Applies automatically to every content-entity canonical route; there is no per-type/per-bundle
  toggle in config — scope is all-or-per-check.
- `HasTranslation` walks language fallback candidates (via `LanguageHooks`), so an entity
  reachable through a configured fallback translation is not 404'd.
