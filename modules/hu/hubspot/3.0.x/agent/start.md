# HubSpot Webform integration — agent index

Sends Webform submissions to HubSpot's Forms API over OAuth 2 and can inject HubSpot's JS tracking
code. Depends on `webform`. Uses `hubspot/hubspot-php`. Config UI at
`/admin/config/services/hubspot` (route `hubspot.admin_settings`, permission `administer site
configuration`). No Drush. No plugin types defined (it *provides* a Webform handler + a Block).

- **Admin settings, OAuth connect/disconnect flow, tracking code, debug mail, config keys** →
  [configure/settings.md](configure/settings.md)
- **The `hubspot_webform_handler` Webform handler: field mapping, files, legal consent, subscriptions** →
  [plugins/webform-handler.md](plugins/webform-handler.md)
- **The `hubspot.hubspot` service: OAuth, token refresh, submit form, get forms/leads** →
  [api/service.md](api/service.md)
- **Permissions (`view recent hubspot leads`, restricted)** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config `hubspot.settings`: `hubspot_portal_id`, `hubspot_client_id`, `hubspot_client_secret`,
  `hubspot_scope` (default `crm.objects.contacts.write forms oauth`), `hubspot_debug_on`,
  `hubspot_debug_email`, `tracking_code_on`.
- OAuth tokens live in **state**: `hubspot.hubspot_access_token`, `hubspot.hubspot_refresh_token`,
  `hubspot.hubspot_expires_in`. `isConfigured()` = refresh token present.
- Routes: `hubspot.admin_settings`, `hubspot.oauth_connect` (`/hubspot/oauth`, perm
  `administer site configuration`), `hubspot.form_settings` (`/node/{node}/webform/hubspot`, perm
  `bypass node access+access content`). NOTE: `hubspot.form_settings` targets
  `\Drupal\hubspot\Form\FormSettings`, **which does not exist in this release** (only
  `AdminSettings` ships) — the legacy per-node mapping tab is non-functional; use the Webform
  handler instead.
- Tracking script `https://js.hs-scripts.com/<portal_id>.js` attached when `tracking_code_on`.
- `hubspot/hubspot-php` (SevenShores) is the API client; requests target fixed HubSpot endpoints.
