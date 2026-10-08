# Permissions

Defined in `animated_scroll_to.permissions.yml`.

| Permission | Machine name | Grants |
|-----------|--------------|--------|
| Administer animated scroll to | `administer animated scroll to` | Access the settings form at `/admin/config/animate-scroll-to/settings` (route `animated_scroll_to.settings`) to set defaults and toggle the two functionalities. |

This is the only permission. It is a configuration/administration permission — the scrolling
behavior itself runs for all site visitors once a functionality is enabled; no permission gates
the front-end effect. Grant it only to trusted roles (it is not marked `restrict access`, but it
edits site-wide config).

```bash
drush role:perm:add administrator 'administer animated scroll to'
```
