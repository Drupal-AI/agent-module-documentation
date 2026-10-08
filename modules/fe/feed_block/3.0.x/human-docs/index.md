# Feed Block — manual setup guide

**Feed Block** (`feed_block`) displays items from an external RSS or Atom feed inside
a Drupal block. It's the quick way to surface a partner site's headlines, your
blog's latest posts, a news source's announcements, or even a YouTube channel's
recent uploads on your pages — without standing up a full aggregator. You paste a
feed URL, choose how many items to show and how they look, and place the block
wherever you like.

It works through Drupal's custom-block system. Enabling the module adds a **Feed
Block** custom block type carrying three fields: an **RSS Feed** field (the URL plus
all the display options), an optional **Intro Text** shown above the items, and an
optional **Read More** call-to-action link below them. At render time, the RSS Feed
field fetches the remote feed, parses it, and lists each item's date, linked title,
and description. Because each feed is just a block, you can create several distinct
feed blocks and place them independently around the site using the Block UI, Layout
Builder, Panels, or Context.

Feed output is cached (by default for one day) rather than fetched on every request,
so it stays fast — and the refresh interval is adjustable. The markup is deliberately
minimal and fully overridable: there's a per-item template you can copy into your
theme, a `block__feed_block` template suggestion for the whole block, and only a
small CSS library you're free to remove.

> **A note on trust.** Feed content comes from an external third party you don't
> control. Only point feed blocks at feeds you trust.

There is **no global settings page** — everything is configured per block. The module
depends on core's Block, Block Content, Node, and Link modules, and runs on Drupal
10.1, 11, or 12.

This guide is written for a **human** setting the module up through the UI. If you
want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead — they cover the field/formatter internals
and theming in depth.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — create a feed block, set its options
   field by field, adjust caching, and override the markup.

## Where it lives in the admin menu

There is no dedicated settings page. You create and manage feeds where you manage
custom blocks: **Structure → Block layout → Add custom block → Feed Block**
(`/block/add/feed_block`), then place the resulting block in a region. Creating and
editing these blocks uses core's block-content permissions — Feed Block declares none
of its own.

## How to use it

Add a Feed Block custom block, paste in the feed URL, choose how many items to show
and whether to display the date and description, optionally add intro text and a
"Read More" link, save, and place the block. The full field-by-field walkthrough is
on the [Configuration](configuration/index.md) page.
