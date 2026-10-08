# Facebook Block — manual setup guide

**Facebook Block** (`facebook_block`) provides a Drupal block that embeds Facebook
content — such as a page feed or a like box — using Facebook's official social
plugins. Once enabled, you place the block in a region like any other block and it
renders the Facebook widget on the pages where that block appears.

Because the block relies on Facebook's own social plugins, it loads Facebook's
third‑party JavaScript into your pages. That is an important privacy
consideration: Facebook social plugins can track visitors even if they never
interact with the widget, and the embed adds Facebook as a third‑party origin on
every page it appears on. On sites subject to cookie/consent rules (for example
GDPR), you should gate this block behind your cookie‑consent solution and disclose
the tracking in your privacy policy. Enable it deliberately, and keep it off pages
where it is not needed.

This module has **no central settings form of its own** — configuration happens
on the block instance when you place it, and the actual Facebook content is
controlled by the Facebook page/plugin you point it at.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no module‑wide configuration page**. You configure the embed on the
block itself, described in "How to use it" below.

## Where it lives in the admin menu

Facebook Block adds no admin settings page. You use it from **Structure → Block
layout** (`/admin/structure/block`), where you place the Facebook block into a
region and configure that block instance.

## How to use it

1. Go to **Structure → Block layout** and choose **Place block** in the region
   where you want the Facebook content to appear.
2. Find and place the **Facebook Block** in that region.
3. Configure the block instance (and point it at the Facebook page/plugin you want
   to show), set its visibility conditions, and save.
4. If your site uses cookie‑consent, add the block to your consent configuration
   so Facebook's script only loads once the visitor has agreed.

Review the placement after Drupal or theme upgrades, and confirm the embed renders
and fits your theme before relying on it in production.
