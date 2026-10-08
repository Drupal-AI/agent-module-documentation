# Activity Stream — manual setup guide

**Activity Stream** (`actstream`) builds a "lifestream": it pulls a user's
activity from external services — RSS/Atom feeds, social networks, or any service
you wire up — into Drupal and shows it as a stream of *Actor VERB Object*
statements (for example "Jane posted a photo"). Each fetched item becomes a
native Drupal content entity (`actstream_item`), so it behaves like normal
Drupal content: it can be themed, access-checked, and listed.

When you install it, the module creates the `actstream_item` entity type and an
accounts table. Individual service integrations ship as **ten optional
submodules** (Twitter, Instagram search, Last.fm, Flickr, a Facebook page, a
plain RSS feed, and more). Fetching happens automatically on cron, or on demand
via a Drush command (`actstream:fetch`), which reads each saved account's stored
credentials and pulls in any new items. It runs on Drupal 10.3, 11, and 12, and
requires PHP 8.1.

For developers, Activity Stream is also a small framework: any module can add a
new service by implementing a handful of hooks — see the sibling `agent/` docs
(`agent/extend/services.md`) for the details.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and pick the service submodules you need.

## Where it lives in the admin menu

Activity Stream has no single settings form; instead it adds pages and a block:

- **Site-wide stream** — `/actstream` shows the combined stream.
- **Per-user stream** — `/user/{uid}/actstream` shows one user's activity.
- **A single item** — each item has its own canonical page.
- **Activity Stream block** — place it in a region under **Structure → Block
  layout** to show the stream on your pages.

Two permissions, **Administer Activity Stream** and **Administer Activity Stream
types**, control who can curate and manage items — grant them to editors who
should manage the stream. The listing pages only show **published** items and run
entity access checks, so they act as public feeds without leaking one user's data
into another's stream.

## How to use it

1. Enable the base module plus the **service submodule(s)** for the sources you
   want (for example `actstream_feed` for a plain RSS/Atom feed, or
   `actstream_twitter`).
2. Connect each user's accounts on the per-user accounts form at
   **`/user/{uid}/edit/actstream`**, where you enter that user's service details
   (such as a feed URL or the credentials the service needs).
3. Let **cron** fetch new items automatically, or trigger a fetch immediately
   with `drush actstream:fetch`.
4. Show the results by visiting `/actstream` (or a user's `/user/{uid}/actstream`)
   and/or by placing the **Activity Stream block** in a region.

You can theme how statements render per service using the module's template and
theme hooks (see the agent docs).
