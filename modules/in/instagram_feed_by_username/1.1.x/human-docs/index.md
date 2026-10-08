# Instagram Feed By Username — manual setup guide

**Instagram Feed By Username** (`instagram_feed_by_username`) adds a field type
that stores an Instagram **username** and renders that user's recent posts on the
page — their images, links, and like/comment counts. You add the field to a
content type (or block), and when creating content an editor simply types in a
public Instagram profile's username; the field displays that account's latest
feed.

What makes it unusually simple to set up is that **it needs no API key**. Instead
of a Facebook app and access token, it fetches the feed at display time from a
third-party service, **WOXO Tech** (`https://api.woxo.tech/instagram?source={username}`),
over HTTPS. The Instagram account you point at must have its profile set to
**public** for its posts to be visible. It supports Drupal 8.8, 9, and 10.

Two caveats are worth understanding before you rely on it. First, because the
posts come from a **third-party API you don't control**, the feed's availability
and reliability depend on that service — if it changes, rate-limits, or goes away,
the feed stops. Also weigh whether fetching a public profile's posts through an
intermediary suits your use and Instagram's terms of use. Second, the field
fetches on render, so each page view depends on that remote call; keep that in
mind for pages that must load fast or work offline.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central settings page** for this module. You add the field to a
content type and enter a username per piece of content, as described below.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Content types → *(your type)* → Manage fields** (or the
   Manage fields for a block type) and add a field of the **Instagram Feed By
   Username** field type.
3. When creating or editing a piece of content, type any **public** Instagram
   profile's username into the field.
4. View the content — the field renders that account's recent posts as a linked
   image grid with like/comment counts, themed by the module's template.
