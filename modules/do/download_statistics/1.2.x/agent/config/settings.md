<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & settings

## Install & enable

```bash
composer require drupal/download_statistics
drush en download_statistics -y
```

Dependencies are core only: `node`, `field`, `file`. No third-party Composer/PHP libraries, no
Drush commands. Counting works **only for files on the private file system** (public files are
served by the web server, bypassing Drupal), so a private directory must be configured in
`settings.php` and the tracked file fields set to the *Private files* upload destination.

## Settings form

- Route `download_statistics.settings` → **`/admin/config/system/download-statistics`**
  (menu item under *Configuration → System*, `download_statistics.links.menu.yml`).
- Permission: **`administer download statistics`**.
- Form class `DownloadStatisticsSettingsForm` (extends `ConfigFormBase`, id
  `download_statistics_settings_form`), editing config `download_statistics.settings`.

Two checkboxes (`buildForm()`):

| Field | Config key written | Notes |
|---|---|---|
| **Count file downloads** | `count_file_downloads` | Master on/off. Enabling/disabling flips which routes/plugins exist. |
| **Clear Downloads Statistics** | *(action, not stored)* | **Default value is 1 (checked).** On submit, if set, calls `statisticsStorage->deleteAllDownloads()` — truncates the whole `download_statistics` table. |

`submitForm()` behavior:

- Saves `count_file_downloads`.
- If `block` module is on, clears block plugin definitions (`blockManager->clearCachedDefinitions()`)
  so the Popular block appears/disappears.
- If the "Clear" checkbox is set, deletes all download rows.
- If `count_file_downloads` **changed**, runs `drupal_flush_all_caches()` (so route subscriber,
  formatters, tokens, Views data and block_alter re-register). The form description warns:
  "changing this value will result in total cache flush".

## Config object & schema

`config/install/download_statistics.settings.yml`:

```yaml
count_file_downloads: 0
display_max_age: 3600
```

Schema `config/schema/download_statistics.schema.yml`:

- `download_statistics.settings` (`config_object`): `count_file_downloads` (boolean),
  `display_max_age` (integer — "how long any download statistics may be cached / refresh interval").
- `block.settings.download_statistics_popular_block` (`block_settings`): `top_day_num`,
  `top_all_num`, `last_download` (all integer).
- Views plugin schema in `config/schema/download_statistics.views.schema.yml`:
  `views.field.download_statistics_numeric` (→ `views.field.numeric`) and
  `views.field.download_statistics_timestamp` (→ `views.field.date`).

## Permissions (`download_statistics.permissions.yml`)

- **`administer download statistics`** — the settings form + clearing counts.
- **`view file download statistics`** — required to see counts: gates the Popular block
  (`blockAccess()`), the two Views field handlers (`access()`), and is the permission the help text
  tells admins to grant so counters are visible.

## Turn-on checklist

1. Configure a private file system and set tracked file fields to *Private files*.
2. Enable **Count file downloads** at `/admin/config/system/download-statistics`
   (uncheck *Clear Downloads Statistics* if you don't want the table wiped on save).
3. Mark files for counting: set a file field's format to **File with Download Statistics recorded**
   (Manage display) and/or use the **File URI with Download Count** URI formatter in Views, and/or
   place the **Popular file downloads** block.
4. Grant **View file download statistics** to the roles that should see counts.
