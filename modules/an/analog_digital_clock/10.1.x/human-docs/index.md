# Analog Digital Clock — manual setup guide

**Analog Digital Clock** (`analog_digital_clock`) provides a single **block** that
displays the current time, and lets you choose how it looks from four built-in
skins:

1. A **simple digital** clock with the date.
2. A **24-hour digital** clock with the date.
3. An **analog** clock face.
4. An **animated digital** clock.

The clock runs in the visitor's browser using their system/browser time — there
is no server-side time configuration, and the block is kept uncached so it always
shows the live time. Place it in a header, sidebar, or any region you like, and
use Drupal's block visibility conditions to limit it to certain pages.

One skin has an extra requirement: the **analog clock face** needs the
third-party `snap.svg` JavaScript library. The three digital skins need no extra
library. See [Installation](installation/index.md) for how to add snap.svg if you
want the analog face.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and (optionally) add the snap.svg library for the analog skin.

## How to use it

**1. Pick a skin.** Go to the settings form at `/admin/config/analog_digital_clock`
(route `analog_digital_clock.settings`, gated by the **Administer site
configuration** permission) and choose which of the four skins the clock should
use.

**2. Place the block.** Go to **Structure → Block layout**
(`/admin/structure/block`), click **Place block** in the region you want, and add
the **Analog Digital Clock** block. You can place it in more than one region, and
use the block's visibility conditions to show it only on selected pages.

The module also declares an `administer analog_digital_clock` permission, but note
that the settings route is actually controlled by core's **Administer site
configuration** permission.
