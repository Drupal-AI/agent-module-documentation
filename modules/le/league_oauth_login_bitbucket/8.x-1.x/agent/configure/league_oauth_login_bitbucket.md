<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring League OAuth Login — Bitbucket

1. Install: `composer require drupal/league_oauth_login_bitbucket` (pulls `stevenmaguire/oauth2-bitbucket`), then `drush en league_oauth_login_bitbucket -y` (enables `league_oauth_login`).
2. In Bitbucket, create an **OAuth consumer** (Workspace settings → OAuth consumers). Set its callback URL to your site's League OAuth Login callback. Grant it account/email scope. Note the **Key** (client id) and **Secret**.
3. In Drupal, configure the Bitbucket provider (League OAuth Login settings) with:
   - `clientId` — the Bitbucket consumer key,
   - `clientSecret` — the consumer secret,
   - `redirectUri` — the callback URL registered above.
   Store the secret via the Key module / an env var rather than committing it.
4. The plugin requests `email` and `repository` scopes and reads the primary email from `/2.0/user/emails` to match/create the Drupal account.

**Note:** the authorize redirect, callback, and OAuth `state` handling are implemented by the base `league_oauth_login` module; this Bitbucket plugin only maps identity fields and does not itself weaken TLS.