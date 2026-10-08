# Site Status Message — manual setup guide

**Site Status Message** (`site_status_message`) displays a simple, configurable banner
message at the **top of every page** on your site — the kind of notice you reach for
when you need everyone to see something: a scheduled-downtime warning, a special offer,
or an important announcement. It was inspired by the banner Drupal.org itself showed
before its Drupal 6-to-7 upgrade in 2013.

You write the message once, choose where it appears, and turn it on. An optional **"Read
more" link** can be appended after the text, pointing at an internal node for the full
details, with link text you choose. You decide the display scope — **public-facing pages
only, admin pages only, or both** — so, for example, you can warn editors in the admin
area without showing the same banner to visitors. When the **Token** module is present
the message text supports tokens, so you can drop in dynamic values. A small CSS library
styles the banner, and the markup lives in a template so themers can adjust it.

The module has no dependencies and works from a single settings form once enabled. It
adds an `administer site status message` permission that gates who can edit the banner,
and each rendered banner is additionally shown only to viewers with the core **access
content** permission. The message text is passed through Drupal's XSS filter before
output, and since only administrators can set it, the banner is safe against arbitrary
markup injection.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.
2. [Configuration](configuration/index.md) — the settings form: message text, the read-
   more link, display scope, and turning the banner on and off.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Site status message**
(`/admin/config/system/site-status-message`, the `site_status_message.admin_settings`
route), behind the `administer site status message` permission.
