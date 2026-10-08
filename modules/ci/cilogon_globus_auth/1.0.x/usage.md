Adds turnkey OpenID Connect login clients for the CILogon and Globus Auth research-computing identity providers on top of the contributed OpenID Connect module, plus login-page and account-provisioning conveniences.

---

CILogon / Globus Auth (OSP) is a thin extension of the `openid_connect` module aimed at research and higher-education sites that authenticate against CILogon or Globus Auth. On install it seeds two OpenID Connect client configurations — CILogon (`ospclscigw`) and Globus Auth (`ospgascigw`) — pre-filled with each provider's authorize, token and userinfo endpoints and sensible default scopes, but left disabled and without credentials until an administrator supplies a Client ID and secret. The Globus plugin adds provider-specific authorize parameters for domain- or policy-restricted login (`session_required_policies`, `session_required_single_domain`, `session_message`) and RP-initiated logout that returns the user to the site. A settings form lets administrators tailor the login button label and help text globally or per client, choose non-admin roles to auto-assign to newly provisioned SSO accounts, and hide the public registration link. A custom Connected Accounts form and a login-form template with a JavaScript toggle round out the login experience, and a logout controller plus event subscriber turn stale logout clicks into friendly redirects. All the core OIDC security machinery — state token, ID-token validation, token exchange over the Drupal HTTP client, account mapping — is inherited from the parent `openid_connect` module.

---

- Add federated login to a Drupal 10/11 research site using CILogon as the identity provider.
- Add federated login using Globus Auth (Globus/ACCESS CI) as the identity provider.
- Offer both CILogon and Globus buttons on the same login page.
- Let users sign in with their campus/institutional credentials brokered through CILogon.
- Restrict Globus login to specific identity domains (e.g. `ucsd.edu,ucla.edu`) via `session_required_single_domain`.
- Enforce a Globus Auth authentication policy across all logins via `session_required_policies` (a policy UUID from the Globus project's Policies tab).
- Show a plain-text explanation on the Globus authentication screen with `session_message`.
- Store the OAuth client secret as a Key entity (Key module) instead of plaintext config.
- Customize the login button label globally with a `@client_title` placeholder (e.g. "Log in with @client_title").
- Override the button label per provider (different wording for CILogon vs Globus).
- Render rich HTML help text between the SSO buttons and the local login form, globally or per client.
- Style the Globus button as the primary call-to-action on the login page.
- Auto-provision Drupal accounts from SSO logins (delegated to OpenID Connect).
- Auto-assign one or more non-admin roles to accounts the first time SSO creates them.
- Prevent administrative roles from ever being handed out by SSO auto-provisioning (admin roles are excluded from the picker).
- Hide the public "Create new account" link by disabling the `/user/register` route while still allowing SSO provisioning.
- Show a human-readable identity-provider name ("Connected to …") on the user's Connected Accounts page instead of the raw OIDC client id.
- Provide a collapsible "Sign in with a local account" section so local logins stay available but de-emphasized.
- Return Globus users back to the site after signing out of Globus (rewrites the Globus web-logout redirect).
- Give already-signed-out users a friendly front-page redirect and status message when they click a stale "Log out" link.
- Keep transfer tokens (Globus Transfer API) in the session via a custom session subclass for downstream use.
- Change the CILogon or Globus authorize/token/userinfo endpoints or requested scopes without code changes.
- Serve as a worked example of packaging provider-specific OpenID Connect client plugins for a Drupal distribution.
