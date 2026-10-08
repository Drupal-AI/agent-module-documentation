# Email Formatter — manual setup guide

**Email Formatter** (`email_formatter`) is a field formatter for Drupal core's
**Email field** that gives you display options beyond the plain `mailto:` link
core renders by default. With it, an email address can be shown as a clickable
`mailto:` link, as plain text, truncated to a set number of characters (ending in
an ellipsis), preceded by custom text or custom HTML, or accompanied by a
Font Awesome icon that can itself be a `mailto:` link.

The usual reason to reach for this is **harvesting**: an address published as
plain markup gets scraped quickly, and staff directories are exactly the pages
that attract scrapers. The formatter's masking and custom‑markup options add
friction that defeats naive scrapers — which is most of them — and that is a real
reduction in spam. It is worth being honest that this is *friction, not a
control*: a scraper that renders the page can still read the address, and any
obfuscation has an accessibility cost (an assembled address may not be selectable,
copyable, or reliably read by assistive technology). Where an address genuinely
must be protected, a contact form is usually the better answer, because it
removes the address from the page rather than hiding it.

The module depends only on core's **Field** module. The Font Awesome icon option
additionally needs the **Font Awesome Icons** module — install and configure that
separately if you want icons.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has **no central settings page**. Its options are set per field on
the display, described in "How to use it" below.

## Where it lives in the admin menu

Email Formatter adds no admin settings page. You configure it from **Structure →
Content types → *(your type)* → Manage display**, on any Email field.

## How to use it

1. Go to **Structure → Content types → *(your content type)* → Manage display**
   (for example `/admin/structure/types/manage/yourtype/display`), on a type that
   has an Email field.
2. In the **Format** column for that Email field, choose **E‑mail formatter
   (with options)**, then save.
3. Click the settings cog/gear button to open the options: `mailto:` linking,
   truncation length, custom text/HTML, and (if you have the Font Awesome Icons
   module) an icon. The options are self‑explanatory; set them and save.
4. If you change settings and something looks off, clear caches from the
   performance configuration page, and re‑open the field's settings cog to flush
   any stale settings from an older version of the module.
