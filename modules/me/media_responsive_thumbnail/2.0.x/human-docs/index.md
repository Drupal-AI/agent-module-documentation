# Media Responsive Thumbnail — manual setup guide

**Media Responsive Thumbnail** (`media_responsive_thumbnail`) fills a small but
real gap in Drupal. Core lets a plain **Image** field be displayed with a
**responsive image style** (which outputs a `<picture>` element and serves
appropriately sized images per screen size), but it does *not* offer that same
option on a **Media reference** field. This module adds a single field formatter,
**"Responsive thumbnail"**, that closes the gap: it lets a field that references
Media entities render responsively, picking a responsive image style just like an
Image field would.

The result is better-performing images on media-driven sites — a "Featured image"
or "Hero" media field can serve a small derivative to phones and a large one to
desktops, improving bandwidth and Largest Contentful Paint, all without writing a
custom formatter. It reuses core's own Responsive Image formatter under the hood,
so it inherits the familiar settings (which responsive image style to use, what the
image links to, and lazy-loading), and it works for any media type whose thumbnail
is an image — including video/audio types, where it uses the poster/cover image.

The formatter only appears as an option on fields that actually reference **Media**
entities, so it won't clutter the format list on other entity-reference fields.
There is no admin settings page — you configure it per field on the *Manage
display* tab. It needs core's **Media** and **Responsive Image** modules and works
on Drupal 9, 10, and 11.

Before it does anything useful you'll need at least one **responsive image style**
defined (core's own feature, at *Configuration → Media → Responsive image styles*),
since that's what the formatter renders with.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and its core dependencies).

## Where it lives in the admin menu

It has no page of its own. You choose the formatter on the **Manage display** tab
of whichever entity type holds your Media reference field — for example
`/admin/structure/types/manage/article/display`.

## How to use it

1. Make sure you have a **responsive image style** to render with. If not, create
   one at **Configuration → Media → Responsive image styles**
   (`/admin/config/media/responsive-image-style`). This is core functionality and
   depends on your theme's breakpoints.
2. Go to the bundle's **Manage display** tab (the content type, media type,
   paragraph, term, or user that has your Media reference field).
3. Set that field's **Format** to **Responsive thumbnail**.
4. Click the gear/cog icon and configure:
   - **Responsive image style** — which style to render with (choose the one you
     created).
   - **Image link** — what the image links to: nothing, the **Content** (the entity
     that has the field), or the **Media** item's own page. *(Pick "Content" or
     "Media" — the inherited form also lists a "File" option, but this formatter
     doesn't act on it, so it produces no link.)*
   - **Image loading** — `lazy` (default) or `eager` for the `loading` attribute.
5. Click **Update**, then **Save**.

If a referenced media item's main image is empty, the formatter falls back to the
media entity's generated **thumbnail** so something is still shown.
