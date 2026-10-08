# Stand with Ukraine — manual setup guide

**Stand with Ukraine** (`stand_with_ukraine`) is a deliberately tiny module that
gives you one thing: a block which renders a `#StandWithUkraine` support banner as
a fixed overlay on your site, linking visitors to the Ukraine support site at
`https://war.ukraine.ua/`. Its own bundled CSS and JavaScript position and style
the overlay, so you don't have to touch any markup.

There is essentially nothing to configure. The block has no settings form of
substance — you simply place it in a theme region and it displays the banner to
anyone who can see your content. If you want to limit where it appears, you use
Drupal's standard block visibility conditions (specific pages, content types, or
roles) just as you would for any block. It fetches no external data and adds no
routes, permissions, or services of its own; the banner is static markup.

This guide is written for a **human** placing the block through the admin UI. If
you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and place the banner block.

## Where it lives in the admin menu

The module has no configuration page. You manage the banner entirely through
**Structure → Block layout** (`/admin/structure/block`), where you place the
**Stand With Ukraine block** into whichever region you like.

## How to use it

1. Enable the module.
2. Go to **Block layout**, find a region (for example your header or a sidebar),
   and click **Place block**.
3. Choose the **Stand With Ukraine block**.
4. Optionally add visibility conditions — restrict it to the front page, to
   certain content types, or to certain roles.
5. Save. The banner appears immediately for any user with permission to view
   content.

To take the banner down at the end of a campaign, simply remove the block from the
region (or disable the module).
