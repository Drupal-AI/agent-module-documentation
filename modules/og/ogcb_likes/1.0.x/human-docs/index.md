# OGCB Likes — manual setup guide

**OGCB Likes** (`ogcb_likes`) provides a configurable block that summarises which
users have "liked" a piece of content. It shows a compact list of names — for
example *"Anna, Max and 3 more"* — and opens a dialog overlay with the complete
list when clicked. It's built on the [Flag](https://www.drupal.org/project/flag)
module and is part of the **Open Government Community Builder (OGCB)** toolset, a
Drupal template for building community platforms — though the block works on its
own wherever you have Flag installed.

Likes are recorded using a Flag flag called `like_node`, which the module creates
automatically when you install it. You decide which content types (bundles) it
applies to in Flag's own settings. The block only renders for users who hold the
Flag `like_node` permission — for anyone without it, no HTML or JavaScript is
loaded at all — so it fails closed for unauthorised visitors.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Flag.

Each block instance is configured where you place it (see below); there is no
separate module‑wide settings page.

## How to use it

1. Enable `ogcb_likes` (see [Installation](installation/index.md)). Installing it
   automatically creates the `like_node` flag.
2. Go to **Structure → Flags** (`/admin/structure/flags`) and configure the
   `like_node` flag — in particular, choose the **bundles (content types)** it
   should apply to.
3. Grant the Flag **`like_node`** permission to the roles that should be able to
   like content and see the likers block, at **People → Permissions**.
4. Place an **OGCB Likes** block at **Structure → Block layout**
   (`/admin/structure/block`), positioning it near the content it summarises. On the
   block's own configuration form you can set:
   - the **summary limit** — how many usernames appear before the "and X more"
     collapse; and
   - the **sort order** — by date liked or by username, ascending or descending.
5. Save. The block now shows who liked each item, with a dialog for the full list.
