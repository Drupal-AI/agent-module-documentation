# Scopes & granularity

Scopes define what a token may do. The active source is chosen by
`simple_oauth.settings.scope_provider` (`dynamic` config entities by default; `static` YAML
plugins with the `simple_oauth_static_scope` submodule).

## Dynamic scopes (`oauth2_scope` config entity, schema `simple_oauth.oauth2_scope.*`)
Managed at `/admin/config/people/simple_oauth/oauth2_scope/dynamic`
(`entity.oauth2_scope.collection`). Fields:

| Key | Meaning |
|---|---|
| `name` | The scope string clients request (e.g. `content:read`). |
| `description` | Human description. |
| `grant_types` | Per-grant-type map (`authorization_code`, `client_credentials`, `refresh_token`) each with `status` + `description`. |
| `umbrella` | If TRUE this scope only aggregates child scopes (no direct access). |
| `parent` | Parent scope id (build a hierarchy). |
| `granularity_id` | Granularity plugin: `permission` or `role`. |
| `granularity_configuration` | Plugin config: `{permission: <perm>}` or `{role: <role>}`. |

Non-umbrella scopes must set a granularity mapping the scope to either a Drupal
**permission** (`ScopeGranularity/Permission`) or a **role** (`ScopeGranularity/Role`).

## Referencing scopes from fields
The `oauth2_scope_reference` field type lets other config/entities reference scopes, with an
optional `filter_grant_type` setting to limit selectable scopes to one grant type.

To define scopes as deployable YAML instead of UI config entities, use the static-scope
submodule (documented separately) and set `scope_provider: static`.
