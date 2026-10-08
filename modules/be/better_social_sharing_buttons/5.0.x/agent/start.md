# better_social_sharing_buttons — agent start

Tracker-free social share buttons for Drupal, rendered from an inlined SVG sprite. Ships a
block, a node/paragraph pseudo-field, and one global settings form. No module dependencies.
Config UI: **Admin → Config → Web services → Better Social Sharing Buttons settings**
(`/admin/config/services/better_social_sharing_buttons/config`, route
`better_social_sharing_buttons.config`, permission `administer site configuration`).

- Settings form, the `better_social_sharing_buttons.settings` config object, networks, iconset, size/radius, block, fields → [configure/settings.md](configure/settings.md)
- Block plugin `social_sharing_buttons_block`, the service, the build items array, and the alter hooks to call in code → [api/api.md](api/api.md)

Submodule (nested): **better_social_sharing_buttons_per_node** — per-node on/off toggle. See
`../../modules/better_social_sharing_buttons_per_node/5.0.x/agent/start.md`.
