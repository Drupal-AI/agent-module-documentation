<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How JWT Auth Consumer authenticates a request

`jwt_auth_consumer` has no API surface of its own to call — its "API" is the claim
contract it consumes. It registers `JwtAuthConsumerSubscriber` (service
`jwt_auth_consumer.subscriber`) on two base-module events.

## The claim contract

The token payload must carry a **nested** identity claim under `drupal`:

```json
{ "iat": 1700000000, "exp": 1700003600, "drupal": { "uid": 42 } }
```

Lookup order (first non-null wins): `drupal.uid` -> `drupal.uuid` -> `drupal.name`.
- `uid` loads the user by id.
- `uuid` / `name` load by that property.
- If none is present, or the user does not exist, or the user is blocked, the token is
  invalidated (authentication fails, returns anonymous).

## What each event handler does

| Event | Handler | Effect |
|---|---|---|
| `JwtAuthEvents::VALIDATE` (`jwt.validate`) | `validate()` | Resolve the user from the claim; `invalidate()` if missing/blocked; back-fill `drupal.uid` if only uuid/name was given. |
| `JwtAuthEvents::VALID` (`jwt.valid`) | `loadUser()` | Load the resolved user and `setAccount()` — that is the authenticated account. |

## Wiring it up

1. Enable the module: `drush en jwt_auth_consumer -y`.
2. Configure a signing key on the base module (`/admin/config/system/jwt`, sets `jwt.config`
   `key_id`) — without it the transcoder cannot verify tokens.
3. Send the token: `Authorization: Bearer <jwt>` (or fallback `JWT-Authorization: Bearer <jwt>`).
4. For REST/Views resources, enable the `jwt_auth` authentication provider on the display/resource.

No settings to tune — the subscriber is active whenever the module is enabled.
