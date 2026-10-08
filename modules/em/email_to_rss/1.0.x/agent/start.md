<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Email to RSS (email_to_rss) — agent index

Fetches messages from an **IMAP mailbox folder** and publishes them as an **RSS 2.0 feed** at a
per-feed token URL. Core `^10 || ^11`, PHP `>=8.2`, GPL-2.0-or-later. Version 1.0.0.

- **Composer dep:** `webklex/php-imap` `^6.2` (only library; no Drupal module deps).
- **No** permissions file, plugin types, or Drush commands. Provides config schema.

## What it provides

- **Config:** single config object `email_to_rss.settings` (`imap` mapping + `feeds` sequence).
  Settings form `Form\SettingsForm` at `/admin/config/services/email-to-rss`
  (`_permission: administer site configuration`). Schema in `config/schema/email_to_rss.schema.yml`,
  install defaults in `config/install/email_to_rss.settings.yml`. → [config/settings.md](config/settings.md)
- **Routes** (`email_to_rss.routing.yml`):
  - `email_to_rss.feed` — `/feeds/email-to-rss/{feed_id}/{token}` → `Controller\FeedController::feed`
    (RSS XML). `_access: TRUE`; gated by per-feed `token`.
  - `email_to_rss.item` — `/feeds/email-to-rss/{feed_id}/{token}/items/{item_id}` →
    `FeedController::item` (per-message HTML page).
  - `email_to_rss.settings`, `email_to_rss.delete_feed`, `email_to_rss.delete_feed_items` — admin,
    `administer site configuration`.
- **Services** (`email_to_rss.services.yml`): `Source\WebklexImapSource` (aliased to
  `Source\EmailSourceInterface`), `Storage\EmailStorage` (aliased to `Storage\EmailStorageInterface`),
  `Sync\EmailSync`, `Feed\FeedBuilder`, logger channel `email_to_rss`.
- **Cron:** `email_to_rss_cron()` (`.module`) calls `EmailSync::run()`.
- **Storage:** DB table `email_to_rss_item` (`email_to_rss.install` `hook_schema`); DTO
  `EmailMessage`.
- **How mail is ingested and the feed built** → [api/ingestion-and-feed.md](api/ingestion-and-feed.md)

## Model

IMAP connection (host/port/encryption/username/folder) is in `email_to_rss.settings`; the mailbox
**password is read from the `EMAIL_TO_RSS_IMAP_PASSWORD` environment variable**, never stored in
config. `EmailSync` pulls each enabled feed's folder into `email_to_rss_item` (dedup by Message-ID,
pruned to `feed_limit`); `FeedController` + `FeedBuilder` render the mirror as RSS. Each feed's URL
carries a `random_bytes()`-generated `token`, verified with `hash_equals`, that gates the feed.
