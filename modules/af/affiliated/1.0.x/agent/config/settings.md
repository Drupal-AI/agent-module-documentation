<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Affiliated — configuration

Install/enable: `composer require drupal/affiliated`, `drush en affiliated`. `hook_install()`
(`affiliated.install`) creates one default campaign (`is_default=1`, `is_global=1`, published).
Grant "act as an affiliate" to would-be affiliates; grant the reporting/admin permissions as needed
(see [entities/model.md](../entities/model.md)).

## Config object `affiliated.settings`

Edited at `/admin/config/affiliate/settings` (route `affiliated.settings`, form
`Form\AffiliateSettingsForm`, permission `admin affiliate settings`). Schema in
`config/schema/affiliated.schema.yml`; install defaults in `config/install/affiliated.settings.yml`.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `cookie_lifetime` | text (strtotime) | `30 days` | Cookie validity; `0` = until browser close. Fed to `strtotime('+' . value)`. |
| `affiliate_key` | text | `affiliate` | URL query var holding the affiliate code. |
| `campaign_key` | text | `affiliate_campaign` | URL query var holding the campaign code. |
| `affiliate_code_type` | text | `user_id` | `user_id` or `username` — how the affiliate code maps to an account. |
| `allow_owner` | bool | `false` | If false, an affiliate clicking/converting on their **own** link is not recorded (`registerClick` returns FALSE → no cookie). |
| `click_precedence` | text | `overwrite` | When a visitor already has a cookie: `overwrite` (new click wins if affiliate or campaign changed) or `deny` (keep first). |
| `store_clicks` | bool | `true` | Create an `affiliate_click` entity per visit. Off = cookie-only tracking (conversions still work). |
| `click_retention` | int (hours) | `720` | Cron deletes clicks older than this; `0` = keep forever. |
| `overview` | text_format | empty/basic_html | Body of the Affiliate Center dashboard; the literal `!affiliate_params` is replaced with the affiliate's URL query string. |
| `path_visibility_mode` | string | `all_pages` | `all_pages` (track everywhere except listed) or `listed_pages` (only listed). |
| `path_visibility_paths` | text | `/admin`, `/node/add/*`, `/node/*/edit` | Path patterns for the mode above (`*` wildcard, `<front>` token). |
| `exclude_roles` | sequence of role ids | `[]` | Users with any listed role are never tracked. |

## Tracking-visibility logic (`affiliated.module`)

- `hook_page_attachments()` attaches `drupalSettings.affiliated` (`affiliate_key`, `campaign_key`)
  and the `affiliated/affiliated.track` library only when `_affiliated_request_should_be_tracked()`
  is TRUE — i.e. not an admin route and passing `_affiliated_visibility_pages()` (path matcher over
  `path_visibility_paths` XOR-ed with the mode). Adds cache tag `config:affiliated.settings`.
- The client `js/affiliated.track.js` (`Drupal.behaviors.affiliatedTrack`) reads the affiliate code
  from the current URL and `fetch()`-POSTs `{affiliate, campaign, landingPage, referrerUrl}` to
  `Drupal.url('affiliated/track')`.
- `AffiliatedTrackerController::track()` additionally skips users whose roles are in `exclude_roles`
  (`shouldTrackUser()`).

## hook_cron()

`affiliated_cron()` deletes up to 100 `affiliate_click` entities per run older than
`click_retention` hours (skipped when retention `<= 0`).
