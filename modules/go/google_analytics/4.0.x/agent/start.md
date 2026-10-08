# google_analytics — agent start

Injects Google's `gtag.js` GA4 tracker into every page. Single settings form at
**Admin → Config → Services → Google Analytics** (`/admin/config/services/google-analytics`,
route `google_analytics.admin_settings_form`). Requires core `path_alias`.

- Configure measurement IDs, page/role visibility, link & download tracking → [configure/settings.md](configure/settings.md)
- Add config/events programmatically (event subscribers) + user tokens → [api/events.md](api/events.md)
- Permissions (admin, opt-in/out, PHP visibility, custom JS) → [permissions/permissions.md](permissions/permissions.md)
