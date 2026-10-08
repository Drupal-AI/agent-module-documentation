# Nice ImageField Widget — manual setup guide

**Nice ImageField Widget** (`nice_imagefield_widget`) gives multi-value Image
fields a friendlier editing experience. Instead of Drupal's default table with
its fiddly drag handles, it presents your uploaded images as a **draggable grid
of thumbnails** — you upload several images at once (HTML5 multi-upload),
rearrange them by dragging the tiles around, and click a tile to edit its
*alternative text* and *title* right there. It's the widget people reach for
when an editor is managing a gallery of images and the standard tabledrag
interface feels clumsy.

The module solves a very specific annoyance: the core Image module technically
supports multiple images, but reordering them through the tabledrag rows is slow
and unintuitive. Nice ImageField Widget swaps that for a visual, comfortable
grid built on the jQuery UI Sortable interaction. Because of that, it **depends
on the contributed [jQuery UI Sortable](https://www.drupal.org/project/jquery_ui_sortable)
module** (that library moved out of core in Drupal 9), and it uses the jQuery
Flip plugin for its click-to-edit tiles.

There is **no configuration page** for this module. You turn it on by choosing
the widget on a field's *Manage form display* — everything happens there. For
the best-looking grid, give the field a preview image style of at least
220×220 pixels, and if you upload many large images at once you may need to
raise a few PHP limits (`max_input_vars`, `max_file_uploads`, `post_max_size`,
`upload_max_filesize`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, add the
   jQuery UI Sortable dependency, and enable the module.

There is **no configuration page** for this module — it has no settings form.
Setup happens on your Image field's form display, described in "How to use it"
below.

## Where it lives in the admin menu

Nice ImageField Widget adds no admin page of its own. You use it entirely from
**Structure → Content types → *(your type)* → Manage form display**, by choosing
its widget for a multi-value Image field.

## How to use it

1. Add (or edit) an **Image** field on a content type and make sure it allows
   **more than one value** — the widget is for multi-value fields.
2. Go to that content type's **Manage form display**
   (`admin/structure/types/manage/{type}/form-display`).
3. For your Image field, change the **Widget** to **Nice Multiple** (also shown
   as the "Nice Image Widget").
4. Save. On the node edit form the field now shows a drag-and-drop grid: upload
   several images at once, drag the tiles to reorder them, and click any tile to
   edit its alt text and title.

> **Tip:** Set the field's preview image style to at least 220×220 px so the
> thumbnails render at a comfortable size in the grid.
