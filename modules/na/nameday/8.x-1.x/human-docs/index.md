# Name day — manual setup guide

**Name day** (`nameday`) provides a block that shows the current day's **name
day** — the tradition, common across many European countries, of associating
given names with each calendar day. Place the block and it displays whose name
day it is today. Which names appear depends on the site's current language and,
naturally, on today's date.

The module ships name‑day data for several locales: **Hungarian**, **Russian**,
**Polish**, and **Czech**. It is a simple content‑display feature — it does not
touch content or access control, so it is well suited to regional or cultural
sites that like to surface the daily name day somewhere in a sidebar or header.

There is nothing to configure beyond placing the block. Note that the project is
currently **seeking a new maintainer**, so weigh that if you are choosing it for
a long‑lived site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — you simply place its block,
described in "How to use it" below.

## How to use it

1. After enabling the module, go to **Structure → Block layout**
   (`/admin/structure/block`).
2. In the region where you want the name day to appear, click **Place block** and
   choose the **Name day** block.
3. Configure the standard block visibility options if needed (pages, roles, and
   so on), then save.

The block will now show the current name day, chosen according to the site's
active language and today's date.
