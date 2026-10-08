<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drift - Communication Tool (drift) — agent index

Thin integration that embeds the hosted **Drift.com** live-chat / conversational-marketing widget
on a site's front-end pages. Package `Drift`. No module dependencies (library only `core/drupal`).
Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version dir 2.0.x (installed 2.0.1).

- **Settings form, config object + schema, the route/permission, and exactly how the Drift snippet
  is injected** → [config/settings.md](config/settings.md)

## What it actually is (from source)

- One config form: `DriftSettingsForm` (`src/Form/DriftSettingsForm.php`, form id
  `drift_admin_settings`), extending core `ConfigFormBase`. Two fields: `status` (Enabled/Disabled
  select) and `identifier` (textfield, the Drift account/embed ID).
- One route: `drift.config` → `/admin/config/services/drift`, requirement
  `_permission: 'administer drift configuration'` (defined in `drift.permissions.yml`).
- One admin menu link: `drift.configuration.collection` under `system.admin_config_services`
  (`drift.links.menu.yml`).
- Config object `drift.settings` (keys `status` int, `identifier` text); install default
  `status: 0`, `identifier: ''`; schema in `config/schema/drift.schema.yml`.
- Injection: `drift_page_attachments()` (`hook_page_attachments` in `drift.module`) — on **non-admin
  routes only** (checks `router.admin_context`), if `status` is truthy and `identifier` non-empty,
  attaches library `drift/drift` and sets `drupalSettings.drift.identifier`.
- Asset library `drift/drift` = `js/script.js` (`drift.libraries.yml`), a `Drupal.behaviors`
  wrapper around Drift's standard loader snippet that loads
  `https://js.driftt.com/include/<ts>/<identifier>.js`.
- No entities, no plugins, no services, no Drush, no submodules, no `.install`. Provides one
  permission and config schema.

## Notes

- Embeds Drift's third-party JS which tracks visitors / sets cookies — pair with a cookie-consent
  solution and disclose in your privacy policy; chat data is handled by Drift.com.
- Saving the form flushes the JS asset cache (`asset.js.collection_optimizer` + query-string reset)
  so a new identifier takes effect immediately.
- The widget never renders on admin routes by design.
