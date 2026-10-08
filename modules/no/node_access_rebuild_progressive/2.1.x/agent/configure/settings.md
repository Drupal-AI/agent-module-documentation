<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings

Config object: **`node_access_rebuild_progressive.settings`** (schema: `config_object`).

| Key | Type | Default | Meaning |
|---|---|---|---|
| `cron` | boolean | `false` | Process a chunk of the rebuild on each cron run when a rebuild is pending. |
| `chunk` | integer | `500` | Number of nodes processed per pass (per cron run or per Drush loop iteration). |

> The README mentions a default of 200, but the shipped `config/install` default is **500**.

Settings form: **`/admin/config/development/node-access-rebuild-progressive`**
(route `node_access_rebuild_progressive.settings`, form
`NodeAccessRebuildProgressiveSettingsForm`, permission `administer site configuration`).
The form validates that `chunk` is a positive integer. `configure` is **not** declared in
`node_access_rebuild_progressive.info.yml`, so there is no `configure` route in `data.json`
(the settings link is registered via `node_access_rebuild_progressive.links.menu.yml`).

## Read / set via Drush

```bash
drush cget node_access_rebuild_progressive.settings
drush cset node_access_rebuild_progressive.settings chunk 100 -y
drush cset node_access_rebuild_progressive.settings cron true -y
```

## Guidance

- Smaller `chunk` = less memory per pass, more passes (safer on constrained hosts).
- Larger `chunk` = fewer passes, more memory/time per pass.
- `cron: true` is recommended only when cron is run via Drush (long-running).

## Core rebuild form is disabled

This module implements `hook_form_node_configure_rebuild_confirm_alter()` to **disable**
Drupal core's "Rebuild permissions" form (`/admin/reports/status/rebuild`). The form is set
`#disabled` and its text is replaced with instructions to run
`drush node-access-rebuild-progressive` (and `--resume` for an interrupted rebuild). If
`cron` is enabled, it also notes the rebuild will proceed incrementally on cron.
