<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration

## Routes

| Route | Path | Permission | Purpose |
|---|---|---|---|
| `migrate_source_ui.form` (the `configure` link) | `/admin/content/migrate_source_ui` | `access migrate source ui` | Upload a source file and run a migration. |
| `migrate_source_ui.settings` | `/admin/config/content/migrate_source_ui` | `administer migrate source ui` | Change the one setting below. |

Menu links appear under *Content* (the run form) and *Configuration → Content authoring*
(settings).

## The one setting

Config object **`migrate_source_ui.settings`**, single key:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `file_temp_directory` | string | unset/`null` | Directory (stream URI, e.g. `private://imports`) where uploaded source files are saved before the migration runs. When unset, `file_save_upload()` uses Drupal's **temporary** files scheme. |

```bash
drush cget migrate_source_ui.settings
drush cget migrate_source_ui.settings file_temp_directory
```

```php
// send uploads to a private directory
\Drupal::configFactory()->getEditable('migrate_source_ui.settings')
  ->set('file_temp_directory', 'private://migrate_uploads')
  ->save();
```

At run time the form reads this value; if `null` it passes `FALSE` to `file_save_upload()`
(temporary scheme), otherwise it `prepareDirectory()`s the resolved real path and saves there.

## What it does NOT configure

There is no place to define migrations here — Migrate Source UI only supplies the **source
file** for migrations that already exist (authored via `migrate_plus` config or a module). See
[../api/how-it-works.md](../api/how-it-works.md) for which migrations show up and how the run
executes.
