Social Feed fetches recent posts from a Facebook Page, an X (Twitter) account, and/or an Instagram professional account and renders them as themeable Drupal blocks, with per-platform credentials and display options set globally or overridden per block.

---

The module provides three block plugins — `facebook_post`, `twitter_post`, `instagram_post` — each
extending a shared `SocialBlockBase`. Global credentials/display settings live in three config objects
(`socialfeed.facebook.settings`, `socialfeed.twitter.settings`, `socialfeed.instagram.settings`) edited
at platform settings forms under `admin/config/services/socialfeed` (`configure` route
`socialfeed.configuration`; all gated by the `administer socialfeed` permission). A block may enable a
**Customize Feed** override to supply its own credentials/options (override fields are only accessible to
users with `administer socialfeed`). Posts are retrieved by per-platform collector services built through
factories (`socialfeed.facebook`/`twitter`/`instagram`): Facebook uses `facebook/php-business-sdk` and
the Guzzle HTTP client; X uses `noweh/twitter-api-v2-php` (X API v2, results cached ~1 hour to conserve
paid API credits); Instagram uses the Instagram Graph API via `InstagramApiService`, with an OAuth
callback controller at `/socialfeed/instagram/auth` (permission-gated) that exchanges the code for a
long-lived token stored in config and auto-refreshed. Rendering goes through per-platform theme hooks and
templates (`socialfeed_facebook_post`, `socialfeed_twitter_post`, and three Instagram media types) whose
preprocess functions in `templates/*/socialfeed.*.theme.inc` handle hashtag/mention linking, URL
conversion, text trimming, and relative time formatting (via `nesbot/carbon`). Remote post text
(Facebook message, tweet text) is emitted through Drupal `#markup`, so it is run through
`Xss::filterAdmin()` (script/handlers stripped, broad tag set allowed) rather than a strict allow-list —
see `agent/theming/render.md`. Optional per-platform CSS libraries style the default markup. Requires
PHP ≥ 8.2; note the X free API tier cannot read posts and Instagram requires a Professional account.

---

- Show a Facebook Page's recent posts in a sidebar or footer block.
- Display a feed of an X (Twitter) account's latest posts.
- Show an Instagram professional account's images, videos, and carousel albums.
- Filter Facebook posts by type (status, photo, video, shared/published story) or show all types.
- Limit how many posts each block displays (per-platform count setting).
- Trim long post text to a configured length.
- Auto-link hashtags to the platform (and @mentions for X).
- Convert bare URLs in tweets into clickable links.
- Show a "Read More" teaser link back to the original post.
- Display absolute or relative ("2 hours ago") timestamps on posts.
- Configure the date/time format for displayed post times.
- Run multiple blocks of the same platform, each pointed at different credentials via per-block override.
- Keep credentials centralized (global settings) and just place blocks with no per-block config.
- Restrict who can configure feeds / place credential overrides via the `administer socialfeed` permission.
- Cache X API responses for an hour to stay within paid post-read limits.
- Complete Instagram OAuth via the built-in `/socialfeed/instagram/auth` callback to obtain a long-lived token.
- Rely on automatic Instagram token refresh (renewed after ~50 of 60 days at the global level).
- Theme each platform's post markup by overriding its Twig template.
- Add theme suggestions per Facebook post `status_type` (e.g. `socialfeed_facebook_post__added_photos`).
- Toggle the bundled default CSS styling per platform ("Use Default UI Style").
- Resolve a Facebook page name to its numeric page ID and store a page access token via the settings form's test/connect step.
- Provide social proof on a marketing site by embedding live social content.
- Show a wall of brand posts aggregated from multiple networks by placing all three blocks together.
