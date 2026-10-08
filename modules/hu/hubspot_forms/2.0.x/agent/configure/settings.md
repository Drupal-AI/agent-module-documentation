# Configure — HubSpot connection settings

Form `HubspotSettingsForm` at `/admin/config/services/hubspot-forms` (route
`hubspot_forms.admin_config`, permission **`administer site configuration`**). Edits the
`hubspot_forms.settings` config object.

## Fields → config keys

| Field | Config key | Notes |
|---|---|---|
| Hubspot Access Type | `hubspot_access_type` | select: `0` = API Key (legacy), `1` = Access Token |
| Hubspot API Key (Legacy) | `hubspot_api_key` | shown when type = 0. Value `demo` loads HubSpot's example forms. Sent as `?hapikey=`. |
| Hubspot Access Token | `hubspot_access_token` | shown when type = 1. Private App token, sent as `Authorization: Bearer …` |
| Hubspot Portal ID | `hubspot_portal_id` | shown when type = 1. Prepended to every form key as `PORTAL_ID::FORM_ID` |
| Hubspot forms caching | `caching` | integer seconds; select of intervals; `0` = no caching; default `10800` (3h) |

Note: with the **legacy API key** path the portal id comes back from the API per form
(`$item->portalId`); with the **access token** path you must set `hubspot_portal_id` yourself
because the v3 forms API does not return it, and it is needed for the embed.

On save the module deletes the `hubspot_forms` cache entry so the new account's forms reload.

## Getting credentials

- Access Token (recommended): create a HubSpot **Private App** and copy its access token; also copy
  your account/portal id. HubSpot is sunsetting API keys.
- API Key (legacy): from HubSpot account settings; use `demo` to try example forms.

## Storing the secret safely

`hubspot_access_token` / `hubspot_api_key` are plain config values. To keep the real secret out of
version-controlled config, override it per-environment in `settings.php`:

```php
$config['hubspot_forms.settings']['hubspot_access_token'] = getenv('HUBSPOT_ACCESS_TOKEN');
```

(There is no Key-module integration; the module reads the value straight from config.)

## Verifying / troubleshooting

- `\Drupal::service('hubspot_forms')->isConnected()` returns the number of forms fetched (0 = not
  connected). See [../api/service.md](../api/service.md).
- API/connection errors are logged to the `hubspot_forms` logger channel (not surfaced on the form).
- After changing credentials, clear the `hubspot_forms` cache (saving the form does this; or
  `drush cr`) so the form select lists refresh.
