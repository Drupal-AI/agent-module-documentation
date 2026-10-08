# CDN UI — the settings form

CDN UI adds one admin form; it stores nothing of its own — it edits `cdn.settings` (owned by
the CDN module).

- **Route:** `cdn_ui.settings` → path `/admin/config/services/cdn`.
- **Form:** `Drupal\cdn_ui\Form\CdnSettingsForm` (id `cdn_settings`).
- **Permission:** `administer CDN configuration` (`restrict access: true`).
- **Menu link:** `cdn_ui.admin_overview` under `system.admin_config_services`
  (*Configuration → Web services → CDN integration*).
- **Editable config:** `cdn.settings`.

## Form structure (vertical tabs)

| Tab / field | Config target |
|---|---|
| **Status** → "Serve files from CDN" checkbox | `cdn.settings:status` |
| **Mapping** → "Mapping type" select (`simple`; `advanced` is a placeholder, not really supported by the UI) | `cdn.settings:mapping.type` |
| **Mapping** → CDN domain + condition preset (e.g. "everything except CSS & JS", `not: {extensions: [css, js]}`) | `cdn.settings:mapping.domain` / `mapping.conditions` |

Uses `#config_target` bindings, so field values map straight onto `cdn.settings` keys. The
far-future, scheme and stream-wrapper keys are not all surfaced in this form's tabs — set
those in `cdn.settings` directly (see the parent CDN module's configure doc).

## Notes

- Parent CDN module config reference: `../../../../../5.0.x/agent/configure/settings.md`.
- CDN UI can be **uninstalled after setup**: it holds no state, so removing it leaves
  `cdn.settings` untouched and the CDN module keeps working.
- To configure the CDN entirely without this UI, edit `cdn.settings` via drush/config
  (`drush config:set cdn.settings status true`, etc.).
