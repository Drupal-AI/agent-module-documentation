# Image Fetchpriority — manual setup guide

**Image Fetchpriority** (`image_fetchpriority`) lets site builders add the HTML
**`fetchpriority`** attribute to images straight from the admin UI, without writing
any code. `fetchpriority` is a hint to the browser about how urgently an image
should be loaded — and setting it well is one of the most direct ways to improve
**Core Web Vitals**, specifically **Largest Contentful Paint (LCP)**. Marking a
hero or above-the-fold image as high priority tells the browser to fetch it sooner;
marking decorative or below-the-fold images as low priority frees up bandwidth for
what matters.

The module extends Drupal's **existing** core image formatters rather than adding
new ones — the setting appears inside the standard **"Image loading"** fieldset in
*Manage display*, and it supports both the standard **Image** and **Responsive
Image** formatters natively. The options are **High**, **Low**, and **Auto** (the
default). It adds only an HTML attribute; it has no content or access-control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no separate configuration page** for this module — the setting lives
inside the core image formatter options on *Manage display*, described in "How to
use it" below.

## Where it lives in the admin menu

Image Fetchpriority adds no admin page. You use it from **Structure → Content types
→ *(your type)* → Manage display**, where a **Fetch priority** dropdown appears in
the formatter settings for image fields.

## How to use it

1. Go to the **Manage display** tab of the entity with the image field you want to
   prioritise.
2. Make sure the field uses the **Image** or **Responsive Image** formatter, then
   click the gear icon to open its settings.
3. In the **Image loading** fieldset you will find a new **Fetch priority** dropdown.
   Choose:
   - **High** — for the most important image on the page (typically the LCP element,
     such as a hero banner).
   - **Low** — for images that can wait (decorative or below-the-fold images).
   - **Auto** — leave the decision to the browser (the default).
4. Click **Update**, then **Save**. The chosen `fetchpriority` value is now emitted
   on that field's `<img>` markup.

> **Tip:** set **High** on at most one image per page — the one you expect to be the
> largest contentful paint. Marking many images "high" defeats the purpose.
