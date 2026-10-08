OAuth2 Client lets a Drupal site act as an OAuth2 *client*: you declare each remote OAuth2 provider as a Drupal plugin, and the module handles fetching, refreshing, storing, and clearing access tokens using the League OAuth2 Client library.

---

The module is a developer/API toolkit built on `league/oauth2-client`. You define a client by writing an `Oauth2Client` plugin (a class with the `#[Oauth2Client(...)]` attribute extending `Oauth2ClientPluginBase`) that declares the provider's endpoints (`authorization_uri`, `token_uri`, optional `resource_owner_uri`), a `grant_type`, scopes, and request options. Four grant types ship as `oauth2_grant_type` plugins: `authorization_code`, `client_credentials`, `resource_owner`, and `refresh_token`. Each plugin also mixes in a token-storage strategy trait — `StateTokenStorage` (one shared token in Drupal State) or `TempStoreTokenStorage` (per-user token). Credentials (client id/secret) are **not** in the plugin; they are supplied at runtime by an `oauth2_client` **config entity** you create at `/admin/config/system/oauth2-client` (permission `administer oauth2 clients`), which pairs a plugin with a `credential_provider` (`oauth2_client` = Drupal State, or `key` = a Key module entity) and a `credential_storage_key`. At runtime you call the `oauth2_client.service` service (`Oauth2ClientServiceInterface`): `getAccessToken()`, `retrieveAccessToken()`, `clearAccessToken()`. For interactive (`authorization_code`) flows the module exposes a redirect-capture route `oauth2_client.code` and lets plugins override post-capture redirect and route access. Definitions can be altered via `hook_oauth2_client_info_alter()` and `hook_oauth2_grant_type_info_alter()`. The `oauth2_client_example_plugins` submodule ships four ready-to-read example plugins.

---

- Authenticate a Drupal site to a third-party API that requires OAuth2 (client credentials).
- Let site users connect their account on an external provider via the authorization-code flow.
- Fetch and cache an access token for a machine-to-machine API integration.
- Automatically refresh expired access tokens using a stored refresh token.
- Store OAuth2 client id/secret securely in a Key module entity instead of the database.
- Store a single shared token in Drupal State for a site-wide service account.
- Store per-user tokens in the private tempstore for user-specific external access.
- Define a reusable client plugin for an internal OAuth2 provider used across projects.
- Call a REST API on behalf of the site with `Bearer` tokens managed by the module.
- Add a new OAuth2 grant type by writing an `oauth2_grant_type` plugin.
- Override the "authorization_code" grant implementation via `hook_oauth2_grant_type_info_alter()`.
- Alter or extend discovered client plugin definitions with `hook_oauth2_client_info_alter()`.
- Configure the redirect/callback URL that a provider must whitelist (route `oauth2_client.code`).
- Customize where a user lands after the authorization code is captured (redirect interface).
- Restrict who can complete the code-capture route with a per-plugin access check.
- Manage multiple OAuth2 clients (different providers) as separate config entities.
- Enable/disable an OAuth2 client from the admin collection page without code changes.
- Supply resource-owner (username/password) credentials at call time for the password grant.
- Set default scopes and a scope separator per provider in the plugin attribute.
- Add extra token-request parameters (`request_options`) required by a specific provider.
- Compose custom League collaborators (grantFactory, httpClient, optionProvider) per client.
- Integrate with Google, GitHub, Azure AD, or any generic OAuth2 server via a plugin.
- Clear a stored token to force re-authentication with an external service.
- Build a service wrapper that calls `oauth2_client.service->getAccessToken($pluginId)`.
- Test OAuth2 flows against a mock server (as the example plugins do with mocklab.io).
- Keep provider credentials out of exported config by referencing a Key entity name only.
