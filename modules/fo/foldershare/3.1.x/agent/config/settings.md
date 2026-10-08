<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin settings, config object, Drush, install

## Install & enable

```bash
composer require drupal/foldershare       # pulls jquery_ui_button, jquery_ui_menu
drush en foldershare -y
```

Core deps: `datetime, field, file, filter, image, link, media, options, system, text, user, views`.
`foldershare_requirements()` (`foldershare.install`) checks required PHP extensions and, at runtime,
the presence of a usable stream wrapper for the chosen file scheme. Install creates the `foldershare`
entity tables automatically plus two extra tables from `foldershare_schema()`:
`ManageContentType::getSchema()` (content-type usage) and `ManageUsageStatistics::getSchema()` (the
per-user usage report). On first login `hook_user_login` dispatches `UsersFolderCreateEvent` →
`UsersFolderCreateSubscriber` creates the user's home folder. Uninstall is handled by dedicated
confirm forms (`UninstallFolderShareConfirm`, `UninstallFolderShareScheduledTaskConfirm`) because the
entity/task graph is more complex than core's default cleanup.

## Settings form

Route `entity.foldershare.settings` → `/admin/structure/foldershare`, form `Form\AdminSettings`
(guarded by **`administer site configuration`**), split into tab traits under
`src/Form/AdminSettingsTraits/`: About, Files, Interface, Services. Note this settings route is the
`field_ui_base_route`, so *Manage fields/display* for the entity hang off it. A separate usage report
is at `/admin/reports/foldershare` (`Form\AdminUsageReport`, `administer foldershare`).

## Config object `foldershare.settings`

Read/written through `src/Settings.php`. Schema: `config/schema/foldershare.settings.yml`. Install
defaults: `config/install/foldershare.settings.yml`. Key values (default in parentheses):

| Key | Default | Meaning |
|---|---|---|
| `file_scheme` | **`public`** | Stream for stored files: `public`, `private`, or `s3`. Private is recommended. |
| `file_directory` | `foldersharefiles` | Subdirectory name within the stream. |
| `file_restrict_extensions` | **`false`** | Whether to enforce the allowed-extensions list on upload. |
| `file_allowed_extensions` | long list | Space-separated extensions allowed when restriction is on. |
| `file_upload_size_limit` | `0` | Max upload bytes; 0 = use the PHP limit. |
| `home_folder_name` / `recycle_folder_name` / `job_folder_name` | `homes` / `.trash` / `jobs` | Reserved folder names. |
| `command_menu_restrict` | `true` | Whether only allow-listed commands appear in menus. |
| `command_menu_allowed` | 18 commands | Allow-list of command plugin ids (change_owner, copy, delete*, download, duplicate, edit, move*, new_folder, open, release_share, rename, share, upload_files, recycle). |
| `activity_log` | `false` | Enable operation activity logging (`ManageLog`). |
| `usage_report_rebuild_interval` | `manual` | When to rebuild the usage table. |
| `search_*` | various | Search provider selection, index interval, file-content indexing, allowed extensions. |
| `user_autocomplete_style` | `name-only` | Share form user autocomplete style. |
| `lock_*_duration`, `scheduled_task_*_delay`, `*_time_limit_percentage`, `status_polling_interval` | numeric | Process-lock and background scheduled-task tuning. |
| `new_zip_archive_name` / `_comment`, `zip_unarchive_multiple_to_subfolder` | `Archive.zip` / … | ZIP archive/unarchive behavior. |
| `ui_command_menu`, `ui_ancestor_menu`, `ui_search_box`, `ui_folder_browser_*` | mostly `true`/`0` | Toggle UI regions of the browser. |

## Background tasks & cron

Long-running deletes/copies/moves are queued as `FolderShareScheduledTask` entities and serviced by
the `foldershare.scheduledtask.subscriber` event subscriber **after each page response** (not only at
cron), plus `hook_cron`. The README recommends running cron frequently from an external source rather
than Drupal's automated cron.

## Drush commands (`drush.services.yml` → `Commands\FolderShareCommands`)

| Command | Action |
|---|---|
| `foldershare:fsck` | Integrity check / repair of the file-folder tree. |
| `foldershare:deleteall` | Delete all FolderShare content. |
| `foldershare:locks` | Show current process locks. |
| `foldershare:tasks` | Show pending scheduled tasks. |
| `foldershare:version` | Report the module version. |

## Optional integrations

`comment` (comments on files/folders — optional config in `config/optional/`), `search` /
`search_api` / `search_api_autocomplete` (the `FolderShareSearch` plugin + search box),
`rest` (web-services access; `hook_rest_resource_alter`), `realname` (display names in the share
autocomplete), `field_ui` / `views_ui`. A default Views listing ships as
`views.view.foldershare_lists`.
