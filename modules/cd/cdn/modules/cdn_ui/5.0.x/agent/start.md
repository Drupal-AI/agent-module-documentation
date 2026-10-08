# CDN UI — agent index

The admin UI submodule for **CDN**. A single settings form that edits the `cdn.settings`
config object. Depends on `cdn`. No config or plugins of its own; can be uninstalled after
setup and the settings persist.

- **The form, its route, permission, and which config keys the tabs map to** →
  [configure/ui.md](configure/ui.md)

Parent module (CDN) docs: [../../../../5.0.x/agent/start.md](../../../../5.0.x/agent/start.md)
— see it for the full `cdn.settings` key/mapping reference.

Key facts: route `cdn_ui.settings` → `/admin/config/services/cdn`; permission
`administer CDN configuration`; form `Drupal\cdn_ui\Form\CdnSettingsForm` writes
`cdn.settings` (Status tab → `status`, Mapping tab → `mapping.type` / `mapping.domain`).
