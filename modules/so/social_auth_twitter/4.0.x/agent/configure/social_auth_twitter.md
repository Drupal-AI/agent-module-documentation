<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Social Auth Twitter

**Settings form:** `/admin/config/social-api/social-auth/twitter`
(route `social_auth_twitter.settings_form`, permission `administer social api authentication`).
Requires the base **social_auth** module (which owns the login/redirect/callback routes).

## X / Twitter developer app

1. Create an app in the X Developer Portal with OAuth enabled.
2. Copy the **Callback URL** shown (disabled) on the Drupal settings form into the app's
   allowed callback/redirect URLs.
3. To receive email, enable **"Request email from users"** in the app.
4. Copy the app's **API Key → Client ID** and **API Key Secret → Client secret** into the form.

## Settings (`social_auth_twitter.settings`)

| Key | Meaning |
|---|---|
| `client_id` | X app API key |
| `client_secret` | X app API secret |
| `scopes` | Extra OAuth scopes appended to the defaults |
| `endpoints` | Extra API endpoints to call on first authentication |

Default scopes requested: `tweet.read`, `users.read`, `users.email`, `offline.access`
(`offline.access` yields a refresh token).

## Flow (OAuth2 authorization-code + PKCE)

1. User hits `/user/login/twitter` (route from social_auth).
2. `TwitterAuthManager::getAuthorizationUrl()` builds the authorize URL, generates a PKCE
   `code_verifier`, stores it in the session, and redirects to X.
3. On callback, social_auth's controller calls `TwitterAuthManager::authenticate()`, which reads
   `?code`, pulls `code_verifier` from the session, and exchanges them for an access token.
4. `getUserInfo()` → `getResourceOwner()` builds a `SocialAuthUser` (id, name, email, avatar, token);
   social_auth matches on X id / email and logs in, creates, or links the account.

State/CSRF handling and the callback route belong to base social_auth. Token exchange uses the
Smolblog/League Twitter OAuth2 provider with default (verified) TLS. API domain
`https://api.twitter.com` (also `api.x.com`) is used for authenticated requests via
`requestEndPoint()`.

## Placement

Place the **Social Auth login block** (from social_auth) to show the Twitter/X button, or link
directly to `/user/login/twitter`.
