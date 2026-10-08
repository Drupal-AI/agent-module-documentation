# Media Entity Link — manual setup guide

**Media Entity Link** (`media_entity_link`) lets you store URLs — internal or
external — as **media**. It adds a `link` media *source* and ships a ready‑made
**Link** media type, so a web address becomes a reusable media entity that editors
can browse in the Media Library and reference anywhere media is supported, exactly
the way they'd reference an image or a document.

The nice thing is there's **nothing to build**: on install the module brings its
own complete Link media type, a URL source field, and the form and view displays,
so you can start creating Link media immediately. Each Link media entity is
essentially a friendly name plus a URL. It's ideal for a curated "resources"
library, for reusing one canonical URL across many pages, or for giving link
management Media's revisioning and access control.

When editors add a Link through the Media Library, the module provides a smart URL
box: it offers internal‑path autocomplete (type a node title, no need to know the
path), external URL entry, and the special link tokens `<front>`, `<nolink>`, and
`<button>` — the same conveniences as a normal link widget. Whether a Link may
point to internal paths, external URLs, or both is just the standard core **Link**
field setting on the media type's URL field, which you can change under *Manage
fields*.

The module has **no permissions, Drush commands, or settings form** of its own —
access is governed by core Media's own permissions. It depends on core **Media**,
**Media Library**, **Link**, **Image**, and **Path**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (the Link media type is created automatically).

## How to use it

There's no configuration required — enabling the module creates a working **Link**
media type. From there:

1. **Create Link media.** Go to **Content → Media → Add media → Link**
   (`/media/add/link`), or add one straight from the Media Library when filling a
   media reference field. Give it a name and enter the URL. In the Media Library's
   add form you get internal‑path autocomplete and can use `<front>`, `<nolink>`,
   or `<button>` tokens.
2. **Reference Link media** anywhere you'd reference other media — a media reference
   field, a CKEditor media embed, a paragraph or layout component, a Media view.
3. **Restrict internal vs external (optional).** Whether a Link may be internal,
   external, or both is the core **Link** field's *Allowed link type* setting on the
   media type's URL field (`field_media_entity_link`). Change it under **Structure →
   Media types → Link → Manage fields** (`/admin/structure/media/manage/link/fields`).
   The shipped default allows **both**; set it to external‑only or internal‑only if
   you prefer. The Media Library add form adapts its URL box to whatever you choose.
4. **Add your own fields (optional).** The Link type is a normal media type — add a
   description, category, thumbnail, and so on at *Manage fields* like any other.
