<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Statistics — permissions

Defined in `statistics.permissions.yml`. Two permissions:

| Permission | Machine name | Gates |
|---|---|---|
| Administer statistics | `administer statistics` | Access to the settings form at `/admin/config/system/statistics` (route `statistics.settings`), i.e. toggling `count_content_views`. |
| View content hits | `view post access counter` | Seeing the per-node "N views" counter link that `statistics_node_links_alter()` adds under nodes. Without it the counter is hidden even when counting is on. |

Neither permission is required to *record* a view — counting happens for anonymous visitors via
the front-end `statistics.php` endpoint whenever `count_content_views` is enabled. These
permissions only gate **administration** and **display** of the numbers.

Grant from the CLI:

```bash
drush role:perm:add anonymous 'view post access counter'
drush role:perm:add content_editor 'administer statistics'
```
