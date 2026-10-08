<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, JWT secret & tokens

Config object `de_notifications.settings` (schema `config/schema/de_notifications.schema.yml`,
defaults `config/install/de_notifications.settings.yml`). Settings form
`src/Form/NotificationsSettingsForm.php` at `/admin/config/system/de_notifications`
(route `de_notifications.settings`, permission `administer de_notifications settings`).

## Keys

| Key | Type | Set via | Purpose |
|---|---|---|---|
| `notification_type` | string | form (required) | Plugin id of the delivery channel (e.g. `symfony_mail`). `''` = none. |
| `frontend_url` | label | form (required) | Base URL of the decoupled front-end, no trailing slash (constraint `NotificationsUrl`). |
| `confirm_path` | label | form | Relative path for confirm links, leading `/` (constraint `NotificationsPath`). |
| `unsubscribe_path` | label | form | Relative path for single-unsubscribe links. |
| `unsubscribe_all_path` | label | form | Relative path for unsubscribe-all links. |
| `request_subscription_overview_path` | label | form | Relative path for overview-request links. |
| `notification_link_query` | label | form (optional) | Extra query string appended to entity links (e.g. `utm_source=notification`). |
| `ttl_confirm` | integer | form | TTL (seconds) of confirm tokens. Default `86400` (24h). |
| `ttl_generic` | integer | form | TTL (seconds) of other tokens. Default `22776000` (~1y). |
| `secret_key` | string | **not in the form** | HMAC secret for signing/validating JWTs. Default `''`. |

## secret_key (important)
`secret_key` is deliberately absent from the settings form. Set it outside the config UI — e.g. in
`settings.php` via `$config['de_notifications.settings']['secret_key'] = getenv('DEN_SECRET');`, or a
config override. `de_notifications_requirements()` (in `de_notifications.install`, runtime phase)
raises a status-report **error** if the secret is unset or shorter than 32 characters. Configure a
long, random secret before going live.

## Tokens
`src/NotificationsTokenService.php` (service `de_notifications.token`) uses `firebase/php-jwt`:
- `generateToken(uuid, ttl)` → `JWT::encode(['sub'=>uuid,'iat'=>...,'exp'=>...], secret_key, 'HS256')`.
- `validateToken(token)` → `JWT::decode(token, new Key(secret_key,'HS256'))`; throws
  `NotificationsException` 410 on expiry, 401 on invalid/tampered signature; returns the `sub` (UUID).

`src/NotificationsContextService.php` (service `de_notifications.context`) builds the tokenized
front-end URLs (`getConfirmUrl`, `getUnsubscribeUrl`, `getUnsubscribeAllUrl`,
`getRequestSubscriptionOverviewUrl`) as `frontend_url + <path>?t=<jwt>`, and the entity link
(`getLatestEntityUrl`) as the entity canonical under `frontend_url` plus `notification_link_query`.
Confirm links use `ttl_confirm`; all others use `ttl_generic`.

## Related config
- `config_translation` support: `de_notifications.config_translation.yml`.
- Optional Views: `config/optional/views.view.notification_subscriptions.yml`,
  `views.view.notification_subscribers.yml`.
- Field config schema for `notification_settings` also lives in the module schema file.
