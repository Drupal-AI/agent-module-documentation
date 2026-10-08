# Simple Date Block — manual setup guide

**Simple Date Block** (`simple_date_block`) provides a block that displays a date
and time, with support for custom formats and timezones. Use it to show the current
date/time — or a fixed date — somewhere in your layout, such as a header clock or an
event date banner.

The block is configured where you place it: once the module is enabled, you add the
block through Drupal's Block Layout, and its per‑block settings let you choose the
date/time format and the timezone it displays in. It depends only on core's
**Block** and **System** modules and supports Drupal 9.5, 10, and 11.

> **Heads‑up on the package name:** although the module's machine name is
> `simple_date_block`, its Composer package is **`drupal/sdb`** and the drupal.org
> project short name is **`sdb`** — so you require `drupal/sdb` but enable
> `simple_date_block`. The installation page spells this out.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer (note
   the `drupal/sdb` package name) and enable it.

## How to use it

The block has no global settings page; you configure each instance when you place
it:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. In the region where you want the date to appear, click **Place block**.
3. Find and place the **Simple Date Block**.
4. In the block's configuration, set the **date/time format** and the **timezone**
   you want it to display, along with the usual block options (title, visibility).
5. **Save block**.

The chosen region now shows the date/time formatted as you configured it. Place the
block again in another region if you want it in more than one place.
