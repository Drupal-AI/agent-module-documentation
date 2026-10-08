# Configure Piwik Pro Dashboard (credentials & secret handling)

Form `/admin/config/services/piwik-pro/dashboard` (route `piwik_pro_dashboard.settings`,
`Form\SettingsForm`, permission `administer piwik pro dashboard`, `restrict access: TRUE`).
Config object **`piwik_pro_dashboard.settings`**.

## Prerequisites

1. Base **piwik_pro** module installed and configured (its `piwik_domain` determines the API
   host — `<client>.piwik.pro`).
2. **Key** module enabled.
3. A Piwik PRO **API key** created in the Piwik PRO admin (client credentials) — see
   `https://developers.piwik.pro/reference/authentication`.

## Fields

| Field | Stored as | Notes |
|---|---|---|
| Client ID | `client_id` (plain string in config) | the OAuth client id (identifier, not the secret) |
| Client secret | `client_secret` = **a Key entity ID** | a `select` of available Key entities; you pick the Key that holds the secret |

The secret-selection is the important part: the form lists Key entities
(`Key::loadMultiple()`) and stores the **chosen key's ID** in `client_secret`, not the secret
value. Its description warns "we recommend against storing the API key in your configuration
files." So the actual secret never lands in `piwik_pro_dashboard.settings` / config exports — it
lives wherever the Key entity points (env var, file, etc.).

## Recommended setup (env-var Key)

Per the project convention, store the secret in an environment variable and reference it via a
Key entity with the env provider, then select that Key here. For example (host/DDEV):

```
ddev dotenv set .ddev/.env --piwik-pro-client-secret=<secret>   # never commit .ddev/.env
ddev restart
ddev drush key:save piwik_pro_client_secret --label='Piwik PRO Client Secret' \
  --key-type=authentication --key-provider=env \
  --key-provider-settings='{"env_variable":"PIWIK_PRO_CLIENT_SECRET","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

Then on the dashboard settings form set **Client ID** and select the
`piwik_pro_client_secret` key. `AccessTokenManager` will `->load($keyId)->getKeyValue()` to
retrieve the secret at token-fetch time.

## Drush

`drush cset piwik_pro_dashboard.settings client_id '<id>' -y` and
`drush cset piwik_pro_dashboard.settings client_secret '<key_entity_id>' -y` (note: the value is
the **Key ID**, not the secret).
