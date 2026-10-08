<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `windows_aad` OpenID Connect client plugin

`src/Plugin/OpenIDConnectClient/WindowsAad.php`, class `WindowsAad extends
OpenIDConnectClientBase`. It is an **openid_connect** client plugin, discovered by that
module's `OpenIDConnectClient` annotation plugin manager — this module defines **no plugin
type of its own**.

```php
/**
 * @OpenIDConnectClient(
 *   id = "windows_aad",
 *   label = @Translation("Windows Azure AD")
 * )
 */
```

## How it registers with openid_connect

- openid_connect owns the `openid_connect_client` config-entity type and an
  `OpenIDConnectClient` plugin manager that scans every module's
  `src/Plugin/OpenIDConnectClient/` directory.
- Dropping this class there makes `windows_aad` selectable as the `plugin` value of an
  `openid_connect_client` config entity. No hook or service registration is needed.
- The config schema for its settings is
  `openid_connect.client.plugin.windows_aad` (in
  `config/schema/openid_connect_windows_aad.schema.yml`), keyed off the entity's `plugin`
  value via `type: openid_connect.client.plugin.[%parent.plugin]`.

## Settings keys (plugin `settings`, from `defaultConfiguration()`)

Base keys inherited from openid_connect: `client_id`, `client_secret` (a **Key** id),
`iss_allowed_domains`, `prompt` (sequence).

Plugin-specific keys:

| Key | Type | Default | Purpose |
|---|---|---|---|
| `authorization_endpoint_wa` | uri | `''` | Entra authorization endpoint (tenant-scoped). |
| `token_endpoint_wa` | uri | `''` | Entra token endpoint. |
| `userinfo_endpoint_wa` | string | `''` | Alternate userinfo endpoint (only when graph option = 0). |
| `end_session_endpoint` | uri | `''` | End-session / logout endpoint. |
| `map_ad_groups_to_roles` | bool | `FALSE` | Turn on Entra-group → Drupal-role mapping. |
| `group_mapping.method` | int | `0` | `0` = automatic (name/id match), `1` = manual mappings. |
| `group_mapping.mappings` | string | `''` | One `role\|group;group` line each (manual mode). |
| `group_mapping.strict` | bool | `FALSE` | Strip Drupal roles not backed by a current AD group. |
| `userinfo_graph_api_wa` | int | `0` | `2` = Microsoft Graph v1.0 (recommended), `1` = Azure AD Graph v1.6 (deprecated), `0` = alternate/none. |
| `userinfo_graph_api_use_other_mails` | bool | `FALSE` | Fall back to Graph `otherMails` for email. |
| `userinfo_update_email` | bool | `FALSE` | Update the Drupal email on each login. |
| `hide_email_address_warning` | bool | `FALSE` | Hide the "email not found" message. |
| `subject_key` | string | `'sub'` | Immutable id mapping: `sub` or `oid` (`oid` needs an openid_connect patch, see [drupal.org/i/3298472](https://www.drupal.org/i/3298472)). |

Entra-specific `prompt` options added by the plugin: `login`, `consent`, `select_account`,
`create` (on top of openid_connect's defaults).

## Behavior worth knowing

- **Azure AD B2C auto-detect:** if the authorization endpoint host ends in `.b2clogin.com`
  and path ends in `/oauth2/v2.0/authorize`, the plugin treats the client as B2C v2 — it
  adds the `client_id` and `offline_access` scopes and, when no userinfo endpoint returns
  data, decodes the claims directly from the access token (JWT via `lcobucci/jwt`).
- **Client secret** is resolved at request time through the Key repository
  (`$this->keyRepository->getKey($settings['client_secret'])->getKeyValue()`), never stored
  in plain config.
- **Graph resource:** for v1 it requests `https://graph.windows.net`; for v2 against a
  non-`/oauth2/v2.0/` token endpoint it requests `https://graph.microsoft.com`.
- **Group→role mapping** happens in `hook_openid_connect_userinfo_save()`
  (`openid_connect_windows_aad.module`): it reads `aad_groups`/`groups` from the userinfo,
  grants matching roles (automatic name/id or manual `role|group` map), and — with `strict`
  — removes previously-mapped roles the user no longer qualifies for.
- Overridden client methods: `getClientScopes()`, `getEndpoints()`, `getRequestOptions()`,
  `retrieveTokens()`, `retrieveUserInfo()`, `usesUserInfo()`.

Real logins need a live Entra tenant; everything above is configured at the
config-entity level (see [../configure/client.md](../configure/client.md)).
