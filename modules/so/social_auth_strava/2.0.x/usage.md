<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
**Social Auth Strava** adds a *Log in with Strava* button to Drupal, built on the [Social API](https://www.drupal.org/project/social_api) / [Social Auth](https://www.drupal.org/project/social_auth) framework and the `league/oauth2-client`-style Strava SDK. Anonymous users authorize at Strava, are redirected back, and Social Auth matches or creates a Drupal account keyed to their Strava athlete id.

---

A Network plugin `StravaAuth` (`initSdk()`) constructs a `Strava\API\OAuth` client from the configured `client_id` / `client_secret` and the module's callback redirect URI. The controller `StravaAuthController` exposes two anonymous routes (both `no_cache: TRUE`): `/user/login/strava` (`redirectToStrava`) builds the authorization URL (scopes default `read_all`) and issues a `TrustedRedirectResponse` to Strava; `/user/login/strava/callback` (`callback`) exchanges the returned `code` for an access token via `StravaAuthManager::authenticate()`, fetches athlete info with `getUserInfo()`, and hands name / email / athlete-id / token / picture to `social_auth`'s `UserAuthenticator::authenticateUser()`. Because Strava no longer returns an email, `getUserInfo()` sets email to `NULL`, so Social Auth matches purely on the Strava athlete id via its provider-mapping table rather than by email. Settings form `social_auth_strava.settings_form` (`/admin/config/social-api/social-auth/strava`, permission *administer social api authentication*) stores client id/secret and comma-separated scopes. Token exchange runs server-to-server over the SDK's HTTPS client.

---

- Add a *Log in with Strava* button to the user login page.
- Let athletes register a Drupal account with their Strava identity.
- Configure the Strava app client id and secret in admin settings.
- Request specific Strava OAuth scopes (default `read_all`).
- Match returning users to their account by Strava athlete id.
- Store the Strava access token in session for later API calls.
- Set the athlete's avatar as the Drupal user picture on first login.
- Redirect anonymous users to Strava's consent screen.
- Use the standard Social Auth login/redirect user experience.
- Combine with other Social Auth providers (Google, Facebook, etc.).
- Drive downstream Strava API calls from event subscribers using the stored token.
- Restrict who can configure the provider via *administer social api authentication*.
- Rely on Social Auth for account creation, blocking and data policy.
- Provide social login on a fitness / cycling community site.
- Let event subscribers react to a successful Strava login.
- Theme the login button through Social Auth's block/links.
- Map Strava profile name to the Drupal username on registration.
