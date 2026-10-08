OpenID Connect provides a pluggable OpenID Connect / OAuth 2.0 client so an external identity provider (Google, Okta, GitHub, Facebook, LinkedIn, or any generic OIDC server) can authenticate and log in Drupal users. Each provider is a client config entity backed by an `openid_connect_client` plugin.

---

The module ships as a client (relying party) implementation of OpenID Connect 1.0, the identity layer on top of OAuth 2.0. Administrators create one **OpenID Connect client** config entity per identity provider at Admin → Configuration → People → OpenID Connect clients; each entity references a client plugin (`generic`, `google`, `okta`, `github`, `facebook`, `linkedin`) and stores its client ID, client secret, prompt options and endpoint URLs. The login flow runs through a redirect controller: the client's `authorize()` sends the user to the provider's authorization endpoint with a CSRF state token, the provider returns to `/openid-connect/{client}`, and the client exchanges the code for tokens (`retrieveTokens()`) and profile data (`retrieveUserInfo()`). The central `OpenIDConnect` service then completes authorization — matching, connecting or creating a Drupal account via the `externalauth` authmap, and mapping OIDC claims to user fields per the `userinfo_mappings` setting. A configurable Claims service enumerates the standard OIDC claims/scopes, and role mappings can grant Drupal roles from provider data. The Generic client supports `.well-known` endpoint auto-discovery from an issuer URL. Site behavior — auto-connecting existing users, saving userinfo on every login, provider-initiated single logout, showing providers on the login form, and autostart login — is controlled by the `openid_connect.settings` config object, and a "Sign in with" block plus a per-user "Connected Accounts" form round out the UX. Extensive alter/authorize hooks let modules customize claims, userinfo, account selection and logout. This is a 3.0.x alpha release (`3.0.0-alpha8`) that depends on core `file` and the contrib `externalauth` module.

---

- Let users log in to Drupal with their Google account.
- Add single sign-on against Okta, Azure AD, Auth0, Keycloak or any OIDC-compliant identity provider using the Generic client.
- Authenticate users through GitHub, Facebook or LinkedIn OAuth.
- Auto-create a Drupal account the first time someone signs in with an external provider.
- Connect an external identity to an existing local account by matching email (`connect_existing_users`).
- Let users link/unlink multiple providers to their account via the Connected Accounts form.
- Map OIDC claims (name, email, given_name, picture, zoneinfo, phone, address, …) onto Drupal user fields.
- Grant Drupal roles based on provider-supplied data using role mappings.
- Auto-discover a provider's authorization/token/userinfo endpoints from its `.well-known` issuer URL.
- Place a "Sign in with" block on the login page showing a button per enabled provider.
- Show or hide external providers directly on the core user login form.
- Automatically start the login redirect for a single configured provider (`autostart_login`).
- Propagate logout to the identity provider (single logout / end session) when a user logs out of Drupal.
- Require users to set a local password before disconnecting from an external provider.
- Restrict which domains may initiate SSO via the `iss` parameter (allowed domains).
- Configure the OAuth `prompt` parameter (none / login / consent / select_account) per client.
- Re-save mapped userinfo to the account on every login (`always_save_userinfo`), or only on creation.
- Override site registration settings so external logins can create accounts even when open registration is off.
- Add a custom identity provider by implementing an `openid_connect_client` plugin.
- Override or extend an existing client plugin's behavior via `hook_openid_connect_client_info_alter()`.
- Add extra OIDC claims to the mapping UI with `hook_openid_connect_claims_alter()`.
- Preprocess or translate provider userinfo before mapping with `hook_openid_connect_userinfo_alter()`.
- Allow or deny specific accounts at login time with `hook_openid_connect_pre_authorize()`.
- Copy additional provider data (e.g. roles, custom fields) to the account with `hook_openid_connect_userinfo_save()`.
- Redirect users to a chosen path after login or logout (`redirect_login` / `redirect_logout`).
- Look up standard claims and the scopes they require programmatically via the `openid_connect.claims` service.
- Build a fully decoupled login where the provider redirect is initiated for a specific client.
