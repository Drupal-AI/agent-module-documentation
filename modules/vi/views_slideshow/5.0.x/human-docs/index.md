# Views Slideshow — manual setup guide

**Views Slideshow** (`views_slideshow`) adds a **Slideshow** display style to
Views, so the rows of any View can be rendered as a rotating, jQuery‑powered
slideshow. Because a View can output images, fully rendered entities, or any mix
of fields, a "slideshow" can be a plain image carousel, rotating news teasers,
"hottest new products," testimonials, or anything else you can build in Views.

It's important to understand that Views Slideshow is an **API / framework**. It
defines the slideshow style and the controls (widgets) that go around it, but it
does *not* animate the slides on its own — that job is delegated to a **slideshow
type** engine. The module ships one engine as a submodule, **Views Slideshow
Cycle** (`views_slideshow_cycle`, built on jQuery Cycle), so in practice you
enable both the base module and the Cycle submodule. Around the slides you can
add configurable **widgets** — previous/next controls, a pause/play button, a
bullet or thumbnail pager, and a "slide X of Y" counter — placed at the top,
bottom, or both. A **skin** plugin controls swappable layout and CSS (the base
module ships a single `default` skin).

There is **no global settings form**. Everything is configured *per View
display*, under **Format → Slideshow** in the Views UI: which skin, which
slideshow engine, and which widgets appear where. Views Slideshow depends only on
core **Views**. The Cycle engine additionally needs the external jQuery Cycle
library installed under your site's `/libraries` directory. For developers, the
module defines four plugin types (slideshow type, widget, widget type, and skin)
so you can integrate a different JS slider or add custom controls.

This guide is written for a **human** building a slideshow in the Views UI. If
you want terse, token‑cheap references for an AI coding agent — including the
plugin types, templates, and theme hooks — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   base module, and enable the Cycle engine submodule (plus the jQuery library).

## Where it lives in the admin menu

There's no dedicated settings page. You configure a slideshow entirely inside the
**Views UI** (**Structure → Views**, `/admin/structure/views`): edit a View,
change its display **Format** to *Slideshow*, and open the *Slideshow* settings
to choose the skin, the engine, and the widgets.

## How to use it

1. Enable both **Views Slideshow** and its engine submodule **Views Slideshow
   Cycle** (and install the jQuery Cycle library — see
   [Installation](installation/index.md)).
2. Create or edit a View that returns the rows you want to rotate (for example,
   the latest news items with a title, image, and teaser, or an image field from
   media).
3. In the display's **Format** setting, choose **Slideshow**.
4. Open the Slideshow settings and pick:
   - the **skin** (layout/CSS),
   - the **slideshow type** (engine) — *Cycle*, from the submodule,
   - which **widgets** to show (previous/next, pause, pager, counter) and whether
     they sit at the top, the bottom, or both.
5. Combine the usual Views filters, sorts, and arguments to control which items
   appear and in what order (for example a random sort, or a category argument).
6. Save the View and place it where you need it (a block or a page).

The slideshow settings are stored as part of the View's configuration, so they
export and deploy between environments like any other View.
