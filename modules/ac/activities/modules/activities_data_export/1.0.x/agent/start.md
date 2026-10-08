<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Activity Data Export — agent index

Submodule of **Activities**. Adds an admin Views **page** for the activity log plus a
downloadable **CSV/XLS export** of it. Pure glue — no config schema, services, permissions,
Drush, or plugins of its own (`configure` = null). Depends on `activities`, `rest`,
`views_data_export`, `xls_serialization`.

## What it installs

A single View, config `views.view.activity_log` (base table `user_activities`), with three
displays:

| Display id | Plugin | Path | Purpose |
|---|---|---|---|
| `default` | default | — | Base config (fields, bundle filter). |
| `page` | page | `admin/config/system/activity` | The "Activities Log" admin page. |
| `export` | data_export | `admin/config/system/activity/export` | Downloadable CSV/XLS export. |

- The log page uses the parent module's custom Views fields (`description_field`,
  `event_link`, `related_entity_link`) and the `all_bundles` filter.
- An action link "Export all activity log data for content" (route `view.activity_log.export`)
  appears on the log page.
- Menu link "Activities Log" → route `view.activity_log.page` under
  *Configuration → System*.
- `hook_uninstall` deletes `views.view.activity_log`.

Formats: CSV comes from `views_data_export`; XLS from `xls_serialization`. There are no other
docs for this submodule — everything is the one View above; edit it like any Views config
(`views.view.activity_log`).
