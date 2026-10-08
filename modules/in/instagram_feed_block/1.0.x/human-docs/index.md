# Instagram Feed Block — manual setup guide

**Instagram Feed Block** (`instagram_feed_block`) displays a feed of Instagram
posts in a Drupal block, fetched through the official **Instagram Graph API**. It
lets site builders show a connected business or creator account's latest content
anywhere on the site — in a sidebar, a region, or via Layout Builder — and control
how much is shown and how it is filtered, per block.

Unlike embed-based approaches, this module talks to the API server-side and
renders plain, responsive markup: no iframes, no third-party embed scripts loading
in the visitor's browser. That makes it faster and gives you full control over the
display, and it integrates cleanly with Drupal's block and caching systems (it has
built-in caching, and it is Gutenberg-compatible). Each block can show images,
videos, and carousel posts, set the number of posts, and filter by a custom date
range, a "last X days" window, or a hashtag.

The trade-off is setup and platform dependency. You need an **Instagram Business
or Creator account**, a **Facebook Developer app**, **Instagram Graph API
access**, and a **long-lived access token** — and API access is subject to Meta's
platform limitations, so the feed can only show what the Graph API exposes. The
access token is a secret and is stored through the **Key** module, which this
module depends on. It supports Drupal 10.1+, 11, and 12.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and the Key module
   it depends on) with Composer, and enable it.
2. [Configuration](configuration/index.md) — store your access token via Key, enter
   your account ID, and place a feed block.

## Where it lives in the admin menu

The module provides a settings form where you enter your Instagram Business
Account ID and reference the access token, and it defines an **administer instagram
feed block** permission to gate that admin access. Feed blocks are placed through
**Structure → Block layout** (or Layout Builder). See
[Configuration](configuration/index.md).
