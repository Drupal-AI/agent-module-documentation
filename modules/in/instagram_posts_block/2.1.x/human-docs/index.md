# Instagram Posts Block — manual setup guide

**Instagram Posts Block** (`instagram_posts_block`) gives you a block that shows
an Instagram feed — the recent posts from an Instagram account rendered right on
your site. You place it in any region through Drupal's normal Block Layout, and
the block's own settings hold the Instagram credentials and control how the feed
is displayed.

Under the hood it retrieves posts through Instagram's **Basic Display API**, so
you need an access token from Instagram before the feed will appear. The token is
supplied in the block's settings. Because the feed is fetched from Instagram/Meta
and the block embeds third‑party content, treat the token as a secret and keep
the usual privacy/consent considerations in mind when loading Meta assets on your
pages.

There is no site‑wide settings page — everything is configured on the block
itself when you place it, so this guide covers installation and then how to place
and set up the block.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated configuration page** for this module. All of its settings
live on the block itself — see "How to use it" below.

## Where it lives in the admin menu

Instagram Posts Block adds no configuration page of its own. You work with it
entirely from **Structure → Block Layout** (`/admin/structure/block`), where you
place the "Instagram posts block" into a region.

## How to use it

1. First, obtain an **Instagram Basic Display API access token** for the account
   whose feed you want to show. Instagram's developer documentation walks through
   registering an app and generating the token.
2. In Drupal, go to **Structure → Block Layout**.
3. Choose the region where the feed should appear and click **Place block**.
4. In the dialog, search for **Instagram posts block** and select it.
5. In the block's settings, enter the Instagram access token and the display
   options the form offers (how the feed is fetched and how the posts are shown),
   then save.

The recent posts from the account should now render in the region you chose.
Because the token grants access to the feed, keep it private and rotate it if it
is ever exposed; the module talks to Instagram/Meta over HTTPS on every render.
