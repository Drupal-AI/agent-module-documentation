<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# League Oauth Login Bitbucket (league_oauth_login_bitbucket) — agent index

**A Bitbucket provider plugin for League OAuth Login; wraps `stevenmaguire/oauth2-bitbucket` to allow Drupal login via Bitbucket OAuth2.**

- **Version:** 8.x-1.x
- **Core:** ^8 || ^9 || ^10 || ^11
- **Dependency:** `league_oauth_login` (base module owns the flow).
- **Plugin:** `@LeagueOauthLogin(id="bitbucket")` — scopes `email`,`repository`; email from `https://api.bitbucket.org/2.0/user/emails`.
- **Config:** `league_oauth_login_bitbucket.settings` → `clientId`, `clientSecret`, `redirectUri` (set via base module's UI).

**Notes:** thin provider plugin; token exchange/API calls use the League library's default client (TLS not disabled in this code). The OAuth authorize/callback/state handling belongs to the base `league_oauth_login` module.

See [configure/league_oauth_login_bitbucket.md](configure/league_oauth_login_bitbucket.md).