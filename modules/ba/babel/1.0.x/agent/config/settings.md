<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Babel — install, routes, permissions, config, DB tables

## Install
`drush en babel`. Requires core `locale`. Composer pulls `phpoffice/phpspreadsheet ^5.0` (needed by the
`spreadsheet` data-transfer plugin) and `ext-pdo`. On install (`babel_install()` in `babel.install`) a
batch imports existing Locale source strings and processes all configuration strings into the Babel index
(webform configs excluded). Uninstall drops the three tables below.

## Routes (`babel.routing.yml`)
| Route | Path | Handler | Permission |
|-------|------|---------|------------|
| `babel.ui` | `/admin/config/regional/babel/{language}` | `Form\BabelTranslateForm` | `translate interface` |
| `babel.ui_pager` | `/babel/pager/{js}/{language}` | `Controller\UiPager::updatePerPagination` | `translate interface` |
| `babel.export` | `/admin/config/regional/babel/export` | `Form\BabelExportForm` | `translate interface` |
| `babel.import` | `/admin/config/regional/babel/import` | `Form\BabelImportForm` | `translate interface` |
| `babel.settings` | `/admin/config/regional/babel/settings` | `Form\BabelSettingsForm` | `language manager` |

`{language}` upcasts to a `configurable_language` entity (nullable → a language selector is shown).
A "Translate" toolbar tab (`Hook\BabelHooks::toolbar`) opens `babel.ui` as a modal for the current
language; it is only shown to users with `translate interface`.

**Permission note:** `translate interface` is core Locale's permission. `language manager` is referenced
by `babel.settings` (and `babel_content_entity.settings`) but is **not declared** by core or Babel — no
`babel.permissions.yml` exists and no `permission_callbacks` defines it. As a result the settings forms are
reachable only by UID 1 (admin bypass). This is an alpha oversight; grant/define access accordingly.

## Config object `babel.settings`
Default install (`config/install/babel.settings.yml`):
```yaml
data_transfer:
  destination: public://babel
```
Editable keys (schema `config/schema/babel.schema.yml`):
- `data_transfer.destination` (`uri`) — stream-wrapper directory for exported files. Validated by
  `BabelSettingsForm::validateForm` against the stream wrapper manager; use `private://…` for restricted
  access. Required.
- `data_transfer.prefix` (`string`, nullable, ≤25 chars) — optional filename prefix. Run through
  `BabelSettingsForm::sanitizeFileNamePrefix()` (transliterate → lowercase → strip non-alphanumerics).
  Export filename pattern: `[prefix]-[langcode].[ext]` or `[langcode].[ext]`.
- `translation_type.plugin.<id>` and `data_transfer.plugin.<id>` — per-plugin configuration sequences.
  The settings form embeds each plugin's `PluginFormInterface` config subform (plugins without one show
  "not configurable"). Schema types `translation_type.*` / `data_transfer.*` default to empty mappings;
  a plugin can declare `translation_type.<id>` / `data_transfer.<id>` for its own schema.

`BabelSettingsForm` is a `ConfigFormBase` (`getEditableConfigNames()` → `['babel.settings']`) using the
`#config_target` mechanism. `babel_tmgmt` and `babel_content_entity` alter/extend this form (see submodule docs).

## Database tables (`babel_schema()` in `babel.install`)
- `babel_source` — one row per unique source string: `hash` (64-char sha, PK), `status` (tinyint, active
  flag, default 1), `sort_key`. Indexed on `status`, `sort_key`.
- `babel_source_instance` — maps a source `hash` to each backend occurrence: `plugin`, `id`
  (≤512 chars), `hash`. PK `(plugin, id)`, index on `hash`. One hash can have many instances (same string
  from many places).
- `babel_source_lock` — per-language manual-translation lock: `hash`, `langcode`. PK `(hash, langcode)`.

Update hooks `babel_update_8001`–`8004` migrate locale IDs, add the lock table, move config handling to the
`config` plugin, and normalise sort keys. All DB access uses parameterised queries.
