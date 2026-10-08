<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Patreon connects a Drupal site to the Patreon API so a creator's account, campaigns and patron data can be pulled into Drupal, with optional submodules that let patrons log in via Patreon and receive roles.

---

The base module stores Patreon OAuth client credentials via a settings form (`/admin/config/services/patreon/settings`, permission `administer patreon`) and exposes an admin OAuth callback at `patreon/oauth` (also `administer patreon`) that exchanges the returned `code` for tokens, fetches the creator, and stores the creator id and campaigns in state. The `PatreonService` wraps token exchange, user/campaign fetching and token storage. The `patreon_user` submodule links Drupal accounts to Patreon accounts and adds a public login callback at `/patreon_user/oauth` (`_access: 'TRUE'`) that logs a patron in and assigns roles based on their patron/pledge data; `patreon_extras` adds tokens and helper functionality on top.

Security note (recorded): the parent `PatreonController::oauth` verifies the OAuth `state` parameter against the session (`oauth2state`) before trusting the callback, but the `patreon_user` submodule's `PatreonUserController::oauth` (patreon/modules/patreon_user/src/Controller/PatreonUserController.php) reads only `?code=` and calls `user_login_finalize()` with **no `state`/CSRF check** — a login-CSRF weakness on the patron login callback. The callback does guard with `currentUser->isAnonymous()` and honours the "no login / only patrons" settings, but an attacker can still complete the OAuth return for a victim. Treat `administer patreon` as credential access. Typical setup: register a Patreon OAuth client, enter the client id/secret, authorise via the admin callback, then optionally enable patreon_user for patron login.

---

- Register Patreon OAuth client credentials in Drupal
- Authorise the site against the Patreon API via the admin callback
- Fetch the connected creator's account data
- Import and store the creator's campaigns
- Gate Drupal content or roles by patron status
- Let patrons log in with their Patreon account (patreon_user)
- Assign Drupal roles from Patreon pledge/tier data
- Add a "Become a patron" block to the site
- Expose Patreon data as tokens (patreon_extras)
- Store and refresh Patreon API tokens in state
- Configure login method (single sign-on vs password reset)
- Restrict registration to patrons only
- Handle the OAuth code→token exchange server-side
- Redirect returning users to a stored return path
- Link an existing Drupal user to a Patreon account
- Review Patreon API errors via the logger
- Limit Patreon administration to trusted admins
- Disable patron login while keeping API access
- Fetch a patron's membership details on login
- Use the Patreon service in custom code for API calls
