# CountUp — manual setup guide

**CountUp** (`countup`) is a CKEditor 5 plugin that lets editors insert animated
"count‑up" numbers directly into rich‑text content — a figure that animates from
zero up to its value as it scrolls into view, the staple of a stats or impact
section ("10,000+ members", "98% satisfaction"). It also provides a **CountDown**
widget that counts a timer down from a chosen date to the present.

The problem it solves: building an animated statistic normally means a custom field
or block plus some JavaScript. CountUp turns it into an editor action inside
CKEditor 5 — the editor inserts a count‑up element, sets the target number and
options, and the rich text carries the animated figure without a developer being
involved.

It depends on core's **CKEditor 5** and **editor** modules, and it needs the
external **CountUp.js** JavaScript library (installed automatically when you require
the module with Composer — see [Installation](installation/index.md)).

One gotcha is worth knowing up front, because it's the most common reason such a
plugin appears "not to work": the text format's **allowed HTML must permit the
element the plugin inserts**, or the format's filter will strip it out on render.
The editor inserts it, the filter removes it, and the animation never appears. Make
sure the CountUp filter runs *after* any filter that limits allowed HTML tags.

The module works on Drupal 10.3 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   CountUp.js library) and enable the module.

There is **no central settings page** — CountUp is configured per text format, in
the same place you manage your CKEditor 5 toolbar and filters (see "How to use it").

## Where it lives in the admin menu

CountUp adds no admin page of its own. You enable and configure it per text format
at **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), then use its toolbar buttons directly in the
CKEditor.

## How to use it

1. Go to **Configuration → Content authoring → Text formats and editors** and edit
   the text format you want CountUp available in.
2. In the CKEditor 5 toolbar configuration, **drag the CountUp and/or CountDown
   icons** from the available buttons into the **Active toolbar**, in the *Tools*
   group.
3. In the same format's **Enabled filters**, turn on the **CountUp filter**. Make
   sure it runs *after* any filter that restricts allowed HTML tags, so it isn't
   stripped.
4. Save the text format.
5. Now, when editing content with that format, click the **CountUp** or
   **CountDown** icon in the toolbar and configure the animation (for CountUp, the
   start and end numbers; for CountDown, the target date and an optional alarm time
   before the end at which the timer starts to pulse).

> **Note:** the `labels` attribute is overridden by the text filter, so it should
> not be set when editing the widget's source code directly.
