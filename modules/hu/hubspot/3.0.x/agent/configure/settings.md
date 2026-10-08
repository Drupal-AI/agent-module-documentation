# Configure — HubSpot

## Admin settings form
Route `hubspot.admin_settings` → `/admin/config/services/hubspot`, permission
`administer site configuration`. Form `Drupal\hubspot\Form\AdminSettings` (`ConfigFormBase`).
Config object `hubspot.settings`.

Config keys (defaults from `config/install/hubspot.settings.yml`):
```yaml
hubspot_portal_id: ''      # HubSpot Hub/Portal ID (required)
hubspot_client_id: ''      # OAuth app Client ID (required)
hubspot_client_secret: ''  # OAuth app Client Secret
hubspot_scope: 'crm.objects.contacts.write forms oauth'  # space-separated scopes
hubspot_debug_on: 0        # email API errors instead of just logging
hubspot_debug_email: ''    # recipient for debug error mails
tracking_code_on: 0        # attach the HubSpot JS tracking script site-wide
```
Set headless with `drush cset hubspot.settings hubspot_portal_id 1234567 -y`, etc.

## OAuth connect / disconnect
- Once a portal ID is saved, the form shows **Connect HubSpot Account** (submit handler
  `hubspotOauthSubmitForm`) which redirects to `https://app.hubspot.com/oauth/authorize` with the
  client ID, the `hubspot.oauth_connect` redirect URI, and the configured scope.
- HubSpot redirects back to route `hubspot.oauth_connect` (`/hubspot/oauth`, permission
  `administer site configuration`). `Controller::hubspotOauthConnect()` reads `?code=` and calls
  `Hubspot::authorize($code)`, exchanging it for tokens saved to **state**
  (`hubspot.hubspot_access_token`, `hubspot.hubspot_refresh_token`, `hubspot.hubspot_expires_in`),
  then redirects back to the settings page. `?error=access_denied` shows an error message.
- When connected, the button becomes **Disconnect HubSpot Account** (`hubspotOauthDisconnect`),
  which deletes `hubspot.hubspot_refresh_token` from state.
- `Hubspot::isConfigured()` returns true iff a refresh token is present; the Webform handler and
  API calls rely on this.

## Tracking code
When `tracking_code_on` is set, `hook_page_attachments` attaches library
`hubspot/hubspot.code_tracking`, whose JS is built dynamically in `hook_library_info_build` as an
external script `https://js.hs-scripts.com/<hubspot_portal_id>.js` (deferred/async, id
`hs-script-loader`). No template edits required.

## Debug mail
When `hubspot_debug_on` is set, HubSpot submission errors are emailed to `hubspot_debug_email`
(`hook_mail` keys `http_error` / `hub_error`); otherwise they are written to the `hubspot` logger
channel.

## Legacy per-node tab (non-functional)
Route `hubspot.form_settings` (`/node/{node}/webform/hubspot`, task tab "HubSpot") points at
`\Drupal\hubspot\Form\FormSettings`, which is **not present** in 3.0.x (only `AdminSettings`
ships). Do not rely on this tab; map fields with the Webform handler instead
([../plugins/webform-handler.md](../plugins/webform-handler.md)).
