# Image Hover Effects — manual setup guide

**Image Hover Effects** (`image_hover_effects`) adds a selectable **hover effect** —
zoom, fade, slide and similar — to the core image field formatter. Instead of a
theme developer writing the same handful of hover treatments into CSS on every
project, the effect becomes a **display setting** you pick in the view mode, right
where the rest of your display configuration lives.

Making it a formatter setting means the choice is exportable with your
configuration and changeable by whoever manages displays — not only by whoever can
deploy CSS. The module integrates with core's Fields API and the Views API. Its
notable strength is that it depends on core's **Responsive Image** module as well
as **Image**, so the effects apply to responsive image fields too, not only plain
ones — a common shortcoming in modules of this kind. Because a hover effect only
makes sense on a *linked* image, the styling assumes there's a link wrapped around
the image.

(For provenance: the module comes from the commercial theme vendor Sooperthemes /
DXPR, but it is GPL‑licensed like any other contrib module.)

Two things are worth weighing before you use it. **Hover doesn't exist on touch
devices** — so if an effect *reveals information* rather than merely decorating,
plan a non‑hover path, and beware that an overlay which appears on tap and stays can
block the link underneath. And for performance, an effect that animates size or
position (rather than `transform` and `opacity`) does layout work on every frame —
worth checking on a grid of many cards on a mid‑range phone.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.

There is **no configuration page** for this module — it has no central settings
form. You choose the effect on a field's display, described in "How to use it"
below.

## Where it lives in the admin menu

The module adds no admin page. You use it entirely from **Structure → Content types
(or any entity) → *(bundle)* → Manage display**, on an image field that is set to
link to its content or file.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to the **Manage display** page for the content type (or view mode) whose
   image field you want to enhance.
3. Make sure the image field's formatter is set to **link** the image (to content or
   to the file) — the hover effect depends on a link wrapping the image.
4. In the formatter's settings (the gear icon), choose a **hover effect** such as
   zoom, fade or slide.
5. Save the display and view a page that uses it — hovering a linked image should now
   trigger the effect.

Because this is a formatter setting, it is captured in your exported configuration,
so the choice moves cleanly between environments.
