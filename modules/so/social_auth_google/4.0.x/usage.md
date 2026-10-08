<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Social Auth Google lets visitors register and log in to a Drupal site with their Google account, plugging Google's OAuth2 into the Social Auth framework.

---

The module is a Google provider for the [Social Auth](https://www.drupal.org/project/social_auth) framework: it defines a `@Network` plugin (`social_auth_google`, social network "Google") that wraps `league/oauth2-google`, and a `GoogleAuthManager` service that builds the authorization URL, handles the callback, and fetches the user's Google profile. All the login/callback routing, user matching and account creation are provided by the base Social Auth / Social API modules; this module only adds Google specifics and a settings form. Configuration lives in the config object `social_auth_google.settings` (`client_id`, `client_secret`, `scopes`, `endpoints`, `restricted_domain`) edited at `/admin/config/social-api/social-auth/google` (permission `administer social api authentication`). You create OAuth credentials in the Google Cloud console, set the authorized redirect URI to the site's Social Auth Google callback, and paste the client id/secret here. The `openid`, `email` and `profile` scopes are always requested; extra scopes and API endpoints can be added, and `restricted_domain` limits sign-in to a single Google Workspace domain. It requires `social_auth` (and its `social_api` dependency), PHP ≥ 8.1 and the `league/oauth2-google` library; it adds no permissions or Drush commands of its own.

---

- Add a "Log in with Google" button to the Drupal login/registration flow.
- Let users register accounts using their Google identity instead of a password.
- Enable single sign-on with Google for an intranet or member site.
- Restrict Google sign-in to your organization's Google Workspace domain (`restricted_domain`).
- Auto-create Drupal accounts from Google profile data (name, email) via Social Auth.
- Map returning Google users to existing Drupal accounts by email.
- Request additional Google API scopes (e.g. YouTube, Calendar) alongside login.
- Call extra Google API endpoints after login using the auth manager.
- Store Google OAuth client id/secret in one config object for deployment.
- Reduce password-reset support by offloading auth to Google.
- Provide a faster signup for consumer-facing sites via Google login.
- Combine with other Social Auth providers (Facebook, GitHub) for multiple login options.
- Limit staff logins to corporate Google accounts only.
- Pre-fill new user profiles from the Google `profile` scope.
- Use Google as the identity provider for a decoupled front end that hits the Drupal site.
- Configure the authorized JavaScript origin and redirect URI for the OAuth client.
- Roll out Google login across environments by exporting social_auth_google.settings.
- Request the `email` scope to guarantee a verified email for each account.
- Offer social login on a community site to lower the barrier to participation.
- Swap in Google auth without writing any OAuth code (framework handles the flow).
