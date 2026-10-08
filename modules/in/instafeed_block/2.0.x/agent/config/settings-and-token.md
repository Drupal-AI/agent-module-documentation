<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form, token storage, and cron refresh

## Global settings form

**Route:** `instafeed_block.settings_form` · **Path:** `/admin/config/media/instafeed-block`
**Permission:** `administer site configuration` · **Menu:** under Configuration → Media
(`instafeed_block.links.menu.yml`, parent `system.admin_config_media`).
**Class:** `Drupal\instafeed_block\Form\InstafeedBlockSettingsForm` (a plain `FormBase`, injects
`messenger` and `state`).

One meaningful field: **Instagram Access Token** (`instagram_token`, textfield, maxlength 500).
`submitForm()` writes it to State (`instafeed_block.access_token`), shows a success message, and runs
`drupal_flush_all_caches()`. The form also displays an *estimated* expiration date (State key
`instafeed_block.token_expiration`) and the last/next cron refresh dates (State key
`instafeed_block.last_execution`) — read-only informational markup.

## Where the token lives

State API (the `key_value` table), **not** configuration and **not** a Key entity. Three State
keys, all removed on uninstall (`hook_uninstall`):

- `instafeed_block.access_token` — the Instagram long-lived access token.
- `instafeed_block.token_expiration` — timestamp, only set after a successful cron refresh.
- `instafeed_block.last_execution` — timestamp of the last cron refresh attempt.

The block copies the token into `drupalSettings` so instafeed.js (in the browser) can call the
Instagram Graph API — that is the module's client-side design.

## Automatic token refresh on cron

`InstafeedBlockHooks::cron()` (`src/Hook/InstafeedBlockHooks.php`, wrapped by the `#[LegacyHook]`
`instafeed_block_cron()` in `.module`) refreshes the long-lived token at most **once a month**
(`last_execution < strtotime('-1 month')`), and **only** when both:

- `$settings['production_url']` is set in settings.php, AND
- it equals `\Drupal::request()->getHost()` (the current request host).

The value must be a bare host with no scheme and no trailing slash, e.g.
`$settings['production_url'] = 'example.com';`. If the guard fails it logs a warning and does
nothing. **Set it on exactly one environment.** Instagram invalidates the previous token when a new
one is issued, so refreshing from staging would break production.

The refresh helper `instafeed_block_fetch_new_token()` (`.module`) cURLs
`https://graph.instagram.com/refresh_access_token?grant_type=ig_refresh_token&access_token=<current>`.
The endpoint URL is fixed (no user input → no SSRF), and TLS verification is left at cURL defaults
(peer/host verification enabled — `CURLOPT_SSL_VERIFYPEER`/`VERIFYHOST` are not disabled). On HTTP
200 it stores the new token and computed expiration in State; otherwise it logs an error with the
HTTP code.

## Requirements / install notes

`hook_requirements` (runtime) and `hook_install` check that
`/libraries/instafeed.js/dist/instafeed.min.js` exists and flag a status-report error if not; 2.x
uses `DeprecationHelper`/`RequirementSeverity` for Drupal 11.2+ severity-constant compatibility.
`instafeed_block_update_8101()` warns if the library folder is misnamed (older installs used
`instafeed-js`; it must be `instafeed.js`). There is no config schema. The only service declared is
the autowired hook class in `instafeed_block.services.yml`.
