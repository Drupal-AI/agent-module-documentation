# jQuery Countdown Timer — manual setup guide

**jQuery Countdown Timer** (`jquery_countdown_timer`) gives you a single,
configurable block that shows a live countdown — days, hours, minutes, and seconds
— ticking down to a target date. It's rendered with jQuery and CSS only (no
images), so it's a lightweight way to add a "sale ends in…", "coming soon", or
launch/event countdown to any region of your site.

Everything is done through Drupal's Block layout: you place the **Countdown
Timer** block wherever you want it (a sidebar, header, hero region, landing page),
set the target date and font size in the block's settings, and you're done. Change
the deadline later just by editing the block — no code, no theming. You can even
place the block in more than one spot with standard block visibility rules.

The block has just two settings — a **Timer date** and a **Timer font size** — and
the module adds no global configuration page, no permissions, and no Drush
commands. It depends only on core's **Block** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

The module adds no settings page of its own. You place and configure the block at
**Structure → Block layout** (`/admin/structure/block`).

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Block layout** (`/admin/structure/block`).
3. Choose a region and click **Place block**, then select **Countdown Timer**.
4. In the block configuration form set:
   - **Timer date** — the target date and time the countdown runs down to (you can
     pick it to the second; it defaults to "tomorrow").
   - **Timer font size** — the size of the countdown text, in pixels (default
     `28`). Adjust it to suit where you're placing the block.
5. Optionally set the usual block **visibility** conditions (which pages, roles,
   content types, etc.), then **Save block**.

The countdown appears in that region and updates live in the visitor's browser. To
change the deadline later, just edit the block and pick a new date.

> **Heads up:** the block shares a single JavaScript settings payload, so if you
> place more than one Countdown Timer block on the *same page*, they'll all use the
> last block's date. Use one timer per page to be safe.
