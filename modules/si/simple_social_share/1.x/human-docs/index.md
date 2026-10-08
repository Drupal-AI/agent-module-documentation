# Simple Social Share — manual setup guide

**Simple Social Share** (`simple_social_share`) provides a configurable **block**
of social-media sharing buttons that let visitors share the current page. Place the
block, choose which networks to show, and your pages gain a familiar row of share
links. Clicking one opens that platform's sharing URL for the current page, and an
optional **Copy Link** button copies the page URL straight to the clipboard.

The block supports a wide set of platforms — Facebook, Twitter/X, LinkedIn,
WhatsApp, Telegram, Pinterest, Reddit, Tumblr, and Email — and each one can be
turned on or off independently, so you show only the networks you care about. The
whole thing is configured on the block itself; there's no separate site-wide
settings page.

The module's own privacy note is worth repeating: it does not collect, store, or
share any user data. Sharing happens entirely through the external platforms, with
no interactions recorded on your site. It depends on core's **Block** and
**Config** modules and works on Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Place the **Simple Social Share** block in the region where you want the share
   buttons to appear.
3. In the block's configuration, enable the platforms you want to offer (and turn
   off the ones you don't), and decide whether to include the **Copy Link** button.
4. Save the block.

Once placed, visitors see the sharing buttons on the pages where the block appears.
Clicking a network opens its share dialog for the current page; the Copy Link
button copies the current URL to the clipboard.
