# Entity Embed Placeholder — manual setup guide

**Entity Embed Placeholder** (`entity_embed_placeholder`) makes CKEditor 5 feel
lighter when you embed entities in rich text. When you use the Entity Embed
module to drop a node or media item into the editor, CKEditor normally renders
the entity's full output right inside the editing area. That can be slow, heavy,
or visually noisy — especially when a document has many embeds or the entities
have expensive render output. This module swaps that live preview for a compact
grey placeholder card that shows just the entity's label and its content type or
media bundle.

The result is a calmer, faster editing surface: every embed looks the same, the
editor stops jumping as full-size previews load, and editors can still see at a
glance *what* they embedded and *what kind* of thing it is. It only affects the
in-editor preview (Entity Embed's `embed.preview` route) — the front-end display
of your content is untouched.

The module is pure theme-layer plumbing. It has **no settings form, no
permissions, no routes, and no services** — enable it and it works. Any
customization happens by overriding its two Twig templates
(`node--embed-preview.html.twig` and `media--embed-preview.html.twig`) or its
`.embedded-entity-placeholder` CSS from your own theme or module. It depends on
core's **CKEditor 5** and the contributed **Entity Embed** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Entity Embed and CKEditor 5.

## Where it lives in the admin menu

Nowhere — there is no settings page. Entity Embed Placeholder has nothing to
configure, so it does not add an admin menu item. Once enabled it works
automatically wherever Entity Embed's CKEditor 5 preview appears.

## How to use it

There is nothing to switch on beyond enabling the module. As long as your site
already uses **Entity Embed** with a **CKEditor 5** text format, the change is
automatic:

1. Enable Entity Embed Placeholder (see [Installation](installation/index.md)).
2. Open any content with a CKEditor 5 field that allows entity embeds.
3. Embed a node or media item, or open existing content that already contains an
   embed. Instead of the full rendered entity, you now see a small grey
   placeholder card with the entity's label and its content type / media bundle.

If you want the placeholder to look different, you have three options, all
handled outside this module:

- **Override the template.** Copy `node--embed-preview.html.twig` (or
  `media--embed-preview.html.twig`) into your theme's `templates/` directory and
  edit the markup — for example to add a thumbnail or extra metadata. Clear the
  cache and re-open a fresh embed to see the change.
- **Restyle the box.** Override the `.embedded-entity-placeholder` CSS (grey box,
  fixed height, centered heading) from your theme.
- **Point the theme hook at a different template** with
  `hook_theme_registry_alter()` in a custom module, if you want the placeholder
  to render from somewhere else entirely.

The module's CSS is attached automatically to Entity Embed's editor library, so
your styling loads wherever the editor UI does.
