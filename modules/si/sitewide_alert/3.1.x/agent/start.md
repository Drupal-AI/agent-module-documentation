<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sitewide Alert — agent index

Displays dismissible alert banners at the top of all pages. Each alert is a
`sitewide_alert` **content entity** (fieldable, revisionable, translatable),
managed at Admin > Content > "Sitewide alerts" (`entity.sitewide_alert.collection`).
Global settings live at `/admin/config/sitewide_alerts`.

Entity type id: `sitewide_alert`. Key fields: `name` (admin label, entity label key),
`message` (text_long, the banner body), `status` (boolean "Active"/published),
`style` (list_string, allowed values from the settings' style list, e.g. `primary`),
`dismissible` (boolean), `scheduled_alert` + `scheduled_date` (daterange),
`limit_to_pages` + `limit_to_pages_negate` (page visibility).

- Global settings, styles, styling keys, config form → [configure/sitewide_alert.md](configure/sitewide_alert.md)
- Create / load / inspect alert entities in PHP → [api/sitewide_alert.md](api/sitewide_alert.md)
- Drush commands (create/delete/enable/disable) → [drush/sitewide_alert.md](drush/sitewide_alert.md)
- Permissions that gate alerts → [permissions/sitewide_alert.md](permissions/sitewide_alert.md)

Submodules (nested): `sitewide_alert_block` (render alerts in a block),
`sitewide_alert_domain` (scope alerts per domain).
