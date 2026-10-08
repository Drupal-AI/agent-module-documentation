<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring CMRF Key Authentication

Route `cmrf_key_authentication.settings` at `/admin/config/services/cmrf_key_authentication` (`administer site configuration`) → config `cmrf_key_authentication.settings`.

## Lookup (who the key belongs to)
- `civicrm_connector`, `civicrm_api_version` (3 or 4), `civicrm_api_entity`, `civicrm_api_action`, `civicrm_get_fields_action`.
- Field names: `civicrm_key_field`, `civicrm_email_field`, `civicrm_user_id_field`, `civicrm_ip_field`, `civicrm_roles_field`.
- `civicrm_additional_parameters` (JSON; tokens replaced), `mapping` (JSON CiviCRM→Drupal field map), `logout_after` (minutes of inactivity).

Authentication succeeds only if the CiviCRM call returns exactly one record for the given key + email/user-id. The matched CiviCRM data is cached in the session (`cmrf_key_authentication_user_data`) until `logout_after` elapses.

## How the key is supplied
- **URL query params** — names configured via `url_key_param_name`, `url_email_param_name`, `url_user_id_param_name`. (Caution: keys in URLs leak via logs/Referer.)
- **JWT** — `url_jwt_token_param_name`; token is HS256-decoded with `secret_key`; claims `sub` (key), optional `user_id`, `email`.
- **Login forms** — `/user/civicrm_login_request` (emails a code via `civicrm_login_code_api_*`) and `/user/civicrm_login` (enter the code).

## Field mapping & tokens
Mapped CiviCRM values populate the virtual `Account` and are exposed as user tokens (`[user:cmrf_key_authentication_field_*]`). Roles come from `civicrm_roles_field`.

## Runtime notes
- The provider forces logout if an authenticated user presents a key in the URL query, then re-authenticates as the key's user.
- Key-auth requests bypass the page cache (request policy `DisallowKeyAuthRequests`).
- `hook_user_login`/`hook_user_logout` clear the cached CiviCRM session data.
