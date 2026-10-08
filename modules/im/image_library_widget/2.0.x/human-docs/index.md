# Image Library Widget — manual setup guide

**Image Library Widget** (`image_library_widget`) is an image field widget that
lets editors either **upload a new image** or **pick an existing one from a reusable
library** — so common images (logos, banners, stock photography) get reused instead
of re‑uploaded as duplicates.

It extends the core image widget by adding an "image browser". That browser is
actually a **View** exposing image entries from a Media type you've set up as a
library. When editing content, an editor can use the standard upload, or click a
pre‑uploaded image in the browser to reuse it. Because the browser is a View, you
can customise it freely — grid or list, thumbnail size, and so on. The images
themselves are Media entities, so access follows core media/file access; the module
has no access‑control role of its own. It depends on core **Media** and **Views**.

Two limitations are worth knowing before you rely on it. It currently supports only
**single‑value image fields** (cardinality 1). And if you add a pager to the browser
View, you must enable **Ajax** on that View, because navigating browser pages must
not reload the page the widget sits on. This release is a 2.0.x alpha
(2.0.0‑alpha4) and the project is described as minimally maintained.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Media/Views dependencies.

There is **no central settings form** for this module. Setup happens on Media types
and on the field's widget, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no configuration page of its own. You set it up across a few
familiar places:

- **Structure → Media types → Add media type** (`/admin/structure/media/add`) — to
  create the library.
- **People → Permissions** — to let admins create media entries in that type.
- **Structure → *(content type)* → Manage form display** — to set the field to use
  the Image Library Widget.

## How to use it

1. **Create a library media type.** Go to
   **Structure → Media types → Add media type**, set the **Media type** to *Image*,
   and under **Media source configuration** set the *Field with source information*
   to `media.image_library_widget_image`. Only media types configured this way can
   serve as libraries in the widget.
2. **Grant permissions** so the right site admins/editors can create media entries
   within that media type.
3. **Add some media entries** — the images that will populate the library.
4. **Point an image field at the widget.** On the content type's **Manage form
   display**, set the image field's widget to **Image Library Widget**, then in the
   widget settings choose the media type to use as the library.
5. **(Optional) Customise the browser View.** Since the "image browser" is a View,
   you can change its display format (grid, list, unformatted), thumbnail size, and
   more. If you add a pager, remember to enable **Ajax** on the View.

Now, when editors edit that field, they can upload a new image or click an existing
one from the library.
