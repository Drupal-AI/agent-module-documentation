# Sticky Social Bar — manual setup guide

**Sticky Social Bar** (`sticky_social_bar`) puts a sticky bar of social-share
links along the bottom of the page — pinned in place so it stays visible while a
visitor scrolls, without disrupting the rest of the page layout. The bar can show
the page title, share buttons (with share counts) for the major social networks,
and previous/next navigation links, giving readers a persistent, unobtrusive way
to share what they are reading.

Unlike a pure block-only module, Sticky Social Bar has both an **admin settings
form** — where you switch individual social channels and options on or off — and a
**block** that renders the bar itself. It can build share links for the current
page or for arbitrary URLs, and it integrates with the **Token** module and core's
**Field** module so you can compose share URLs and text from token values.

The feature is presentational: the settings form is gated by the **Administer site
configuration** permission and there are no public, mutating endpoints. Worth
noting: this module is **not covered** by Drupal's security advisory policy, and
the project is seeking a co-maintainer — factors to weigh before deploying it on a
site that needs formal security coverage.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its dependencies, and place the block.
2. [Configuration](configuration/index.md) — the settings form where you choose
   which social channels appear.

## Where it lives in the admin menu

The settings form sits at **Configuration → Media → Sticky Social Bar**
(`/admin/config/media/sticky-social-bar`), behind the **Administer site
configuration** permission.

## How to use it

Enable the module, open the settings form to turn on the social networks you want,
then place the **Sticky Social Bar** block in a region (typically the footer) via
**Structure → Block layout**. Use the block's visibility settings to control which
pages show the bar. Styling comes from the module's CSS library, and the markup
can be overridden through the module's Twig template if you want to theme it.
