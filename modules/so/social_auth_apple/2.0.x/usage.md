Social Auth Apple adds "Sign in with Apple" to a Drupal site — a Social Auth network plugin that lets users register and log in with their Apple ID via OAuth2.

---

Built on the Social Auth / Social API framework, this module registers an `apple` network plugin (`Plugin\Network\AppleAuth`) that wraps the `patrickbussmann/oauth2-apple` League OAuth2 provider. It adds a login URL `/user/login/apple`, a callback at `/user/login/apple/callback`, an Apple button in the Social Auth Login block, and a settings form at `/admin/config/social-api/social-auth/apple` (permission `administer social api authentication`, inherited from Social Auth). Apple's authentication differs from other providers in two ways the module handles: (1) credentials are a Service ID ("Client ID"), a Team ID, a Key File ID, and a path to a downloaded `.p8` private key file (from which the provider mints the client secret JWT) rather than a static client secret — so the settings form hides the standard `client_secret` field and validates that the key file exists and contains a PEM private key; (2) when name/email scopes are requested Apple POSTs the response, but Social Auth expects a GET, so `AppleAuthController::callback()` detects a POST and 302-redirects to the same callback URL with the POSTed fields merged into the query string before delegating to the Social Auth base controller. OAuth2 `state` (CSRF) validation, session handling, user matching/creation, and error redirects are all performed by the inherited `OAuth2ControllerBase`/`OAuth2Manager`. The `AppleAuthManager` overrides `authenticate()`, `getUserInfo()` (mapping Apple's first/last name + email + id), `getAuthorizationUrl()` (default scopes `name`, `email`), and `getState()`.

---

- Let visitors register/log in to Drupal with their Apple ID.
- Add a "Sign in with Apple" button to the Social Auth Login block.
- Satisfy Apple's App Store requirement to offer Sign in with Apple alongside other social logins.
- Authenticate against Apple using a Service ID + Team ID + `.p8` key file instead of a static secret.
- Let already-logged-in users associate an Apple account with their existing Drupal account.
- Request the user's name and email from Apple on first authorization.
- Add extra OAuth scopes beyond `name`/`email` via the settings form.
- Provide the Apple "Authorized redirect URI" value to paste into the Apple Developer Service config.
- Store Apple credentials in Drupal config for a single-tenant SSO setup.
- Combine Apple login with other Social Auth providers (Google, Facebook, etc.) in one block.
- Map Apple's first/last name and email into new Drupal user accounts automatically.
- Rely on Social Auth's OAuth2 state validation to protect the login callback from CSRF.
- Bridge Apple's `form_post` response mode to Social Auth's GET-based callback flow.
- Log authentication errors to the `social_auth_apple` logger channel for debugging.
- Extend or decorate `AppleAuthManager` to customize how Apple profile data maps to users.
- Point the module at a rotated `.p8` key file by updating the key file path in config.
- Offer passwordless login for iOS/macOS users of a Drupal site.
- Use Apple's private-relay email addresses as the account email.
- Restrict configuration of the provider to trusted admins via `administer social api authentication`.
