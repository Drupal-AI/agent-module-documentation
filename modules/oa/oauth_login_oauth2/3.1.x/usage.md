miniOrange OAuth Login turns your Drupal site into an OAuth 2.0 / OpenID Connect **client** (relying party), letting users sign in with an external provider (Microsoft Entra ID/Azure AD, Azure B2C, Keycloak, Okta, Google, AWS Cognito, Discord, Salesforce, GitHub, or any custom OAuth/OIDC server) via the Authorization Code flow.

---

You configure a single OAuth application on the *Configure Application* tab (`admin/config/people/oauth_login_oauth2/config_clc`): client ID, client secret, scope, and the authorize / access-token / userinfo endpoints, plus whether client credentials are sent in the request body or in an HTTP Basic `Authorization` header. Login is initiated at `/moLogin`, which redirects to the provider's authorize endpoint with a base64-encoded JSON `state` (stored in the PHP session as `oauth2state`). The provider redirects back to `/mo_callback`, where the module exchanges the `code` for an access token (`AccessToken::getAccessToken`), calls the userinfo endpoint (`UserResource::getResourceOwner`), flattens the returned profile, and matches the configured **email attribute** to an existing Drupal user via `user_load_by_mail()`, then calls `user_login_finalize()`. A *Test Configuration* flow (`/testSSO` → `/mo_callback` with `state.test_sso`) round-trips a real login to display the attributes the provider returns so an admin can pick the email attribute. Settings persist in the `oauth_login_oauth2.settings` config object; the client secret is encrypted at rest with a key derived from the site's private key (`Utilities::encrypt`/`decrypt`). The **free** version documented here only logs in *existing* Drupal users (no auto-provisioning), supports one provider, and gates all admin pages behind core's `administer site configuration` permission. Attribute-to-field and role mapping, auto-create, multiple providers, page/domain restriction, and custom redirects are premium-only upsells shown but disabled in the UI. All outbound HTTP calls run through `Utilities::callService()`, which uses Guzzle.

---

- Let users log into Drupal with Microsoft Entra ID / Azure AD credentials.
- Add "Login with Google" (or Okta, Keycloak, Auth0, Cognito, etc.) to the Drupal login form.
- Act as an OIDC relying party for a corporate identity provider using the Authorization Code flow.
- Match an incoming OAuth identity to an existing Drupal account by email address.
- Show an extra "Login with <provider>" link on the standard `/user/login` page.
- Send client credentials to the token endpoint either in the POST body or as an HTTP Basic header, per provider requirements.
- Configure authorize / token / userinfo endpoints manually for a custom OAuth server.
- Run a Test Configuration round-trip to see exactly which attributes the provider returns.
- Pick which returned attribute holds the user's email address after testing.
- Restrict which endpoint scopes are requested (e.g. `openid email profile`).
- Store the OAuth client secret encrypted at rest (derived from the site private key).
- Force HTTPS on the callback URL via the Base URL setting when behind a TLS-terminating proxy.
- Enable verbose module logging to debug token/userinfo responses in the Drupal log.
- Deep-link login initiation with a `destination` query param to return the user to a specific page after SSO.
- Provide SSO for intranet/staff Drupal sites where accounts already exist.
- Integrate with Keycloak or Ping Federate for enterprise SSO.
- Use as the login layer alongside miniOrange 2FA or REST API authentication modules.
- Brand the login entry point with a custom display link label.
- Evaluate an OAuth/OIDC provider's claims before committing to full attribute mapping (premium).
- Centralize authentication in an external IdP so Drupal never stores passwords for SSO users.
