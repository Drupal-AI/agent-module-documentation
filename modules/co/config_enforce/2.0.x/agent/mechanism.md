<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# config_enforce — mechanism

## Enforcement levels

Constants on `\Drupal\config_enforce\ConfigEnforcer`:

| Value | Constant | Label | Effect |
|------|----------|-------|--------|
| `0`  | `CONFIG_ENFORCE_OFF`      | Allow form & API updates | No enforcement. |
| `10` | `CONFIG_ENFORCE_NOSUBMIT` | Allow only API updates    | Config form fields disabled + `#submit` cleared (UI cannot write); programmatic config saves still allowed. |
| `20` | `CONFIG_ENFORCE_READONLY` | Read-only, no updates     | As `10`, plus the config is re-imported from the on-disk YAML when it has drifted from active config. |

`EnforceFormHandler::MINIMUM_ENFORCE_LEVEL = 10`, so any level ≥ 10 disables the form.
Only level `20` is re-imported by `enforceConfigs()`.

## Config forms (form_alter path)

`config_enforce.module` implements `hook_form_alter` and hands every form to
`\Drupal\config_enforce\FormHandler\EnforceFormHandler::alter()`. Module weight is set to `1000` in
`hook_install`, so this alter runs among the last.

`EnforceFormHandler`:
1. `ConfigResolver` determines the config names the form edits (see below); if none, or the form ID is
   on the denylist, it does nothing.
2. Adds a `config_enforce_indicator` render element per config name (a collapsible "Enforcement
   settings for: …" details block, styled by `css/config-enforce.css`). Indicators are shown only when
   the config is enforced, or when `config_enforce_devel` is enabled.
3. If any related config is enforced at level ≥ 10, it adds a warning (`Configuration from this form is
   being enforced. Any changes may be lost.`), recursively sets `disabled`/`readonly` on all form
   fields, and empties `$form['#submit']`.

Devel escape hatch: when `config_enforce_devel` is installed, `shouldEnforceForm()` returns FALSE for
every form, keeping all config forms editable so developers can author enforcement.

### How forms are resolved to config names (`ConfigResolver`)

`getConfigNames()` collects config object names from the form object obtained via
`$form_state->getBuildInfo()['callback_object']`, covering:
- **Simple config forms** — objects with `getEditableConfigNames()` (invoked via reflection).
- **Config entity forms** — objects with `getEntity()` whose entity has `getConfigDependencyName()`
  (skips new/unsaved entities and content entities).
- **Config entity list builders** — `ConfigEntityListBuilder` forms, via `load()`.
- **Plugin config entities** in form-state storage (`ConfigEntityStorageInterface` /
  `ConfigEntityInterface`), excluding `EntityFormDisplayInterface` on add/edit content forms.
- **Field storage definitions** — entities with `getFieldStorageDefinition()`.

## Re-import (enforceConfigs)

`hook_rebuild()` (fires on cache rebuild / `drush cr`) runs `(new ConfigEnforcer())->enforceConfigs()`
when the `cache_rebuild` trigger is enabled (the default). It returns early in maintenance mode.
`ConfigEnforcer::enforceConfigs(bool $only_optional = FALSE)`:
1. `readRegistriesFromDisk()` — scans **every enabled module's** `config/install` for
   `config_enforce.registry.<module>.yml` and re-imports those registry objects, so registries in
   active config always match code; then resets the static cache.
2. For each enforced config (registries excluded): skip unless `enforcement_level >= 20`; if
   `$only_optional`, skip anything not in `config/optional`; compare the stored base64 `hash` against a
   hash of the current active config (`Crypt::hashBase64`, with `uuid`/`_core` stripped except for
   `system.site`); if changed, queue the on-disk file for import.
3. `ConfigImporter::importConfig()` replaces just those objects in a `StorageReplaceDataWrapper` over
   active storage, builds a `StorageComparer`, and runs core's `ConfigImporter` sync steps. `system.site`
   is special-cased so the incoming `uuid` matches the live site UUID.

Because import uses the full core config-import pipeline, only the specific enforced objects are diffed
and applied — unrelated active config is left untouched.

## Settings form / triggers

Route `config_enforce.settings` → `\Drupal\config_enforce\Form\SettingsForm` at
`/admin/config/development/config_enforce`, permission `administer site configuration`. It exposes a
single "Trigger enforcement on:" checkboxes element (only option today: **Cache rebuild**), saved to
`config_enforce.settings:triggers`. Default (`SettingsForm::DEFAULT_TRIGGERS`) is `cache_rebuild` on.
