# Insert — manual setup guide

**Insert** (`insert`) adds a small **Insert** button to file and image field widgets on
entity edit forms. After an editor uploads a file or image, that button drops the item
straight into a nearby text area or CKEditor body field — as a link to the file, an
`<img>` tag, an `<audio>`/`<video>` player, or a chosen image style — without the editor
having to hand‑write any markup or leave the form.

Insert is a **field‑widget enhancement, not a new field type**. It attaches to your
existing file and image widgets (by default core's *file* and *image* widgets) and adds
an **Insert** section to each widget on the **Manage form display** tab. There you
choose which *insert styles* the editor may pick from — the AUTOMATIC default, "Link to
file", "Embed audio/video", "Original image", and every image style you have configured —
plus a default style, an automatic image style, an optional style to link the image to, a
maximum insert width, and rotation controls. A field's Insert button only appears once
you have enabled at least one style for it.

Global options at **Configuration → Content → Insert** cover site‑wide behaviour: which
widget types Insert attaches to, whether images uploaded to plain file fields count as
images, extra CSS classes to add to inserted markup, absolute vs. relative URLs, and which
file extensions are treated as audio or video. Insert is also extensible through a set of
hooks, which is exactly how its three bundled submodules add new capabilities:
**Insert Media** (`insert_media`), **Insert Colorbox** (`insert_colorbox`), and
**Insert Responsive Image** (`insert_responsive_image`). The module targets **Drupal 10
or 11** and depends on core's **File** and **Image** modules.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module, and
   pick the submodules you need.
2. [Configuration](configuration/index.md) — the global settings page and the per‑widget
   Insert options on Manage form display.

## Where it lives in the admin menu

Insert has two configuration layers in two places:

- **Global settings:** **Configuration → Content authoring → Insert**
  (`/admin/config/content/insert`), reachable with the core **Administer filters**
  permission.
- **Per‑field settings:** the **Manage form display** tab of each entity bundle
  (e.g. `/admin/structure/types/manage/article/form-display`), where you enable and tune
  Insert on each individual file or image widget.

## How to use it

Once installed and enabled on a field (see [Configuration](configuration/index.md)),
editing content with that field shows an **Insert** button beneath the uploaded file or
image. The editor clicks into the body field where they want the item, picks a style from
the Insert control (if more than one is offered), and clicks **Insert** — Insert copies
the corresponding markup into the focused text field. They can insert the same image
several times at different styles into one body if they like.
