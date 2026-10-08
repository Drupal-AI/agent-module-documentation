# google_tag — agent start

Injects Google tag (`gtag.js`) / Google Tag Manager (`gtm.js`) snippets via **tag container**
config entities, and pushes named analytics events (login, search, Commerce, Webform…) to the
dataLayer through a `GoogleTagEvent` plugin type. Config UI: **Admin → Config → Services →
Google Tag** (`/admin/config/services/google-tag`, global settings route
`google_tag.settings_form`). Perm: `administer google_tag_container`.

- Containers, IDs, conditions, dimensions/metrics, global settings → [configure/containers.md](configure/containers.md)
- Define/emit analytics events (the `GoogleTagEvent` plugin type) → [plugins/events.md](plugins/events.md)
- Permission → [permissions/permissions.md](permissions/permissions.md)
