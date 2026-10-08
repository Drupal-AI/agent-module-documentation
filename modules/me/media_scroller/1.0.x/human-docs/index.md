# Media Scroller — manual setup guide

**Media Scroller** (`media_scroller`) provides a field formatter that renders an
image or media-image field as a **horizontal scroller** — a main slider paired with
thumbnail navigation — using the **Slick** carousel library. Multiple images become
a synchronized, swipeable strip that works on desktop and mobile alike.

It works on both plain **Image** fields and **Media reference** fields that point at
image media. You can choose an image style per formatter, and you can have several
independent sliders on the same page. It depends on core **Image** and the
[Slick](https://www.drupal.org/project/slick) module.

Because it only presents existing images, the media follows normal core media/file
access — the formatter adds no content or access behavior of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Slick dependency.

This module has **no configuration page**. You choose and tune the formatter
entirely on a field's *Manage display*, as described under "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page. You use it from **Structure → Content types →
*(bundle)* → Manage display** (or the Manage display tab of any entity that has an
image or media-image field).

## How to use it

1. Make sure you have an **Image** field, or a **Media reference** field pointing at
   image media, with more than one value so there is something to scroll.
2. Go to that entity's **Manage display** tab.
3. For the field, choose the **Media Scroller** format.
4. Open the formatter's settings (the gear icon) and pick the **image style** to use
   for the slides.
5. Save. The field now renders as a horizontal scroller with thumbnail navigation.
