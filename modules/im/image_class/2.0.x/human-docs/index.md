# Image Class — manual setup guide

**Image Class** (`image_class`) adds a **"Class"** text field to Drupal's image
field formatters, so you can attach one or more CSS classes directly to the
rendered `<img>` element — right from *Manage display*, with no custom template or
preprocess hook. Type something like `img-fluid rounded` and those classes land on
the image tag.

It's a small, focused formatter enhancement. It adds no field type, widget or
settings page of its own; it simply extends four existing formatters — **Image**,
**Responsive image**, **Media thumbnail** and **Media responsive thumbnail** — with
one extra setting. Use it to apply framework utility classes (Bootstrap's
`img-fluid`, `rounded`, `card-img-top`, …), lazy-load hooks like `lazyload`, or any
CSS anchor a lightbox or gallery script needs.

The class value is space-separated (so you can add several at once) and is stored
as a third-party setting on the field's display configuration — meaning it exports
and deploys like any other display config, and you can set different classes per
view mode. When the image renders, the module merges your classes with any classes
already present rather than replacing them, so nothing else is disturbed. The stored
image and the field itself are untouched — the effect is purely on the display
markup. The module has no dependencies beyond Drupal core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no dedicated settings page. The **Class** field appears in the settings of
supported image formatters on any bundle's *Manage display* page — for example
**Structure → Content types → Article → Manage display**.

## How to use it

1. Go to the bundle's **Manage display** (for example
   `/admin/structure/types/manage/article/display`).
2. Make sure the image field uses one of the supported formatters — **Image**,
   **Responsive image**, **Media thumbnail** or **Media responsive thumbnail**. The
   Class field only appears for these four; other formatters don't show it.
3. Click the cog on the field's row.
4. In **Class**, enter one or more space-separated classes (for example
   `img-fluid rounded`).
5. Click **Update**, then **Save**. The formatter summary then shows your class
   value, and the classes appear on the `<img>` tag when the field is rendered.

Because the setting lives per field, per view mode, you can style the same image
differently in, say, the teaser and full displays.
