# Media Reference Override — manual setup guide

**Media Reference Override** (`media_reference_override`) lets editors override
specific fields of a referenced media item — such as an image's **alt text** or
**title** — right at the point of reference, without touching the original media
entity. When you reuse the same image across many pages, its alt text and title
live on the shared media entity, so changing them changes every place that image
appears. The only built‑in workaround is duplicating the media just to give it a
different description, which clutters the Media Library. This module removes that
compromise.

The override is stored on the **referencing** entity — the node, paragraph, or
block — not on the media itself. So the same image can carry a completely different
alt text on a landing page than it does in a press kit, while the shared media
entity stays clean, canonical, and reusable everywhere else. Think of it as each
piece of content keeping its own "local note" about how to describe a media item.

When an editor selects a media item, an inline override section appears beneath it
(via an off‑canvas form) where they can enter context‑specific values. A companion
field formatter substitutes those values when the media is rendered, so the correct
contextual output appears in the final HTML — and when no override is set, the
rendering is untouched, so the frontend impact is zero. It works with Drupal's core
Media and Media Library systems without new field types or widget replacements, and
applies anywhere a media reference field lives: content types, Paragraphs, Layout
Builder blocks, Views, and any fieldable entity.

The main reasons to reach for it are accessibility (the same hero image needing
different, context‑specific alt text on different pages to meet WCAG), press and
marketing (one photo reused with different captions), page‑specific SEO, and
editorial independence (content teams managing contextual metadata without touching
the shared library or filing a developer request). It depends on core's **Media**,
**Media Library**, **Image**, and **File** modules, and provides its own permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central settings page**. You enable overrides per field on **Manage
form display** — described under "How to use it" below.

## Where it lives in the admin menu

The module adds no standalone settings form. You turn overrides on per media
reference field, on the host entity's **Manage form display** and **Manage
display**.

## How to use it

No coding is required:

1. On the entity that has your media reference field (a content type, paragraph
   type, block type, etc.), open **Manage form display**.
2. For the media reference field, enable the module's **override widget** (the
   extended widget it provides) and choose which media fields — such as `alt` and
   `title` — editors may override. Save.
3. On the same entity's **Manage display**, use the module's **formatter** so that
   override values are substituted when the media renders.
4. Now, when an editor references a media item, an inline override section appears
   beneath the selection. Values they enter are stored on the referencing entity;
   the shared media entity is never modified, and pages without an override render
   exactly as before.
