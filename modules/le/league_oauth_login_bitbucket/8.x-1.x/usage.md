<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
League OAuth Login Bitbucket is a provider plugin for the League OAuth Login module, adding **Bitbucket** as an OAuth2 login source so users can sign in to Drupal with their Bitbucket account.
---
The module supplies a single `@LeagueOauthLogin` plugin (`Bitbucket`) that wraps the `stevenmaguire/oauth2-bitbucket` League provider: it configures the client id/secret/redirect URI from `league_oauth_login_bitbucket.settings`, requests the `email` and `repository` scopes, resolves the username from the resource owner, and fetches the user's primary email from the Bitbucket API (`/2.0/user/emails`) to match or create the Drupal account. All of the OAuth flow mechanics — the authorize redirect, callback handling, state/CSRF handling, and account provisioning — live in the base `league_oauth_login` module; this plugin only provides Bitbucket-specific endpoints and field mapping. The token exchange and API calls use the League library's default HTTP client (TLS not disabled here).

Setup: `composer require` pulls the `stevenmaguire/oauth2-bitbucket` library; enable the module with `league_oauth_login`, create a Bitbucket OAuth consumer, and enter its client id/secret and redirect URI in the League OAuth Login configuration for the Bitbucket provider.
---
- Let users log in to Drupal with Bitbucket
- Add Bitbucket as a provider under League OAuth Login
- Request email and repository OAuth scopes
- Map the Bitbucket resource owner to a Drupal username
- Fetch the user's primary email from the Bitbucket API
- Provision/match Drupal accounts from Bitbucket identity
- Configure Bitbucket client id/secret/redirect URI
- Offer social/SSO login for developer-oriented sites
- Reuse the base module's OAuth callback flow
- Enable one-click Bitbucket sign-in on the login page
- Integrate Bitbucket identity into an existing League setup- Store client secret via the Key module or env var
- Register the callback URL as a Bitbucket OAuth consumer
- Combine Bitbucket with other League providers
- Map Bitbucket display name to the Drupal username
- Enable one-click developer sign-in on the login form
