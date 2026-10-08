<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — client settings & behaviour hooks

## Config keys
Config entity `openid_connect.settings.harid` (client plugin `harid`), schema
`openid_connect.client.plugin.harid`:
| Key | Type | Meaning |
|---|---|---|
| `client_id` | string | HarID-issued client id. |
| `client_secret` | string | HarID-issued secret (entered in the OIDC client form). |
| `iss_allowed_domains` | string | Base-module ISS-initiated-SSO allowlist. |
| `require_strong_session` | bool (default FALSE) | Require ID-card/Mobile-ID/Smart-ID session; adds `session_type` scope. |
| `require_personal_code` | bool (default FALSE) | Require the account to have a personal code; adds `personal_code` scope. |
| `use_test_idp` | bool (default FALSE) | Use `test.harid.ee` instead of `harid.ee`. |

Set via the OpenID Connect client UI, or `drush cset openid_connect.settings.harid settings.require_strong_session true -y`.
Update hooks `openid_connect_harid_update_8101/8102` backfill these keys on existing configs.

## Behaviour hooks (`openid_connect_harid.module`)
- `hook_openid_connect_pre_authorize($account, $context)` — for the `harid` client, **denies login**
  (returns FALSE + error message) when:
  - `require_strong_session` is on but `$context['userinfo']['strong_session']` is falsy, or
  - `require_personal_code` is on but `$context['userinfo']['personal_code']` is empty.
- `hook_openid_connect_post_authorize($account, $context)` — sets the user's `langcode` /
  `preferred_langcode` from `$context['userinfo']['ui_locales']` when it matches an enabled site
  language, then saves the account. Runs on every successful HarID authorization.

Neither hook handles tokens or trust-critical validation; those stay in `openid_connect`.
