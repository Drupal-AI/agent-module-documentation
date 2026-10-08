<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Email to RSS fetches messages from an IMAP mailbox folder and publishes them as a private, token-gated RSS 2.0 feed.

---

Email to RSS is an email-to-feed bridge: you configure one IMAP account and one or more mailbox folders, and the module mirrors each folder's messages into a local database table and exposes them as an RSS 2.0 feed. Fetching happens automatically on Drupal cron (`hook_cron` calls `EmailSync::run()`) or on demand from the settings form's "Sync all now" button. Each configured feed is reachable at `/feeds/email-to-rss/{feed_id}/{token}`, where `{token}` is a high-entropy per-feed secret generated with `random_bytes()`; the token is the access gate for the feed (there is no separate role permission on the feed route). Admin configuration lives at `/admin/config/services/email-to-rss` behind the `administer site configuration` permission. Messages are deduplicated by Message-ID, pruned to a configurable per-feed limit, and HTML bodies are preserved and delivered through the feed's `content:encoded` element plus a per-item HTML detail page. The IMAP host, port, encryption, username and folder are stored in configuration; the mailbox password is read only from the `EMAIL_TO_RSS_IMAP_PASSWORD` environment variable and never written to Drupal config. It is the reverse of core Aggregator (which consumes feeds) and needs only the `webklex/php-imap` library, Drupal 10/11, and PHP 8.2+.

---

- Read a newsletter that only arrives by email in your normal RSS/Atom feed reader.
- Turn a shared mailbox folder into a team-readable feed without giving out mailbox credentials.
- Self-host an alternative to hosted "email-to-feed" services (Kill the Newsletter) on your own Drupal site.
- Archive selected emails as a durable, dated feed of items.
- Follow a vendor's email-only release announcements as a feed.
- Aggregate several newsletters by filtering them into one IMAP folder and exposing that folder as one feed.
- Publish one feed per topic by filtering mail into separate folders and adding one feed per folder.
- Pull marketing or transactional emails into a monitoring feed reader for review.
- Give each subscriber a distinct secret feed URL and revoke access by regenerating that feed's token.
- Bridge a support or alias inbox into a feed dashboard.
- Keep an inbox-zero workflow by moving reading of email-only content out of the mail client.
- Feed email content into another system that ingests RSS (aggregators, chat bridges, IFTTT-style tools).
- Consume mailing-list traffic as a chronological feed instead of threaded mail.
- Mirror an IMAP folder's recent messages so they survive server-side mailbox cleanup.
- Preserve HTML-formatted newsletters (via `content:encoded`) so they render richly in a reader.
- Limit each feed to the most recent N messages to keep the feed lightweight (`feed_limit`).
- Run the fetch entirely on cron so feeds stay current with no manual action.
- Trigger an immediate fetch after configuration with the "Sync all now" button to verify the connection.
- Clear a feed's locally mirrored messages with the "Delete feed items" action, then re-sync from the mailbox.
- Remove a whole feed (config plus mirrored messages) with the "Delete feed" confirm form.
- Rotate a leaked or shared feed URL by choosing "Regenerate token" for that feed.
- Enable or disable an individual feed without deleting it.
- Read email bodies at a per-message detail page linked from each feed item.
- Keep the IMAP password out of exported configuration by supplying it through an environment variable.
