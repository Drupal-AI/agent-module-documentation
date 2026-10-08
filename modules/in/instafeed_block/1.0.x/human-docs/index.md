# Instafeed Block — manual setup guide

**Instafeed Block** (`instafeed_block`) provides customizable blocks that display
your Instagram posts, which you can place in any region of your site. It
integrates the **instafeed.js** JavaScript library, so the posts are fetched and
rendered **client-side** — in the visitor's browser — and it includes a feature to
automatically refresh the Instagram access token before it expires, so the feed
keeps working without manual intervention.

Each block is configurable: you can change the markup used for the posts, limit
how many results appear, choose which media types to show, and optionally disable
the module's CSS so you can style the feed yourself. It supports Drupal 9, 10, and
11.

Two things shape whether this module is the right fit, and both are about how the
feed is fetched rather than about the code. First, because rendering is
**client-side**, every visitor's browser contacts Instagram directly — a consent
and data-protection consideration — and the block simply renders empty whenever
the API is unavailable or the token has expired. The common failure here is not an
error but silence: the block goes blank, nobody is notified, and it is noticed
weeks later. Second, Instagram's API is demanding to set up and keep running: it
requires a **Facebook app**, a **business or creator account**, app review for the
permissions involved, and an **access token that expires and must be refreshed**
(the module's token-refresh-on-cron feature helps with the last part).

If you would rather store posts locally so the feed is cached, themeable, and
keeps working when the API doesn't, a server-side fetching approach (such as the
`social_feed_fetcher` module) is the alternative to weigh.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the required
   instafeed.js library, and enable it.
2. [Configuration](configuration/index.md) — add your Instagram access token,
   create a block, and tune its display options.

## Where it lives in the admin menu

The module has a settings page (its configure route is
`instafeed_block.settings_form`) where you enter your Instagram access token and
enable token refresh. The blocks themselves are created and placed through
**Structure → Block layout**. See [Configuration](configuration/index.md).
