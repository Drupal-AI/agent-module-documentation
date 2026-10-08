# Block Exclude Pages — manual setup guide

**Block Exclude Pages** (`block_exclude_pages`) adds one small but genuinely useful ability to
Drupal's block visibility: it lets you **carve exceptions out of a wildcard path rule**. Core
already lets you show or hide a block on a list of paths with `*` wildcards (the "Pages"
visibility condition), but it gives you no way to say "show on *all* of `/user/*` **except**
`/user/jc`". This module fills that gap by letting you prefix a path with an exclamation mark
(`!`) to mark it as an *exclude*.

It works by quietly enhancing the existing core **"Pages"** condition — so **every block
gains the new syntax automatically**, with no per‑block switch to flip and no new field to
find. You still type one path per line in the same **Pages** textarea under a block's
visibility settings; any line starting with `!` becomes an exclusion (and it can use `*`
wildcards too, e.g. `!/user/jc/*`). Order matters: lines are read top to bottom and the last
one that matches wins, so a later include line can re‑add a page a wildcard excluded, and vice
versa.

The module has **no settings page, no permissions, no config of its own, and no Drush
commands** — it purely extends the standard Block layout UI. It has no dependencies beyond
Drupal core (10 or 11) and works the moment you enable it.

This guide is written for a **human** editing block visibility in the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.

## Where it lives in the admin menu

Block Exclude Pages adds **no page of its own**. You use its `!` syntax in the normal place:
**Structure → Block layout** (`/admin/structure/block`) → *Configure* a block → the **Pages**
field under **Visibility**.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Block layout** (`/admin/structure/block`) and click **Configure** on
   the block you want to control.
3. Open the **Pages** tab under **Visibility**. As with core, choose **Show for the listed
   pages** or **Hide for the listed pages**, and enter one path per line.
4. Prefix any path with `!` to make it an **exclusion**. Every line must begin with `/`, or
   with `!/`, or be `<front>` / `!<front>`.

   For example, with **Show for the listed pages** selected:

   ```
   /user/*
   !/user/jc
   !/user/jc/*
   ```

   shows the block on all user pages **except** `/user/jc` and everything beneath it.

5. **Order matters** — the last matching line decides. To re‑include one page carved out by a
   wildcard, put the include line *after* the exclude:

   ```
   !/order/*/*
   /order/*/complete
   ```

   shows the block only on `/order/*/complete` while hiding the other `/order/*/*` pages.

6. Click **Save block**.

A few things worth knowing: matching is case‑insensitive and runs against both the URL alias
and the internal path; `<front>` (and `!<front>`) target the site front page; and if you flip
to **Hide for the listed pages**, the whole result inverts — so under "hide", the `!` lines
*show* the block again. An empty Pages field means "no restriction", exactly like core.
