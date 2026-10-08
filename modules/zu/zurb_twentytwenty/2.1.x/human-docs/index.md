# TwentyTwenty — manual setup guide

**TwentyTwenty** (`zurb_twentytwenty`) wraps ZURB's jQuery TwentyTwenty plugin as
a Drupal image‑field formatter. Point a two‑value image field at it and the field
renders as a draggable **before/after comparison slider** — the classic "drag the
handle to reveal the second image" effect, perfect for showing retouched photos,
renovation progress, design refreshes, or seasonal changes.

It's deliberately tiny: one field formatter, one template, one library
definition, and no settings page. You choose the **TwentyTwenty** format on an
entity's **Manage display** tab, and configure the plugin's options (image style,
starting handle position, orientation, before/after labels, and a few interaction
toggles) right there in the formatter settings.

One setup detail matters: the underlying JavaScript/CSS library is **not** shipped
with the module and is **not** installed by Composer. You download it yourself and
unpack it into your site's `libraries/` directory (see the installation guide).
The module's install check will report an error until the library is present, and
without it the two images simply stack instead of forming a slider.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and add the required TwentyTwenty library.

## Where it lives in the admin menu

There is no dedicated settings page. You configure it from **Structure → Content
types → *(your type)* → Manage display** (`admin/structure/…/display`): set an
Image field's format to **TwentyTwenty**, then click the cog to open its settings.

## How to use it

1. Make sure the Image field is set up to hold **exactly two** images (cardinality
   2). The formatter compares the first two values; it only *warns* about the
   cardinality in its settings summary, it doesn't enforce it.
2. On **Manage display**, change that field's **Format** to **TwentyTwenty** and
   open the cog.
3. Adjust the settings:
   - **Image style** — applied to both images so they render at the same size
     (recommended — mismatched sizes look off).
   - **Default offset** (`0`–`1`, default `0.5`) — where the divider starts;
     `0.5` is centered, a higher value reveals more of the "after" image.
   - **Orientation** — `horizontal` or `vertical`.
   - **Before label** / **After label** — the overlay captions (e.g. "2019" /
     "2024").
   - **No overlay** — hide the hover overlay and labels for a cleaner look.
   - **Move slider on hover**, **Move with handle only**, and **Click to move** —
     interaction options; *click to move* is handy on touch devices.

> **Two things to know before you debug something odd.** First, the plugin's
> settings are written to a single *global* JavaScript object, so if you place two
> TwentyTwenty fields on the same page, they share whichever field's settings were
> attached last. Second, the **orientation** setting is saved but isn't actually
> forwarded to the plugin in this version, so switching to `vertical` has no effect
> without a code/JS change. The [agent docs](../agent/theming/markup.md) explain
> both in detail.
