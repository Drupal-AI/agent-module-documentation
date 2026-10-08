<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Social Auth Twitter is a network-provider plugin that adds "Sign in with Twitter/X" to a Drupal site via the Social Auth + Social API framework.

---

It contributes almost no flow logic of its own: it declares a `@Network` plugin (`TwitterAuth`) wiring the third-party OAuth2 client `\Smolblog\OAuth2\Client\Provider\Twitter` and an auth manager (`TwitterAuthManager`) into the base social_auth machinery. All routing — `/user/login/twitter`, the redirect, and the callback — is provided by the parent social_auth module; this module only adds a settings tab under Social API and a Twitter button to the Social Auth login block.

The auth flow is OAuth2 authorization-code with PKCE. `getAuthorizationUrl()` requests default scopes `tweet.read`, `users.read`, `users.email`, `offline.access` (plus admin-configured extras), generates a PKCE code verifier, stores it in the session (`code_verifier`), and redirects to X. On return, social_auth's callback controller invokes `TwitterAuthManager::authenticate()`, which reads `?code`, pulls `code_verifier` from the session, and exchanges them for an access token; `getUserInfo()` then builds a `SocialAuthUser` (name, id, token, email, avatar) and social_auth logs in, creates, or links the account. Operationally the admin creates an X developer app with OAuth enabled, pastes the callback URL, and copies the API key/secret into the Drupal settings form as Client ID / Client secret (email requires "Request email from users" in the X app). Setup: configure credentials at `/admin/config/social-api/social-auth/twitter` and place the Social Auth login block.

---

- Enable "Sign in with Twitter/X" on a Drupal site.
- Add a Twitter/X button to the Social Auth login block.
- Let users register accounts using their X identity.
- Log in existing users by matching their X user id.
- Auto-link an X account to a Drupal account with the same email.
- Associate an X account with an already-authenticated user.
- Configure the API Key as the Client ID at the settings form.
- Configure the API Key Secret as the Client secret.
- Copy the generated callback URL into the X developer app.
- Request additional OAuth scopes beyond the four defaults.
- Retrieve user email from X (with app permission enabled).
- Retrieve profile name and avatar for new accounts.
- Place a link/button pointing to `/user/login/twitter`.
- Restrict administration via `administer social api authentication`.
- Define extra API endpoints to call on first authentication.
- Enable refresh tokens via the `offline.access` scope.
- Troubleshoot auth errors via the `social_auth_twitter` dblog channel.
- Support both `api.twitter.com` and `api.x.com` API domains.
- Provide passwordless social onboarding to reduce signup friction.
- Use PKCE-protected OAuth2 out of the box.
- Combine with other Social Auth providers (Google, Facebook, etc.).
- Make authenticated API requests on the user's behalf via `requestEndPoint()`.
- Migrate credentials by editing the `social_auth_twitter.settings` config.
- Disable the integration by removing credentials or unplacing the block.
