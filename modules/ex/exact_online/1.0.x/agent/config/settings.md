<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & credential storage

## Install / enable

```bash
composer require drupal/exact_online   # pulls picqer/exact-php-client:^4.4
drush en exact_online -y
```

No install hooks (`.install` absent) and no `config/install/*` — the config object is
created only when the settings form is first saved.

## Settings form

`Drupal\exact_online\Form\ExactOnlineSettingsForm` (`src/Form/ExactOnlineSettingsForm.php`,
extends `ConfigFormBase`, form id `exact_online_settings`) at route `exact_online.settings`
(`/admin/config/services/exact-online/settings`). Fields:

| Field | Required | Where it is saved |
| --- | --- | --- |
| Client ID | yes | config `exact_online.settings:client_id` |
| Client Secret | yes | **State** key `exact_online.client_secret` (NOT config) |
| Authorization callback domain (`callback_url`) | yes | config `exact_online.settings:callback_url` |
| Exact Online API base URL (`base_url`) | yes | config `exact_online.settings:base_url` (default `https://start.exactonline.nl`) |
| Division | no | config `exact_online.settings:division` |

Credential storage is exactly this: `submitForm()` writes `client_id`, `callback_url`,
`base_url`, `division` to the `exact_online.settings` config object and writes the client
secret to Drupal **State** via `$this->state->set('exact_online.client_secret', …)`.
There is **no** environment-variable / `getenv()` / dotenv / Key-module mechanism in the
source — the secret lives in State only (so it is not exported with config).

`validateForm()`: `callback_url` must be a valid URL, must start with `https://`, and may
not be `localhost`; `base_url` must be a valid URL; `division` (if set) must be numeric.
`getDefaultCallbackUrl()` seeds the callback field with
`$request->getSchemeAndHttpHost() . '/exact-online/callback'`.

## Config object & schema

`config/schema/exact_online.schema.yml` defines `exact_online.settings` (type
`config_object`) with string keys `client_id`, `callback_url`, `base_url`, `division`.
The client secret and all tokens are intentionally **outside** config.

## State keys (runtime data, not config)

- `exact_online.client_secret` — the OAuth2 client secret.
- `exact_online.tokens` — `['access_token', 'refresh_token', 'expires_in']`.
- `exact_online.api_rate_limits.{dailyLimit,dailyLimitRemaining,dailyLimitReset,minutelyLimit,minutelyLimitRemaining,minutelyLimitReset}`.
- `exact_online.logs` — array of `['timestamp','type','message','user']`, capped at 1000 entries.
- `exact_online.reconnect_notification`, `exact_online.last_expiration_notification` — notification throttle timestamps.

## Connect flow (admin)

1. Create an app in the Exact Online App Store; copy Client ID + Client Secret.
2. Enter them plus the callback domain, base URL and (optionally) division on the settings form.
3. Set the app's Redirect URI to `<callback_url>/exact-online/callback`.
4. From the dashboard (`/admin/config/services/exact-online`) start authorization; on
   return the module stores the tokens. See [../routes/routes.md](../routes/routes.md) and
   [../api/service.md](../api/service.md).
