<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Social Feed Fetcher (social_feed_fetcher) — agent index

Pulls posts from **Facebook, Twitter/X, Instagram and LinkedIn** into ordinary Drupal **nodes** of a
bundle the module installs, `social_post`. The pipeline is: a **data provider** plugin
(`Plugin/SocialDataProvider/*`) calls the platform's API through its vendor client and returns raw
items; `ImportSocialFeedService::import()` pushes each item onto a per-platform **queue**
(`social_posts_<platform>_queue_worker`); the queue workers hand each item to a matching **node
processor** plugin (`Plugin/NodeProcessor/*`) which creates a `social_post` node, mapping the post
text, link, timestamp and (downloaded) image into fields. Post text is decoded then run through
`social_feed_fetcher_linkify()` (which `htmlspecialchars()`-escapes it and auto-links URLs) and stored
with a configurable text **format**. There is **no `hook_cron`** (the implementation is commented out
in `social_feed_fetcher.module`): the enqueue step runs from the Drush command
`social_feed_fetcher:import` (alias `sff-import`); the queue workers themselves have a `cron` annotation
and drain on normal core cron.

The real entry points are the settings form at `/admin/config/social_feed_fetcher_settings`
(route `social_feed_fetcher.settings`, permission `administer socialpost entity`) where each platform's
app credentials, counts and the post text format are entered, and two OAuth redirect-callback routes,
`/oauth/callback` (LinkedIn) and `/instagram/oauth/callback`, that receive the `?code=` from the
provider's authorize flow and save the resulting access token into Drupal **State**. LinkedIn/Instagram
use an OAuth authorize→callback token exchange; Facebook uses an app-id|secret app token; Twitter uses
consumer key/secret + access token. Credentials and tokens live in the config object
`social_feed_fetcher.settings` and in State keys (`access_token`, `insta_access_token`, …).

- Depends on: `drupal:node`. The installed `social_post` content type also pulls in core
  `datetime`, `text`, `menu_ui`; the shipped view needs `views`.
- Composer libs (must be installed): `abraham/twitteroauth`, `league/oauth2-facebook`,
  `espresso-dev/instagram-basic-display-php`, `samoritano/linkedin-api-php-client-v2`.
- Core: `^10 || ^11`. Package: `Other`. Version **3.1.1**.
- Settings page / `configure`: yes — `social_feed_fetcher.settings`. Permission: one,
  `administer socialpost entity`. Drush: yes — `social_feed_fetcher:import` / `sff-import`.
- Provides config schema (`social_feed_fetcher.settings`, ~40 keys). Defines **two plugin types**:
  `SocialDataProvider` and `PluginNodeProcessor`.

## What you'd do → where

- **Enter platform credentials, pick counts / text format, connect an account, run the import** →
  [configure/settings.md](configure/settings.md)
- **Understand the fetch→queue→node pipeline, the services, the two plugin types, the routes /
  controllers / queue workers / Drush command, or add a new platform** →
  [api/services.md](api/services.md)

## Key facts (real machine names)

- Routes: `social_feed_fetcher.settings` (`/admin/config/social_feed_fetcher_settings`, `_permission:
  administer socialpost entity`), `social_feed_fetcher.authorization_code` (`/oauth/callback`, LinkedIn,
  `_access: TRUE`), `social_feed_fetcher.instagram.authorization_code` (`/instagram/oauth/callback`,
  `_access: TRUE`).
- Controllers: `Controller\AuthorizationCodeController::getResponse` (LinkedIn),
  `Controller\AuthorizationInstagramController::getResponse` (Instagram).
- Form: `Form\SocialPostSettingsForm` (form id `social_feed_fetcher`, `ConfigFormBase`).
- Services: `import_social_feed_service` (`ImportSocialFeedService`),
  `plugin.social_data_provider.manager` (`SocialDataProviderManager`),
  `plugin.manager.node_processor` (`PluginNodeProcessorManager`), `social_feed_fetcher.logger`
  (logger channel `social_feed_fetcher`), `social_feed_fetcher.linkedin.oauth.factory` +
  `social_feed_fetcher.linkedin.client`, `social_feed_fetcher.instagram.client.factory` +
  `social_feed_fetcher.instagram.client`.
- Plugin type 1 — **`SocialDataProvider`** (annotation `Annotation\SocialDataProvider`, interface
  `SocialDataProviderInterface`, base `SocialDataProviderPluginBase`, manager
  `plugin.social_data_provider.manager`, dir `Plugin/SocialDataProvider`, alter
  `social_data_provider_info`). Ids: `facebook`, `twitter`, `instagram`, `linkedin`.
- Plugin type 2 — **`PluginNodeProcessor`** (annotation `Annotation\PluginNodeProcessor`, interface
  `PluginNodeProcessorPluginInterface`, base `PluginNodeProcessorPluginBase`, manager
  `plugin.manager.node_processor`, dir `Plugin/NodeProcessor`, alter `node_processor_info`). Ids:
  `facebook_processor`, `twitter_processor`, `instagram_processor`, `linkedin_processor`.
- Queue workers (core `@QueueWorker`, `cron time=10`): `social_posts_facebook_queue_worker`,
  `social_posts_twitter_queue_worker`, `social_posts_instagram_queue_worker`,
  `social_posts_linkedin_queue_worker`.
- Drush: `social_feed_fetcher:import` (alias `sff-import`) — `Commands\SocialFeedFetcherCommands::import`.
- Content model (installed): node bundle `social_post`; fields `field_id`, `field_platform`,
  `field_post` (formatted text), `field_posted` (datetime), `field_social_feed_link` (link),
  `field_sp_image` (image). Shipped view: `social_posts` (`/…` view, access `administer socialpost
  entity`).
- Module function: `social_feed_fetcher_linkify($text)` in `social_feed_fetcher.module` (escapes +
  auto-links; used by every node processor for `field_post`).
- Config object: `social_feed_fetcher.settings`. Key State keys: `social_feed_fetcher.next_execution`,
  `access_token`/`expires_in`/`expires_in_save` (LinkedIn),
  `insta_access_token`/`insta_expires_in`/`insta_expires_in_save` (Instagram).
