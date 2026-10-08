# Activity Tracker — manual setup guide

**Activity Tracker** (`tracker`) is the contributed continuation of Drupal core's
former *Tracker* module. It gives your site a **Recent content** page listing the
newest and recently updated content, and lets visitors follow the recent content
of any individual user. If you remember the "recent posts" experience that Drupal
core used to ship, this brings it back as a maintained contrib module.

Once enabled, it adds three pages: **/activity** shows all recent published
content across the site; **/activity/{user}** is a logged‑in user's own "my recent
content"; and an **Activity** tab on each user profile
(**/user/{user}/activity**) lists the content that user posted or commented on.
All of them respect node access grants (private content stays hidden), show only
published content, include comment activity in each item's "last updated" time, and
are cached correctly.

Under the hood it keeps a lightweight, denormalized index of node and comment
activity that updates automatically as content changes, so the activity pages stay
fast even on large sites. It also integrates with **Views** — exposing its index
tables plus a handy "user posted or commented" argument/filter — and can read from
a database replica to take load off your primary database. Drupal 7 → 9+
migrations are included for sites upgrading from D7's core tracker.

The pages are gated by core's **Access content** permission; the module adds no
permissions and no admin settings form of its own. It depends on core's **Node**
and **Comment** modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — the one indexing setting
   (`cron_index_limit`) and how the initial index is built.

## Where it lives in the admin menu

Activity Tracker has no admin settings page. Its pages are on the front end:

- **Recent content:** `/activity`
- **My recent content:** `/activity/{user}` (the logged‑in user only)
- **User Activity tab:** `/user/{user}/activity` (on each user profile)

## How to use it

1. Enable the module (see [Installation](installation/index.md)). The `/activity`
   page becomes available immediately for anyone with **Access content**.
2. On an existing site with lots of content, let **cron** run so the module can
   back‑fill its index of older nodes (see [Configuration](configuration/index.md)).
   New and updated content is indexed instantly, without waiting for cron.
3. Visit **/activity** to see recent content, or a user's profile **Activity** tab
   to see what they've been posting and commenting on. You can also add a
   menu link to `/activity` if you'd like it in your site navigation.
