<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Sitewide Alert

Global settings form: **`/admin/config/sitewide_alerts`** (route
`entity.sitewide_alert.config_form`, permission `administer sitewide alert`).
All values are stored in the simple config object **`sitewide_alert.settings`**.

## Settings keys (defaults from `config/install/sitewide_alert.settings.yml`)

| Key | Default | Meaning |
|---|---|---|
| `alert_styles` | `primary\|Default` | Newline-separated `machine_key\|Human label` list of the styles offered by the alert `style` field. Add lines like `info\|Information` and `danger\|Danger`. |
| `show_on_admin` | `false` | Whether alerts also show on admin pages. |
| `show_count` | `false` | Show an unread/updated-alert count to visitors. |
| `display_order` | `ascending` | Stacking order when several alerts are active (`ascending`/`descending`). |
| `refresh_interval` | `15` | Seconds between client-side polls of `/sitewide_alert/load`. |
| `automatic_refresh` | `true` | Whether the client auto-refreshes alerts. |
| `cache_max_age` | `15` | Max-age (seconds) for the alert JSON response. |
| `server_side_render` | `false` | Render alerts server-side (works without JavaScript) instead of via JS injection. |
| `show_untranslated` | `false` | Show alerts that have no translation in the current language. |

## Read / write settings

```bash
drush config:get sitewide_alert.settings
# add two more styles (info + danger) alongside the default:
drush config:set sitewide_alert.settings alert_styles "primary|Default
info|Information
danger|Danger" -y
```

The `style` field's allowed values are computed at runtime from `alert_styles` by
`\Drupal\sitewide_alert\AlertStyleProvider::alertStyles()` — each non-empty
`key|Label` line becomes one selectable style. A line with no `|` uses the text as
both key (CSS-cleaned) and label. So to make a new style selectable on the alert
form you only edit this config, no code.

## The alert entities themselves

Individual alerts are **content entities**, not config — create/edit them at
Admin > Content > "Sitewide alerts" (`/admin/content/sitewide_alert`, add form
`/admin/content/sitewide_alert/add`). Per-alert fields (name, message, active,
style, dismissible, scheduling, page targeting) are documented in
[../api/sitewide_alert.md](../api/sitewide_alert.md).
