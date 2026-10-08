<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Shows an important site-wide emergency alert — as a placeable block and/or a full-page banner — with configurable title, message and severity level.

---

Emergency Alerts is aimed at the kind of high-priority announcement often seen at the top of academic or public-sector sites. Editors configure a single active alert at `/admin/config/emergency_alerts` (route `emergency_alerts.settings`, permission `administer emergency_alerts`): a title, a rich-text message, and an alert level rendered as CSS classes `.emergency-alert.announcement|warning|danger`. The alert is exposed as an `EmergencyAlert` block plugin that can be placed in any region (e.g. a theme's `emergency_alert` region). A dismissible behaviour is provided by the `persist_close` JS library, which remembers a closed alert.

When the `override` setting is enabled, `hook_theme_suggestions_html_alter()` injects a full-page template suggestion (`html__emergency_alert`) on non-admin routes, promoting the alert's title/message/level into the page template so the alert can take over the whole page for critical situations. The module ships `emergency-alert.html.twig` and `html--emergency-alert.html.twig` templates plus a `hook_theme()` definition; themes are expected to copy and style these. The message value is stored as rich text and rendered as markup, so the configured message is trusted admin content — restrict the `administer emergency_alerts` permission accordingly.

---

- Display a site-wide emergency alert banner.
- Place the Emergency Alert block in any region.
- Show an announcement-level (info) notice.
- Show a warning-level alert.
- Show a danger-level (critical) alert.
- Set the alert title and rich-text message.
- Take over the full page with the override mode.
- Suppress the override on admin routes automatically.
- Let visitors dismiss the alert (persist-close JS).
- Remember a closed alert across page loads.
- Add an `emergency_alert` region to a theme for the banner.
- Copy and restyle the alert Twig templates.
- Style severity via `.emergency-alert.announcement/warning/danger`.
- Gate configuration behind `administer emergency_alerts`.
- Publish a weather/closure notice on a campus site.
- Post a service-outage banner across the site.
- Toggle the alert on/off from one settings form.
- Keep the alert out of the admin UI.
- Integrate the block with block visibility rules.
- Provide an accessible top-of-page announcement.
- Quickly broadcast an urgent message during an incident.