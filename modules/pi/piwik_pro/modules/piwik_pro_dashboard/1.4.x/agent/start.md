# Piwik Pro Dashboard (submodule) — agent index

In-admin analytics dashboard for Piwik PRO. A React app on `/admin/reports/piwik-dashboard`
consumes three JSON API routes that call the Piwik PRO Analytics API using OAuth
client-credentials; the client secret is stored via the **Key** module.

- **Settings form (Client ID + Key-referenced secret), credential/secret handling** →
  [configure/settings.md](configure/settings.md)
- **JSON API routes, `PiwikApiClient`, `AccessTokenManager` auth flow** →
  [api/endpoints.md](api/endpoints.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config `piwik_pro_dashboard.settings`: `client_id` (string) and `client_secret` (**a Key
  entity ID**, not the raw secret). Form at `/admin/config/services/piwik-pro/dashboard` (route
  `piwik_pro_dashboard.settings`, perm `administer piwik pro dashboard`, `restrict access`).
- Routes (perm `access piwik pro dashboard`): `/admin/reports/piwik-dashboard` (page) and JSON
  `/api/piwik-dashboard/overview`, `/devices`, `/top-pages`.
- Auth: `AccessTokenManager` loads the Key by ID → `getKeyValue()` → POST `client_credentials`
  to `https://<client>.piwik.pro/auth/token`; token cached in default cache bin until ~expiry.
  `<client>` derived from base `piwik_domain` via `ClientNameHelper`.
- Depends on `piwik_pro` (configured) and `key`. Range = last 7/30 days (`DateRange` enum).
