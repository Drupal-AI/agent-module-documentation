<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Ignore Webform — mechanism, config, routes

## Install / enable

```bash
composer require drupal/config_ignore_webform
drush en config_ignore_webform -y
```

Pulls in and enables `config_ignore` (`^3`) and `webform` (`^6`). No update hooks; nothing to run
after enabling. Works out of the box: once enabled, all webform config is ignored (see below) even
before you open the settings form.

## How the ignore is applied

Service `Drupal\config_ignore_webform\WebformTemplateConfigIgnore` (`src/WebformTemplateConfigIgnore.php`),
constructed with `@config.storage` (active), `@config.storage.sync`, and `@config.factory`.

`alterIgnored(ConfigIgnoreConfig $ignored)` runs from `hook_config_ignore_ignored_alter()`:

1. Base patterns always added: `webform.webform.*` and `webform.webform_options.*`.
2. Exception patterns (each prefixed with `~`, which is Config Ignore's "force-include / do not
   ignore" marker) are merged from three sources:
   - `getTemplateExceptionPatterns()` — iterates **both** active and sync storage, `listAll('webform.webform.')`,
     reads each and, when `data['template']` is truthy, emits `~webform.webform.{id}`. Checking both
     storages means a template is exported from active and imported from sync even if it currently
     exists in only one.
   - `getConfiguredWebformExceptionPatterns()` → `~webform.webform.{id}` for each id in
     settings key `excluded_webforms`.
   - `getConfiguredWebformOptionsExceptionPatterns()` → `~webform.webform_options.{id}` for each id in
     settings key `excluded_webform_options`.
3. For every `direction` (`import`, `export`) × `operation` (`create`, `update`, `delete`), the base
   patterns and exceptions are appended to `$ignored->getList(...)` (dedup via `in_array`), then
   written back with `setList()`.

`getConfiguredExceptionPatterns($settingsKey, $configPrefix)` reads the active
`config_ignore_webform.settings` via the config factory **and** merges any IDs found in the same object
in **sync** storage. That lets allowlisted IDs staged in the sync directory take effect during a config
import before the settings object itself has been imported. Non-string / empty ids are skipped.

Net effect: editors can freely create and edit webforms and option lists on production without a later
`drush config:import` reverting them — except webform templates (always synced) and any item you
explicitly allowlist.

## Settings form

`Drupal\config_ignore_webform\Form\WebformConfigIgnoreSettingsForm` (`ConfigFormBase`), form id
`config_ignore_webform_settings`, editable config `config_ignore_webform.settings`.

- `excluded_webforms` — checkboxes of all **non-template** webforms (`WebformInterface::isTemplate()`
  filtered out), labelled `@title (@id)`, natcase-sorted. Uses a `ConfigTarget` that stores the config
  as a plain list of ids (`array_values(array_filter($value))`).
- `excluded_webform_options` — checkboxes of all `webform_options` entities, same storage shape.
- Checked = "still sync this item" (added as a `~` exception); unchecked = ignored/protected.
- Empty-state descriptions when no webforms / options exist.

## Routes & access

| Route | Path | Permission |
|-------|------|------------|
| `config_ignore_webform.settings` | `/admin/config/development/configuration/webform-ignore` | `administer webform` |
| `config_ignore_webform.settings_webform` | `/admin/structure/webform/config/ignore` | `administer webform` |

Both routes render the same form. Menu link `config_ignore_webform.settings` sits under
`config.sync`; local tasks (`*.links.task.yml`) place tabs on both config-sync and the Webform
collection. `administer webform` is Webform's own top-level admin permission.

## Config object

`config_ignore_webform.settings` (schema `config/schema/config_ignore_webform.schema.yml`):

```yaml
excluded_webforms: []            # sequence of webform ids that should still sync
excluded_webform_options: []     # sequence of webform_options ids that should still sync
```

Install default (`config/install/`) is empty for both — meaning only templates are excepted until you
allowlist more.
