<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Patreon service & OAuth surface

## The API service
`patreon.api` → `Drupal\patreon\PatreonService` wraps the Patreon API:
`tokensFromCode($code)`, `storeTokens()`, `fetchUser()`, `getValueByKey()`,
`storeCampaigns()`. Creator id and campaigns are cached in Drupal state
(`patreon.creator_id`, `patreon.campaigns`).

## OAuth callbacks (two, with different trust levels)
- **Parent** `PatreonController::oauth` (`patreon/oauth`, perm `administer patreon`):
  reads `?code=` and `?state=`, compares `state` to session `oauth2state`, clears
  the session value, and bails to `<front>` on mismatch. This is the safe,
  admin-facing authorisation flow.
- **Submodule** `PatreonUserController::oauth` (`/patreon_user/oauth`,
  `_access: 'TRUE'`): reads only `?code=`, and for anonymous users exchanges it,
  fetches the patron, assigns roles and calls `user_login_finalize()`.
  **It performs no `state`/CSRF validation** — a login-CSRF weakness. The only
  gates are `currentUser->isAnonymous()` and the `patreon_user_registration`
  mode (no-login / only-patrons / all).

## Patron login modes
`patreon_user.settings`:`patreon_user_login_method` selects single sign-on
(`user_login_finalize`) vs a password-reset mail path; `patreon_user_registration`
controls whether only patrons may log in.
