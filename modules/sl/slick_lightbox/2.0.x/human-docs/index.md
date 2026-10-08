# Slick Lightbox — manual setup guide

**Slick Lightbox** (`slick_lightbox`) opens images — and core Media videos — inside a
swipeable **Slick carousel shown in a lightbox**. Click a thumbnail and a full-screen
slider appears, letting visitors flick through the gallery. It is a nice alternative
to Colorbox or PhotoSwipe when you are already using the Slick/Blazy family of
modules.

The module has **no field formatter of its own**. Instead it plugs into the existing
**Media switcher** dropdown on Blazy and Slick field formatters (and the Blazy Filter
for inline images), adding a new option called **Image to Slick Lightbox**. So you use
it by picking that switcher on a field's display settings, not by configuring a page.
The slider's behaviour (how many slides, lazy loading, swipe, breakpoints) comes from a
single Slick **optionset** that ships with the module and can be edited if you install
the Slick UI sub-module.

It works once enabled and selected as a switcher, but it has one external requirement:
the third-party **slick-lightbox** JavaScript/CSS library must be installed in your
site's `/libraries` directory. The module includes a status-report check that tells
you if the library is missing. It requires **Slick 3.x** (which brings Blazy along)
and provides no permissions, routes, services, or Drush commands.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and install the front-end library.

## Where it lives in the admin menu

There is no settings page of its own. You enable it per field on **Manage display**
(`/admin/structure/…/display`) by choosing **Image to Slick Lightbox** as the Media
switcher, or on a text format's **Blazy Filter**. The Slick optionset that drives the
slider is edited (with the `slick_ui` sub-module enabled) at
`/admin/config/media/slick/list/slick_lightbox/edit`.

## How to use it

### On a field (Manage display)

1. Go to **Structure → [entity type] → Manage display** — for example
   `/admin/structure/types/manage/article/display`.
2. For an image or media field, choose a **Blazy-aware format** — such as **Blazy** or
   a **Slick carousel** formatter.
3. Open that formatter's settings (the gear icon).
4. Under **Media switcher**, select **Image to Slick Lightbox**.
5. Save.

Now clicking an image in that field opens the Slick lightbox slider at that item.

### On inline images (Blazy Filter)

Enable **Blazy Filter** on a text format (under *Configuration → Content authoring →
Text formats and editors*) and set its **Media switcher** to **Image to Slick
Lightbox**. Inline images in that format then open in the lightbox.

### Tuning the slider

All Slick Lightbox sliders share one Slick optionset (`slick_lightbox`). To change how
the slider behaves — centre mode, lazy loading, slides shown, swipe, responsive
breakpoints, or a custom skin — edit that optionset at
`/admin/config/media/slick/list/slick_lightbox/edit`. That editing UI needs the
**Slick UI** sub-module enabled (`drush en slick_ui -y`); without it the route is
access-denied. Because it is one shared optionset, your changes apply to every Slick
Lightbox slider on the site.
