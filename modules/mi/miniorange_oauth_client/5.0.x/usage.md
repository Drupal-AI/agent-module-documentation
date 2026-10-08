miniOrange OAuth Client turns a Drupal site into an OAuth 2.0 / OpenID Connect **client (relying party)**, letting users log in through an external Identity Provider (IdP) via Single Sign-On, with per-IdP configuration, attribute-to-user mapping, and login auditing.

---

You define one or more IdP connections as `mo_client_config` config entities (client id/secret, authorize / token / userinfo endpoints, scope, grant type, OAuth-vs-OpenID protocol). Each connection exposes two anonymous routes: an authorization-request entry point (`/mo-oauth-client/user/login/{config}`) that builds the provider redirect and stores an anti-CSRF `state` in the session, and a callback (`/mo-oauth-client/callback/{config}`) that validates that `state`, exchanges the authorization code for a token, fetches the resource-owner profile from the userinfo endpoint, and logs the user in. Fetched claims are mapped to Drupal fields through an Attribute Mapping entity (the email/SSO-login attribute is required); licensed tiers add role, group and profile mapping plus auto-provisioning of new users. Admin screens (all gated by the `mo_administrator` permission, under *Configuration → People → miniOrange OAuth Client*) cover client setup, a test-connection flow, module settings (force login / replace the Drupal login form / login link + block), import/export of configuration, logging, and Login Reports. Community (free) tier only logs in **existing** users matched by email; new-user creation, non-email login attributes, and advanced mapping require a paid license validated against miniOrange servers. Logout hooks and an optional front-channel-logout HTTP middleware support Single Logout back to the IdP. The module ships a bundled JWT/RSA helper (`src/MoHelper/JWTHandler`) for OpenID id-token handling.

---

- Let users sign in to Drupal through an external OAuth2/OIDC provider (Keycloak, Azure AD/Entra, Okta, Auth0, Google, etc.).
- Configure multiple IdPs on one site, each as its own `mo_client_config` entity.
- Use the Authorization Code grant (with or without PKCE) for standard server-side SSO.
- Use Implicit, Resource-Owner Password, or Refresh-Token grants where the IdP requires them.
- Switch a connection between raw OAuth 2.0 and OpenID Connect protocol handling.
- Map an IdP claim (e.g. `email`, `preferred_username`) to the Drupal account used for login.
- Auto-create Drupal users from IdP claims on first login (licensed tiers).
- Map IdP claims to Drupal user profile fields via Attribute Mapping.
- Assign Drupal roles from IdP attributes/groups via Role and Group Mapping (licensed tiers).
- Restrict which users may SSO by email domain or by IdP role/attribute.
- Add a "Login with <IdP>" link/button to the Drupal login form or as a block.
- Force all login through the IdP by replacing the Drupal login page, with a `?mo_force_stop_redirect=true` escape hatch for admins.
- Redirect users to a chosen destination (or their originating page) after successful login.
- Run a built-in Test Connection to inspect exactly which attributes the IdP returns before going live.
- Audit every SSO attempt (initiated / success / failed) in the Login Reports list.
- Tie the Drupal session lifetime to the IdP token expiry and act (log out / renew) when it lapses.
- Perform Single Logout (SLO) and front-channel logout back to the IdP on Drupal logout.
- Import or export the module's configuration between environments.
- Send the current interface language to the IdP and map IdP locale claims back to Drupal languages.
- Drive SSO from your own code by handing a pre-obtained token to `performSsoInDrupalByToken()`.
- Hook into the flow (state build, pre/post authorization, post-token, post-resource-owner) to customize requests and claims.
- Revoke the IdP token on logout when the provider supports token revocation.
- Provide social/enterprise login without writing a custom OAuth client from scratch.
