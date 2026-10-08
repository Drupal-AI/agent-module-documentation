# Site Alert — agent index

Displays site-wide alert banners (severity + optional scheduling) to all visitors via a block,
refreshed by AJAX so scheduled alerts appear/expire even on cached pages. Alerts are `site_alert`
content entities managed at `admin/config/system/site-alerts` (`configure` =
`entity.site_alert.collection`). Depends on core `datetime_range` + `options`.

- **The `site_alert` entity + its fields, the block/timeout setting, the AJAX refresh route, caching** →
  [configure/alerts.md](configure/alerts.md)
- **Drush commands `site-alert:create|delete|enable|disable`** → [drush/commands.md](drush/commands.md)
- **The `GetAlerts` service + entity API for reading active alerts in code** → [api/services.md](api/services.md)
- **The four permissions and the raw-markup trust note** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Entity `site_alert` (base table `site_alerts`); fields `label`, `active`, `severity` (low/medium/high), `message` (text_long), `scheduling` (daterange).
- Block plugin `site_alert_block`; setting `timeout` (int, default 300s; 0 = no polling). Schema `block.settings.site_alert_block`.
- AJAX route `site_alert.ajax` → `/ajax/site_alert` (`_access: TRUE`, `_maintenance_access: TRUE`), controller returns rendered active alerts.
- Message is output as raw `#markup` (no filter format) — add/update perms are trusted-author.
