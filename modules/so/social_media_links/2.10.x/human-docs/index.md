# Social Media Links Block — manual setup guide

**Social Media Links Block** (`social_media_links`) gives you a configurable
Drupal block that renders a tidy row (or column) of icon links to your profiles
on social networks — Facebook, X/Twitter, Instagram, LinkedIn, YouTube, TikTok,
GitHub, Mastodon, WhatsApp, RSS, email, and around fifty more. You place the
block like any other, add one row per network, and for each row you type only
the handle or path (`acme`) rather than the whole address — the module knows
each platform's URL prefix and suffix, so `acme` under Twitter becomes
`https://x.com/acme` automatically.

The problem it solves is keeping your social links out of theme templates and
managing them as ordinary, exportable block configuration instead. You choose an
**icon set** to render the icons (Font Awesome, Elegant Themes, Nouveller, or
IcoMoon are bundled), set the icon size and style, pick horizontal or vertical
orientation, and control link attributes such as opening in a new tab or adding
`rel="nofollow noopener"`. Because it's a standard block, you can place different
versions per region and per theme and limit where each appears with the usual
block visibility conditions.

The module has **no site‑wide settings page** — everything is configured on the
block itself when you place it, so it does nothing until you place and fill in a
block. It has no required dependencies beyond Drupal core. One companion
submodule, **Social Media Links Field** (`social_media_links_field`), offers the
same capability as a *field type* so editors can store social profiles directly
on any entity (for example, a user's own links on their profile). For
developers, both the platform list and the icon sets are plugin‑based and
extensible.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including how to add a new
platform or icon set as a plugin — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally enable the field submodule.
2. [Configuration](configuration/index.md) — place the block and work through the
   block form, section by section.

## Where it lives in the admin menu

There is no dedicated settings route. You place and configure the block at
**Structure → Block layout** (`/admin/structure/block`) → **Place block** →
*Social media links*. All of the block's options live in that block's own
configuration form, and its settings are stored with the block.

## How to use it

Place the *Social media links* block in whichever region you want it (a footer
and a header are the common choices), add a row per network, type each handle,
choose your icon set and appearance, and save. To show social links per entity
instead of in a fixed region, enable the field submodule and add a *Social media
links* field to the content type, user, or other entity that should carry them.
