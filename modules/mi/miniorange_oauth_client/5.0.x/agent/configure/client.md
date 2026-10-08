# Configure miniOrange OAuth Client

No single `configure` route (info.yml has none). Everything is under
`/admin/config/people/mo-oauth-client/` and requires the `mo_administrator` permission. Start at the
**Client Configuration** list (`entity.mo_client_config.collection`) → *Add* to create a connection.

## Admin routes (all `_permission: mo_administrator`)

| Route | Path | Purpose |
|---|---|---|
| `entity.mo_client_config.collection` | `/mo-oauth-client/mo-client-config` | List IdP connections (Manage tab). |
| `entity.mo_client_config.add_form` | `/mo-oauth-client/add` | Add a connection. |
| `mo_configuration.edit` | `/mo-oauth-client/{mo_client_config}` | Edit a connection. |
| `entity.mo_client_config.delete_form` | `/mo-oauth-client/mo-client-config/{id}/delete` | Delete. |
| `mo_oauth.setup_guide` | `/mo-oauth-client/setup-guide` | Provider setup guide. |
| `mo_module.settings` | `/mo-oauth-client/settings/module` | Module Settings (login enforcement, links). |
| `mo_module.logger_settings` | `/mo-oauth-client/settings/logger` | Log settings. |
| `mo_oauth.configuration.import_export` | `/mo-oauth-client/configuration/import-export` | Import/Export config. |
| `entity.mo_login_reports.collection` | `/mo-oauth-client/login-reports` | SSO audit log. |
| `mo_oauth.password_grant.test_config` | `/mo-oauth-client/password-grant/user/login` | Password-grant test. |

## The connection entity: `mo_client_config`

A config entity (`Drupal\miniorange_oauth_client\Entity\MoClientConfiguration`). Key stored fields
(getter → meaning; set via the Add/Edit form):

| Field (getter) | Meaning |
|---|---|
| `getAppName` | Human label / app name; the entity id is derived from it. |
| `getLoginProtocol` | `OAuth` (raw OAuth 2.0) or `OpenID` (OIDC). |
| `getGrantType` | `authorization_code`, `authorization_code_with_pkce`, `implicit`, `password`, `refresh_token`. |
| `getClientId` / `getClientSecret` | OAuth client credentials (secret optional per `getClientSecretMethod`). |
| `getAuthorizeEndpoint` | IdP authorization URL. |
| `getAccessTokenEndpoint` | IdP token URL. |
| `getUserinfoEndpoint` | IdP userinfo URL (where claims are fetched for the OAuth protocol). |
| `getGroupInfoEndpoint` | Optional group/roles endpoint. |
| `getJkwsEndpoint` | JWKS URL (OpenID id-token key set). |
| `getScope` | Requested scopes. |
| `getCallbackUrl` | The redirect_uri to register at the IdP — `/mo-oauth-client/callback/{id}`. |
| `getAuthorizationRequestMethod` | `get` (redirect) or `post` (auto-submit form). |
| `getAuthorizeEndpointAddFields` / `getAuthorizationAddOnParams` | Extra query params appended to the authorize URL. |
| `getEnableLoginWithOauth` | Must be TRUE (and Test Connection passed) before real logins are accepted. |
| `getDisplayLoginLink` / `getLoginLinkText` | Show a "Login with <IdP>" link on the login form. |
| `getAuthenticationMethod` | Client-auth method for the token call (e.g. body vs basic). |
| `getEnableIdpLocale` / `getIdpLanguageParamName` / `getIdpLanguageMappings` | Language passthrough/mapping. |

The **callback/redirect URI** to register at the IdP is
`https://<site>/mo-oauth-client/callback/<config-id>` (`MoUtilities::getCallbackUrl($id)`).

## Attribute / role / group / profile mapping

Separate config entities, edited from the connection's tabs:
- `mo_attribute_mapping` — **required**: map the IdP email/login claim to a Drupal field. `checkUserExists`
  matches on the chosen `drupal_attribute_name` (must be `mail` on the free tier). Custom attribute rows
  map further claims to user fields.
- `mo_role_mapping` / `mo_group_mapping` / `mo_profile_mapping` — licensed-tier mapping of IdP
  attributes/groups to Drupal roles, groups, and profile fields, plus a default role for new users.

## Client settings entity: `mo_client_settings`

Per-connection behavior (`MoClientSettings`): `getAutoCreateUser`, `getDisableNewUser`,
`getAnonymousUserRedirectUrl` / `getLoginRedirectUrl` (post-login destination), `getRoleBasedRestriction`
+ `getListOfRestrictedRoles` (restrict who may SSO), `getEnableSlo` / `getSingleLogoutUrl` (Single
Logout), `getTieTokenExpiryToUsrSession` + `getActionAfterTokenExpiry`, `getRevokeUserTokenFromIdp` +
`getTokenRevokeUrl`.

## Module Settings (site-wide login enforcement)

At `mo_module.settings` (premium-tier fields): **Force Authentication** and **Replace Drupal login page**
redirect users to the IdP for login. The confusingly-named **"Enable backdoor access"** checkbox is an
anti-lockout escape hatch, not a security bypass: when enforced redirection is on, it lets an admin still
reach any URL by appending `?mo_force_stop_redirect=true`.

## Test Connection

The Add/Edit flow offers a Test Connection (`test_sso=1`) that runs the full authorization + token +
userinfo round-trip and renders the raw returned attributes (`MoTestConfigurationResultForm`) without
logging anyone in — use it to discover exact claim names before configuring Attribute Mapping.
