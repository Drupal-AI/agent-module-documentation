# EPT Counter — manual setup guide

**EPT Counter** (`ept_counter`) adds a single Paragraph type to your site: an
animated number counter paired with a short block of rich text. It is the
"headline figure" component — the kind of thing you use to show *10,000 members
served*, *25 years operating*, or *98% satisfaction* — where a large number
counts up as the visitor scrolls it into view. The counting animation comes from
the [countUp.js](https://github.com/inorganik/countUp.js) library, and the
Paragraph type supports laying the figures out in 2, 3, or 4 columns.

EPT Counter is one module in the **Extra Paragraph Types (EPT)** family. Every
EPT module ships one ready-made Paragraph type and leans on the shared
[`ept_core`](https://www.drupal.org/project/ept_core) base module for a common
set of per-instance *design options* — CSS box spacing (margins, padding,
borders), a background (color, image with parallax or cover, or a YouTube video),
edge-to-edge or contained width, and so on. Because of that, there is **no
site-wide settings page** for this module: you configure each counter where you
place it, on the individual paragraph.

A couple of editorial points are worth carrying into any page that uses counters.
A figure with no visible source is really just an assertion, so make sure the
page around the counter can say where the number came from and when it was true.
And because the count-up is motion, the final value must always be present even
when the animation does not run — for a screen-reader user, for a visitor with
reduced-motion preferences, or when JavaScript never loads.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and confirm the Paragraph type appears.

There is **no configuration page** for this module. Counters are configured
per instance, on the paragraph itself, using the shared EPT design options
described below.

## Where it lives in the admin menu

EPT Counter adds no admin settings page of its own. Once enabled, it registers a
**Counter** Paragraph type, which you'll find listed under **Structure →
Paragraphs types** (`/admin/structure/paragraphs_type`). You don't edit content
there — that page just confirms the type exists and lets you tune its fields if
you need to.

## How to use it

Like every EPT component, Counter is used by placing it inside a **Paragraphs
field**:

1. On a content type (or any fieldable entity) that has an *Entity reference
   revisions* Paragraphs field — for example a landing page's **Body components**
   field — make sure the field's settings allow the **Counter** paragraph type.
2. Edit a piece of content, add a **Counter** paragraph, and fill in the numbers
   and their labels (and choose 2, 3, or 4 columns).
3. Open the paragraph's **design options** (provided by `ept_core`) to set
   spacing, background, and width for that specific counter.
4. Save. The counter renders on the page and animates up when it scrolls into
   view.

Because the design options live on each paragraph, two counters on two different
pages can look completely different without any new configuration or view modes.
