<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Token Entity (api_token_entity) — agent index

Models API tokens as content entities and authenticates API requests with an `Authorization: ApiKey <token>` header. Back-office CRUD + rotation + expiry, plus a validation service and a route access checker.

- **Version dir:** 1.0.x (installed 1.0.2). **Core:** `^11.3`. **PHP:** 8.4+. **License:** GPL-2.0-or-later.
- **Dependencies:** core `datetime` only. No config schema, no `.install`, no Drush.
- **Admin UI:** *Configuration › Web services › API token entity* (`/admin/config/services/api-token-entity`).

## Provides

- **Content entities**
  - `api_token_entity_api_token` (`src/Entity/ApiToken.php`) — fields: `type` (ref → token type), `name` ("Consumer ID"), `value` (generated, stored hashed), `expiration_date` (datetime, required).
  - `api_token_entity_api_token_type` (`src/Entity/ApiTokenType.php`) — field: `name` (machine-name identifier).
- **Service** `api_token_entity.api_token.manager` → `ApiTokenManager` (`src/ApiTokenManager.php`): `checkApiToken()`, static `generateSecureApiTokenValue()`.
- **Access check** `_api_token_type` route requirement → `ApiTokenTypeAccessCheck` (`src/Access/ApiTokenTypeAccessCheck.php`), service `access_check.api_token_entity.api_token_type`.
- **Forms** `ApiTokenEntityForm` (add/edit + Rotate), `ApiTokenCheckerForm` (admin validate-token form).
- **List builders** `ApiTokenListBuilder`, `ApiTokenTypeListBuilder`.
- **Validation plugin** `MachineName` constraint (`^[a-z0-9_.]+$`).
- **Permission** `administer api_token_entity entities` (restrict access).

## Solution docs

- [Entities & fields](entities/entities.md) — the two entity types, base fields, token generation & hashing, forms/rotation.
- [Validating tokens](api/validation.md) — `ApiTokenManager::checkApiToken()`, the `_api_token_type` route access check, and the `ApiKey` header protocol.
- [Admin, routes & permissions](config/admin-and-permissions.md) — install/enable, menu & routes, permission model, list UI.
