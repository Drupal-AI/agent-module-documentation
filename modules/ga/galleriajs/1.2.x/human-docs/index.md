# Galleriajs — manual setup guide

**Galleriajs** (`galleriajs`) connects the
[Galleria](https://galleria.io/) JavaScript gallery plugin to **Views**. It adds a
Views display/style that renders your View's results — typically images — as a
Galleria gallery: a slideshow with thumbnails and transitions. If you can build a
View that lists images, you can present them as a polished gallery without writing
any custom JavaScript.

Because the gallery is just another way to format a View, everything you already
know about Views applies: you control which images appear, in what order, and with
what filters and access, and Galleriajs takes those results and hands them to the
Galleria library for display. It depends only on core's Views module.

This is a content‑display feature with **no access role of its own** — the gallery
shows exactly what the underlying View is allowed to show, and respects the View's
access settings. There is no separate settings page; you set everything up on the
View itself.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no global settings
form. You configure it entirely on a View, described in "How to use it" below.

## Where it lives in the admin menu

Galleriajs adds no admin page. You use it from **Structure → Views**
(`/admin/structure/views`), where the Galleria format becomes available as a View
display style.

## How to use it

1. Go to **Structure → Views** and create or edit a View that lists images (for
   example, image fields from your content, or media items).
2. In the View's **Format**, choose the **Galleria** style.
3. Configure the gallery options offered by the format, and make sure the View
   outputs image fields the gallery can display.
4. Save the View and view its page or block — the results render as a Galleria
   gallery with thumbnails and transitions.
