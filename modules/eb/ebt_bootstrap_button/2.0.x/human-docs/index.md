# EBT Bootstrap Button — manual setup guide

**EBT Bootstrap Button** (`ebt_bootstrap_button`) adds a block type for placing a
**button styled with Bootstrap classes**. If your theme uses Bootstrap, this lets
editors drop a properly-styled button (primary, secondary, outline, sizes, and so
on) into a page without writing any markup — a quick call-to-action link that
matches the rest of your Bootstrap UI.

It is part of the **Extra Block Types (EBT)** family, whose components are
provided as **block types** placeable in any region and in **Layout Builder** in a
few clicks. The shared design widget comes from the **EBT Core** (`ebt_core`) base
module, which is this module's only dependency. It runs on Drupal 10.1+, 11, and
12.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and its EBT Core dependency).

## Configuration

There is **no separate settings page** for this module. Like all EBT block types,
the Bootstrap Button is configured **per block instance** when you place it: you
set the button's text, link, and Bootstrap classes on the block form, along with
the shared **Design** options (CSS box margins/paddings/borders; background
colour, image or YouTube video; edge-to-edge vs. container width) that come from
the **EBT Core** widget. See the [EBT Core project
page](https://www.drupal.org/project/ebt_core) for more.

## How to use it

1. Edit a page with **Layout Builder**, or go to **Structure → Block layout**.
2. Click **Add block** and choose the **Bootstrap Button** block type.
3. Enter the button label and link, pick the Bootstrap style classes, and adjust
   the shared Design options.
4. Save. The styled button renders on the page.
