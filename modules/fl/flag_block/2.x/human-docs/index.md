# Flag Block — manual setup guide

**Flag Block** (`flag_block`) is a very simple companion to the
[Flag](https://www.drupal.org/project/flag) module: it makes a flag link
available as a **block**, so you can place a flag action (bookmark, favourite, and
so on) anywhere a block can go, rather than only where Flag renders it by default.

Flag normally shows its flag/unflag links on the flagged content itself. Flag
Block lets you take one of your flags and expose its link as a block you can drop
into any region — a sidebar, a header, a custom layout. The flag action itself
still runs through Flag's own access model, so the block does **not** bypass
anything: a user who isn't allowed to use a flag won't get a working link from the
block either.

One thing to check when you place the block is that its context resolves the right
entity to flag — the block needs to know *which* item the flag applies to on the
page where it appears.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (with the Block and Flag modules).

There is **no separate settings page** — you configure Flag Block entirely when
you place the block, so there is no configuration chapter in this guide.

## Where it lives in the admin menu

You use Flag Block from the **Block layout** page
(**Structure → Block layout**, `/admin/structure/block`). The flags themselves
are created and managed in the Flag module at **Structure → Flags**
(`/admin/structure/flags`).

## How to use it

1. Make sure you have at least one flag defined at **Structure → Flags**.
2. Go to **Structure → Block layout** and click **Place block** in the region you
   want.
3. Choose the Flag Block. In its settings you'll see a **Flag** field — select the
   flag you want the block to expose.
4. Click **Save block**. The flag link now appears in that region, respecting the
   flag's normal access rules.
