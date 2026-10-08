# AP Style Augmenter — manual setup guide

**AP Style Augmenter** (`apstyle_augmenter`) formats dates to match the
**Associated Press (AP) Stylebook** conventions — abbreviated month names, no
leading zeros on days, and the other date rules newsrooms follow. It is a small
editorial formatting helper for sites that publish in AP style.

It works as a plugin for the **Date Augmenter** system (the `date_augmenter`
module, which it depends on). Date Augmenter lets modules adjust how a date field
is displayed without replacing the field's own formatter; this module plugs into
that system and rewrites the output into AP style. There is nothing to it beyond
the formatting — it has no settings page, no permissions, and no security
surface.

Because it hooks into Date Augmenter, you turn it on where you configure the date
field or view's display: enable AP Style Augmenter as one of the augmenters
applied to a date. One thing worth confirming after setup is that the output
still matches the current AP Stylebook rules for the specific date formats you
use, since style guides do change over time.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and its Date Augmenter dependency).

## How to use it

There is no dedicated settings page. Once the module is enabled, AP Style
Augmenter becomes available as a **Date Augmenter** plugin. Configure it where
Date Augmenter is configured — on a date field's display settings (**Manage
display**) or in a view — by enabling this augmenter for the date you want shown
in AP style. Then preview a node or view to confirm the month abbreviations and
day formatting read the way you expect.
