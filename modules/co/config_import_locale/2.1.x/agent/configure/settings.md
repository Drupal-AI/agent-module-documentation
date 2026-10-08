<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure interface-translation behaviour on config import

Form at **`/admin/config/regional/translate/config-import-settings`** (route
`config_import_locale.settings`, tab under *Translate interface*), permission
**`administer config import locale`**. Form class `src/Form/ConfigImportSettingsForm.php`; config object
`config_import_locale.settings`.

## Settings

| Key | Values | Meaning |
|---|---|---|
| `overwrite_interface_translation` | `default` | Core behaviour — interface translations **may be overwritten** if the string is imported via config import. |
| | `no_overwrite` | Existing interface translations are **kept**; only brand-new translations may be added. |
| | `nothing` | Config imports **never** add or change interface translations. |
| `overwrite_context` | `cli` | Apply the chosen behaviour **only** when running under CLI (e.g. `drush config:import`). |
| | `ui` | Apply **only** in the web UI. |
| | *(empty / "Everywhere")* | Apply in all contexts. |

When the running context does not match `overwrite_context`, behaviour falls back to core `default`.

> The form also renders an `overwrite_config_translation` radio (`default` | `nothing`), but only
> `overwrite_interface_translation` and `overwrite_context` are covered by config schema and consumed by
> the subscriber. Also note `ConfigImportLocaleSubscriber` reads the context from a config key
> `overwrite_mode` (not `overwrite_context`); treat the CLI/UI limiting as best-effort and verify on your
> version before relying on it.

## Set it with drush

```bash
ddev drush cset config_import_locale.settings overwrite_interface_translation no_overwrite -y
ddev drush cset config_import_locale.settings overwrite_context cli -y
```

## How it takes effect (service override)

`src/ConfigImportLocaleServiceProvider.php` (`alter()`) changes the class of two core services:

- `locale.config_subscriber` → `Drupal\config_import_locale\ConfigImportLocaleSubscriber`
- `locale.config_manager` → `Drupal\config_import_locale\ConfigImportLocaleConfigManager`

The subscriber overrides `saveCustomizedTranslation()`:
- `no_overwrite` → `saveCustomizedTranslationNoOverwrite()`: writes a translation only when there is no
  existing (non-empty) one and the source differs from the new translation.
- `nothing` → does nothing.
- `default` (or context mismatch) → calls core's `parent::saveCustomizedTranslation()`.

Because it replaces core services, clear caches (`drush cr`) after enabling so the container rebuilds.
No custom code is needed to extend it — adjust behaviour purely through the two config values.
