# Feeds Instagram — manual setup guide

**Feeds Instagram** (`feeds_instagram`) is a fetcher and parser for the
[Feeds](https://www.drupal.org/project/feeds) module that imports media from a
connected Instagram account via the **Facebook (Meta) Graph API**. Use it to pull
an Instagram account's posts into Drupal as content, so you can display an
Instagram feed on your site and manage it like any other imported content.

Because it uses the official Graph API, the module needs an **Instagram Business
Account connected to a Facebook page** you administer. The
[Instagram Graph API Getting Started](https://developers.facebook.com/docs/instagram-api/getting-started)
guide covers the prerequisites — in particular the steps that connect your
Instagram Business Account are required before this module can fetch anything. You
enter your Facebook **App ID** and **App Secret** in the fetcher's configuration,
and then authenticate each feed to Facebook through the module's built-in OAuth 2.0
login flow; the resulting access token is obtained and cached by the module.

A wide range of fields comes back for each imported item, including the Instagram
ID, shortcode, published date/timestamp, media type, media and thumbnail URLs,
caption, title, permalink, like and comment counts, owner/username, and children/
comments — which you map onto your content's fields.

> **Note.** The Facebook App ID/App Secret are entered in the fetcher configuration
> and the access token is obtained through the Facebook login flow and cached by the
> module; imported data comes from an external service.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Feeds.

There is **no separate module‑wide settings page** — the fetcher and parser are
configured on a feed type, and the account credentials are provided on the feed,
described in "How to use it" below.

## Where it lives in the admin menu

Feeds Instagram adds no admin page of its own. Its fetcher and parser appear when
you create or edit a feed type at **Structure → Feed types**, and you run imports
from **Content → Feeds**.

## How to use it

1. Complete the Instagram/Facebook Graph API prerequisites: connect an **Instagram
   Business Account** to a **Facebook page** you administer, and create a Facebook
   Developer App to obtain an **App ID** and **App Secret**.
2. Create a feed type at **Structure → Feed types**, choose the **Instagram**
   fetcher and parser, and enter the App ID, App Secret, and an import limit in the
   fetcher settings.
3. Add a processor (typically the node or another entity processor) and map the
   Instagram fields you want — for example media URL, caption, permalink, and the
   published date — onto your content's fields.
4. Add a feed at **Content → Feeds** for that type, use the **Authenticate Facebook
   Account** link to complete the OAuth login, select the Facebook Page whose
   Instagram Business Account you want, and run the import. Set a periodic import if
   you want it to refresh on cron.
