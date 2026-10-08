# Permissions and entity access

## The one permission

`lti_tool_provider.permissions.yml` defines a single permission:

- **`administer lti_tool_provider module`** — "Administer LTI Tool Provider module". This is the
  admin key for the whole project: the consumer entity CRUD, the global settings hub, and every
  submodule settings form require it.

`ddev drush role:perm:add <role> 'administer lti_tool_provider module'` grants it.

## What each surface requires

| Surface | Requirement |
|---|---|
| `admin/config/lti-tool-provider` hub, consumer collection | `administer lti_tool_provider module` |
| Consumer view / edit / delete | `_entity_access` → `LtiToolProviderConsumerAccessController` → `administer lti_tool_provider module` (all operations) |
| Consumer add | `_entity_create_access` → same controller (`checkCreateAccess`) |
| Global settings form (`lti_tool_provider.settings`) | `administer site configuration` (note: not the module permission) |
| Roles / Attributes / Provision / Content admin forms | `administer lti_tool_provider module` |
| Provision entity CRUD | `LtiToolProviderProvisionAccessController` → `administer lti_tool_provider module` |

Both `LtiToolProviderConsumerAccessController` and `LtiToolProviderProvisionAccessController` extend
`EntityAccessControlHandler` and return
`AccessResult::allowedIfHasPermission($account, 'administer lti_tool_provider module')` for every
operation — there is no per-consumer or per-provision granularity.

## The launch endpoints are intentionally reachable pre-authentication

The launch/OIDC/JWKS routes are not gated by a Drupal permission — that is by design, because the LMS
is anonymous to Drupal at the moment it hits them. Their gate is the **authentication provider**:
`lti_auth_v1p0` verifies the OAuth 1.0a HMAC-SHA1 signature (PECL `\OAuthProvider`), and
`lti_auth_v1p3` verifies the signed OIDC `id_token` (OAT `ToolLaunchValidator`), before any Drupal
session is established. The launch controllers only run once that verified session context exists in
`lti_tool_provider_context`; see [../api/authentication.md](../api/authentication.md). Roles a launched
user receives come from the admin-configured `lti_tool_provider_roles` mapping, not from the launch
directly — see [../configure/submodules.md](../configure/submodules.md).
