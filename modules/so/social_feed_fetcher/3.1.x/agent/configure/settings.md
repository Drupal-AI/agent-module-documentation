# Settings form, credentials and the import run (configure)

All configuration lives in one config object, **`social_feed_fetcher.settings`**, edited at
**`/admin/config/social_feed_fetcher_settings`** (route `social_feed_fetcher.settings`, form
`Form\SocialPostSettingsForm`, form id `social_feed_fetcher`). Access needs the permission
**`administer socialpost entity`**. The form is a `ConfigFormBase`; on submit it copies **every**
`$form_state` value into the config object (`foreach ($form_state->getValues() as $key => $value)`).

## Per-platform sections

Each platform has an `Enable` checkbox; the credential fields below it are shown/required via
`#states` only when that platform is enabled.

- **Facebook** — `facebook_enabled`, `fb_page_name` (the `YOUR_PAGE_NAME` from the page URL),
  `fb_app_id`, `fb_secret_key`, `fb_user_token` (optional; page/user token), `fb_no_feeds` (1–30).
  The provider builds an app token as `fb_app_id . '|' . fb_secret_key` when no user token is set.
- **Twitter/X** — `twitter_enabled`, `timeline` (`home` | `user` | `mention`), `screen_name`
  (required when `timeline=user`, enforced in `validateForm`), `tw_consumer_key`,
  `tw_consumer_secret`, `tw_access_token`, `tw_access_token_secret` (used as bearer token when no
  access token is set), `tw_count` (1–30). README notes Twitter fetch works only on live hosts.
- **Instagram** — `instagram_enabled`, `in_client_id`, `in_client_secret`, `in_picture_count` (1–30),
  `in_post_link`. Uses the OAuth authorize→callback flow (see below).
- **LinkedIn** — `linkedin_enabled`, `linkedin_feed_type` (`companies` | `people`),
  `linkedin_companies_id` (shown when `companies`), `linkedin_client_id`, `linkedin_secret_app`,
  `linkedin_posts_count` (1–30). Uses the OAuth authorize→callback flow (see below).

## Global settings

- `social_feed_fetcher_interval` — throttle for `ImportSocialFeedService::import()` (values 60 →
  86400 seconds). Import re-runs only when `now >= State['social_feed_fetcher.next_execution']`.
- `formats_post_format` — the text **format** applied to `field_post` on every created node (populated
  from `filter_formats()`; e.g. `basic_html`, `full_html`). Choose a format whose filters suit
  imported text.
- **Run cron now** — a submit button (`cronRun`) shown only to users with `administer site
  configuration`; it zeroes `next_execution` and calls the core cron service (which drains the queue
  workers). Note there is no `hook_cron`, so this button does not itself enqueue new posts — use the
  Drush command for the fetch step.

## Connecting an OAuth account (Instagram / LinkedIn)

Once `*_client_id` and `*_secret` are filled and saved, the form shows a **URL connector** link to the
platform's authorize URL, built with the site redirect URI `…/instagram/oauth/callback` (Instagram) or
`…/oauth/callback` (LinkedIn) and scopes (`user_profile,user_media` for Instagram;
`r_liteprofile`/`r_emailaddress`/`w_member_social` for LinkedIn). After the user authorizes, the
platform redirects back to that callback route with `?code=…`; the controller exchanges the code and
stores the token in **State** (`insta_access_token` / `access_token` plus `*_expires_in*`). The form
then shows a connected/disconnected message computed from `expires_in_save + expires_in > time()`.
Tokens expire (~60 days) and must be refreshed by repeating the connect step.

## Running the import

1. `drush social_feed_fetcher:import` (alias `sff-import`) — calls
   `import_social_feed_service->import()` (enqueues new posts for every enabled platform, honouring
   the interval) and then drains all four queues immediately.
2. Or let core cron drain the queues after items have been enqueued by the Drush command.

## Config keys (schema `social_feed_fetcher.settings`)

Booleans: `facebook_enabled`, `twitter_enabled`, `instagram_enabled`, `linkedin_enabled`,
`in_post_link`, plus display flags present in schema (`all_types`, `display_pic`, `display_video`,
`hashtag`, `time_stamp`, `time_ago`). Strings/ints include `fb_page_name`, `fb_app_id`,
`fb_secret_key`, `fb_user_token`, `fb_no_feeds`, `tw_consumer_key`, `tw_consumer_secret`,
`tw_access_token`, `tw_access_token_secret`, `tw_count`, `in_client_id`, `in_picture_count`,
`linkedin_client_id`, `linkedin_secret_app`, `linkedin_posts_count`, `formats.post_format`. (The
runtime writes additional keys the schema does not list — `timeline`, `screen_name`,
`in_client_secret`, `linkedin_feed_type`, `linkedin_companies_id`, `social_feed_fetcher_interval`,
`formats_post_format` — because the form persists all submitted values.)

All API secrets/tokens are stored as plaintext in this config object; treat an export of
`social_feed_fetcher.settings` as sensitive and keep it out of committed config where possible.
