# Sticky Sharrre Bar — manual setup guide

**Sticky Sharrre Bar** (`sticky_sharrre_bar`) adds a floating social-share bar to
your site — a block of share buttons (with share counts) that sticks to the edge
of the page and follows the reader as they scroll. It is built on the
[Sharrre](http://sharrre.com) jQuery library and the jQuery Waypoints library, and
it can show buttons for the major social networks the Sharrre library supports
(Facebook, Twitter, LinkedIn, Pinterest, and others).

The module surfaces as a **block** — it depends on core's **Block** module — so
you place and configure it through Drupal's block layout rather than a dedicated
settings page. By default it installs into the *header* region; if your theme has
no header region you pick another one when you place the block.

Two important caveats before you rely on this module. First, it needs two
front-end JavaScript libraries downloaded into your site's `libraries` directory
(see [Installation](installation/index.md)) — specifically jQuery Sharrre **1.3.5
only** (2.0.0 and higher will not work) and jQuery Waypoints 4.0.0 or higher.
Second, the module is currently marked **Unsupported** on drupal.org with no
further development planned, so weigh that before adopting it on a new site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module, download the
   required JavaScript libraries, enable it, and place the block.

## How to use it

After enabling the module and installing the libraries, go to **Structure →
Block layout**, find the **Sticky Sharrre Bar** block, and place it in a region
(the header by default, or another region your theme provides). In the block's
configuration you choose which social providers to show and can turn off the
module's bundled CSS if you would rather style the bar in your own theme. Once
placed, the bar sticks to the page and stays visible as visitors scroll, inviting
them to share the current page.
