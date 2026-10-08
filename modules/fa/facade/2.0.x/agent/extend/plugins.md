<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extending Façade

## Tenant model
- `tenant` (content entity) + `tenant_type` (config entity) define what a managed site is.
- Grant `add tenant`, `view/edit/delete tenant entities`; `administer tenant entities` is
  `restrict access: true`. Per-bundle permissions come from `Access\TenantPermissions::generatePermissions`.

## Launch plugins
Implement a `FacadeLaunchTenantPlugin` (managed by `FacadeLaunchTenantPluginManager`) to react to
tenant create/edit/delete and perform the real deployment (e.g. call OpenStack / AWS CloudFormation).
This keeps provider logic out of the entity code.

## Remote workers (facade_remote_worker submodule)
- Adds a REST resource `entity.cloud_config`, a Drush command set (`EntityCommands`), and the user
  field `field_bearer_token`.
- Registers a **global** bearer-token auth provider (`FacadeBearerToken`): the `Authorization: Bearer
  <base64>` header is base64-decoded and matched against `field_bearer_token` via `loadByProperties`.
- Note for operators: the token is stored and compared in plaintext (not hashed); issue long random
  tokens, serve only over TLS, and rotate them.

## Reference provider
The OpenStack provider ships with the `cloud_orchestrator` distribution and requires the contrib
`cloud` module plus working OpenStack + AWS credentials.
