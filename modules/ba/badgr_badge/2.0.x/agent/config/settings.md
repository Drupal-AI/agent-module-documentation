<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & connecting a Badgr account

## Install / enable
`drush en badgr_badge`. Requires core `node` and `file`. Installation creates three content types
(`badgr_account`, `badgr_issuer`, `badgr_badges`), their fields, form/view displays, and the
`badgr_badges` view (optional config; page at `/badgr-badges`). `hook_uninstall()`
(`badgr_badge.install`) deletes all Badgr nodes and every one of those config entities.

## Config object
`badgr_badge.badgrconfig` — schema `config/schema/badgr_badge.schema.yml`:

- `badgr_email` (string) — email of the connected badgr.com account. This is the ONLY value
  written to config. The Badgr **password is never stored**; it is used once to fetch tokens.

## Configuration form
`Drupal\badgr_badge\Form\BadgrConfigForm` (route `badgr_badge.badgr_config_form`,
`/admin/config/system/badgr-badge`, permission `administer badgr badge`, menu link under
System). Fields: `badgr_email`, `badgr_password`.

Flow:
1. **Save** (`edit-submit`): `validateForm()` posts `{username, password}` to `BadgrService::initiate()`.
   On an `error` in the response it sets a form error; on success it stashes the token payload in
   `$form_state->set('badgr_token_data', …)`.
2. `submitForm()` saves `badgr_email` to config and calls `saveBadgrAccount()`, which creates (or
   updates) the single `badgr_account` node (`field_badgr_identifier` = 1) and writes
   `field_badgr_access_token` and `field_badgr_refresh_token` from the token response, plus
   `field_badgr_email`.
3. Once `badgr_email` is set, an **Import badges** button appears (submit handler `::importBadges`).

`importBadges()` loads the primary `badgr_account` node, reads its access token, then:
- `BadgrService::listAllIssuers()` → for each result `BadgrHelpers::createIssuersContent()`.
- `BadgrService::listAllBadges()` → for each result `BadgrHelpers::createBadgesContent()`.
Errors from either fetch add a Drupal error message and abort. Re-importing updates nodes matched
by Badgr entity ID and creates any new ones.

## Permissions (`badgr_badge.permissions.yml`)
- `administer badgr badge` — the config form + import.
- `create badgr badge` — create badge nodes manually (declared; not wired to a route here).

Note: awarding via `badgr_badge.addtobackpack` is gated by `access content`, not by either
permission above. See [content/model.md](../content/model.md).
