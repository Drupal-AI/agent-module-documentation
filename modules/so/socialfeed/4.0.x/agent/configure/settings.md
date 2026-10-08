# Configure Social Feed

Landing page `admin/config/services/socialfeed` (route `socialfeed.configuration`) links to three
platform forms, each requiring `administer socialfeed`:

| Platform | Route | Path | Config object |
|---|---|---|---|
| Facebook | `socialfeed.facebook_settings_form` | `/admin/config/socialfeed/facebook` | `socialfeed.facebook.settings` |
| X (Twitter) | `socialfeed.twitter_settings_form` | `/admin/config/socialfeed/twitter` | `socialfeed.twitter.settings` |
| Instagram | `socialfeed.instagram_settings_form` | `/admin/config/socialfeed/instagram` | `socialfeed.instagram.settings` |

## Facebook keys (`socialfeed.facebook.settings`)

`page_name`, `page_id`, `app_id`, `secret_key`, `user_token`, `page_permanent_token`, `no_feeds` (10),
`all_types` (true), `post_type`, `display_pic`, `display_video`, `trim_length` (120),
`teaser_text` ("Read More"), `hashtag`, `time_stamp`, `time_format` (`d-M-Y`), `use_facebook_style`.
The settings form's test/connect step resolves the page name to a numeric `page_id` and stores a
`page_permanent_token`. Displays Page posts only (not personal profiles).

## X / Twitter keys (`socialfeed.twitter.settings`)

`consumer_key`, `consumer_secret`, `access_token`, `access_token_secret`, `bearer_token`, `account_id`,
`tweets_count` (3), `hashtag` (true), `time_stamp` (true), `time_format` (`d-M-Y`), `time_ago` (true),
`trim_length` (280), `teaser_text`, `use_twitter_style`. Needs a Bearer Token + numeric Account ID.
Responses are cached ~1h (invalidated on save). The free API tier cannot read posts — paid credits are
required.

## Instagram keys (`socialfeed.instagram.settings`)

`client_id`, `app_secret`, `redirect_uri`, `access_token`, `access_token_date`, `picture_count` (3),
`video_thumbnail`, `time_format`, `post_link` (true), `use_instagram_style`. Requires a Professional
(Creator/Business) account on the Instagram **Graph** API (Basic Display was discontinued 2024-12-04).

### Instagram OAuth callback

Route `socialfeed.instagram_auth` → `/socialfeed/instagram/auth` (permission `administer socialfeed`),
controller `InstagramAuthController::accessToken()`. It takes the `code` query param, exchanges it for a
short-lived token, then a long-lived (~60 day) token, and saves `access_token` + `access_token_date`.
Long-lived tokens are auto-refreshed after ~50 days at the **global** level; per-block token overrides
must be renewed manually.

## Per-block overrides

Each block (`facebook_post`/`twitter_post`/`instagram_post`) has a **Customize Feed** checkbox
(`SocialBlockBase::blockForm()`), visible only to users with `administer socialfeed`. When enabled, the
block stores its own credentials/display values (`getSetting()` prefers block config over global). If the
global config is incomplete, the override is forced on and non-privileged users are blocked from placing
it (a validator prevents submission). Set defaults globally to avoid per-block credential entry.

## Blocks

Place via *Structure → Block layout*: **Facebook Block**, **X (formerly Twitter) Post Block**,
**Instagram Post Block**. Each block's `build()` fetches posts through the platform collector and renders
an `item_list` of themed posts, cached for 1 hour with the config's cache tags/contexts.
