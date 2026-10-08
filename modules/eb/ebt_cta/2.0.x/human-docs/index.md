# Extra Block Types (EBT): Call to Action — manual setup guide

**Extra Block Types (EBT): Call to Action** (`ebt_cta`) adds a block type for a
classic **call-to-action** section: some text alongside one or two buttons, laid
out to draw the eye and drive conversions. You can show it in one or two columns,
place an accompanying image to the left or right, and optionally make that image
"fluid" so it takes 50% of the width. The whole block is mobile-responsive and
collapses to a single column at the breakpoint you choose.

The CTA button itself draws its colours and styles from the **EBT Basic Button**
module, so your buttons stay consistent with the rest of your EBT components. It
is part of the **Extra Block Types (EBT)** family, whose components are provided
as **block types** placeable in any region and in **Layout Builder** in a few
clicks, with shared design options supplied by the **EBT Core** (`ebt_core`) base
module. It runs on Drupal 10.1+, 11, and 12.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Configuration

There is **no separate settings page** for this module. Like all EBT block types,
the Call to Action is configured **per block instance** when you place it: you set
the text, one or two buttons, the column layout, and the image placement (left/
right, and optionally fluid) on the block form. The buttons take their colour and
style from **EBT Basic Button**, and the shared **Design** options (CSS box
margins/paddings/borders; background colour, image — including parallax and cover
— or YouTube video; edge-to-edge vs. container width) come from the **EBT Core**
widget. See the [EBT Core project page](https://www.drupal.org/project/ebt_core)
for more.

## How to use it

1. Edit a page with **Layout Builder**, or go to **Structure → Block layout**.
2. Click **Add block** and choose the **Call to Action** block type.
3. Enter the text and button(s), choose 1 or 2 columns and the image placement,
   and adjust the shared Design options.
4. Save. The responsive CTA renders on the page and stacks into one column on
   mobile.
