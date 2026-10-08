<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Request API Key Authentication (services_api_key_auth) — agent index

Adds an API-key authentication provider (`provider_id: api_key_auth`) for Drupal REST / JSON:API.
Each `api_key` config entity binds a secret key string to a Drupal user; a request that presents a
matching key is authenticated and runs as that user. Keys are managed at
`/admin/config/services/api-key-auth` under the permission `administer services_api_key_auth`.
No module dependencies; core `^10.3 || ^11`.

- Configure route: `entity.api_key.collection` (`/admin/config/services/api-key-auth`).
- Defines 1 permission, a config entity type (`api_key`) + a settings config object, config schema.
  No drush commands, no plugin types.

Solutions:
- **Create / manage API keys and bind each to a user** → [configure/api-keys.md](configure/api-keys.md)
- **Choose where the key is read from (header / POST / GET name)** → [configure/settings.md](configure/settings.md)
- **Enable the provider on a REST resource or JSON:API and send an authenticated request** → [api/authentication.md](api/authentication.md)
- **The admin permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Auth provider service: `services_api_key_auth.authentication.api_key_auth`
  (class `Drupal\services_api_key_auth\Authentication\Provider\ApiKeyAuth`), tag
  `authentication_provider`, `provider_id: api_key_auth`, `priority: 100`. Not registered `global`,
  so a route/resource must opt it in via `_auth` (JSON:API does this automatically).
- Config entity type `api_key` (config prefix `api_key` → config objects
  `services_api_key_auth.api_key.<id>`); each key binds to a user via `user_uuid` — treat it as a
  live credential.
- Settings config object `services_api_key_auth.settings`: `api_key_request_header_name`
  (default `api_key`), `api_key_post_parameter_name` (default empty), `api_key_get_parameter_name`
  (default empty).
- Permission: `administer services_api_key_auth`.
- Routes: `entity.api_key.collection`, `entity.api_key.add_form`, `entity.api_key.edit_form`,
  `entity.api_key.delete_form`, `services_api_key_auth.api_key_auth_settings`.
