# EBT Countdown — manual setup guide

**EBT Countdown** (`ebt_countdown`) adds a block type that displays an **animated
countdown** timer ticking down to a date and time you choose — perfect for a
product launch, a sale deadline, an event, or a "coming soon" page. Editors set
the target date and pick the countdown's styles through the UI, no code required.

It is part of the **Extra Block Types (EBT)** family, whose components are
provided as **block types** placeable in any region and in **Layout Builder** in a
few clicks. The shared design widget comes from the **EBT Core** (`ebt_core`) base
module. It also requires the **Paragraphs** module and core **Datetime** (for the
target date/time), and runs on Drupal 10.1+, 11, and 12.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and its EBT Core, Paragraphs, and Datetime dependencies).

## Configuration

There is **no separate settings page** for this module. Like all EBT block types,
the Countdown is configured **per block instance** when you place it: you set the
target date/time and pick the countdown styles on the block form, alongside the
shared **Design** options (CSS box margins/paddings/borders; background colour,
image — including parallax and cover — or YouTube video; edge-to-edge vs.
container width) from the **EBT Core** widget. See the [EBT Core project
page](https://www.drupal.org/project/ebt_core) for more.

## How to use it

1. Edit a page with **Layout Builder**, or go to **Structure → Block layout**.
2. Click **Add block** and choose the **Countdown** block type.
3. Set the target date and time, choose the countdown style, and adjust the shared
   Design options.
4. Save. The animated countdown renders on the page and ticks down live.
