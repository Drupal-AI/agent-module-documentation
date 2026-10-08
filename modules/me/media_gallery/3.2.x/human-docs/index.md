# Media Gallery — manual setup guide

**Media Gallery** (`media_gallery`) lets you group core Media items into named
galleries and show them to visitors as a polished PhotoSwipe lightbox — click a
thumbnail and it opens full‑screen with swipe and zoom. Instead of scattering
images across nodes, you build a reusable *gallery* entity, drop images into it
with the familiar Media Library picker, and Drupal takes care of the thumbnails,
the pager, and the lightbox.

Under the hood the module adds its own `media_gallery` content entity. You create
and manage galleries at **Content → Media galleries**, each gallery gets its own
page, and a ready‑made "All Galleries" listing appears at `/galleries` for site
visitors. Because it is a real Fieldable entity, you can add your own fields
(a caption, a category) through Manage fields, just like you would on a content
type.

Two placeable blocks let you surface galleries anywhere on the site: a **Media
Gallery** block that shows one gallery you pick, and a **Latest gallery items from
all galleries** block that shows the newest media across every gallery. Both render
through a pluggable layout system, so you can choose a Grid, Featured image grid,
Horizontal, Vertical, or Swiper carousel arrangement. Galleries happily mix images
with video and oEmbed media (YouTube/Vimeo), and everything is translatable on a
multilingual site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in the
   PhotoSwipe library and module), enable it, and note the optional migration
   submodules.
2. [Configuration](configuration/index.md) — create a gallery, add your own
   fields, and place and tune the two gallery blocks.

## Where it lives in the admin menu

Once enabled, you manage galleries at **Content → Media galleries**
(`/admin/content/media-gallery`) — that is where you add, edit, and delete them.
Structure and Field UI (Manage fields / form display / display) sit at
**Structure → Media gallery settings** (`/admin/structure/media-gallery`). Visitors
browse the shipped "All Galleries" page at `/galleries`.

## How to use it

1. Go to **Content → Media galleries → Add media gallery**.
2. Give the gallery a **title**, an optional **description**, and add media to the
   **Images** field using the Media Library picker (existing media or freshly
   uploaded).
3. Decide whether to paginate: turn on **Use pager** and set **Items per page**
   (default 12), or turn on **Reverse** to flip the display order.
4. Save. The gallery gets its own page, appears in the `/galleries` list, and can
   be shown in any region through the gallery blocks (see
   [Configuration](configuration/index.md)).

There is no site‑wide settings form to fill in — the module works as soon as it is
enabled, and all the real choices are made per gallery and per block.
