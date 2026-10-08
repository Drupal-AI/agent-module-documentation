# Layout Builder Component Attributes — manual setup guide

**Layout Builder Component Attributes** (`layout_builder_component_attributes`) lets
editors add plain HTML attributes — an **ID**, one or more **classes**, an inline
**style**, and **data-\*** attributes — to the individual blocks (components) they
place with Layout Builder. It fills a common gap: you have laid out a page with
Layout Builder and you want to give one particular block an anchor ID, a utility
CSS class, or a data attribute for JavaScript to hook onto, without writing a new
block template.

Once enabled, every block placed in a layout gains a **Manage attributes**
contextual link (right after *Configure*). Clicking it opens an off‑canvas form
where you enter the attributes you want. Better still, you can target three
distinct parts of the rendered block separately: the outer **wrapper** element, the
block **title** element, and the inner **content** element — so, for example, you
can put an ID on the title heading while classing the wrapper.

Site builders keep control through a global settings page that decides **which
attribute types are allowed** on each of those three parts. You might allow only
classes (to enforce a class‑based styling policy), disallow inline styles
site‑wide, or permit data attributes on wrappers but not titles. Two permissions
separate the people who set that policy from the editors who apply attributes. One
thing to know: the block content attributes only render if your theme's
`block.html.twig` prints `content_attributes` — many core themes do not, in which
case wrapper and title attributes still work but content attributes are silently
dropped.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Layout Builder.
2. [Configuration](configuration/index.md) — the global policy of allowed
   attributes, and the per‑component Manage attributes form.

## Where it lives in the admin menu

The global settings form is at **Configuration → Content authoring → Layout Builder
Component Attributes** (`/admin/config/content/layout-builder-component-attributes`).
The per‑block controls appear as a **Manage attributes** contextual link on each
component while editing a layout.

## How to use it

1. Enable the module and grant the two permissions as appropriate (see
   [Installation](installation/index.md)).
2. On the global settings form, decide which attribute types are allowed on the
   wrapper, title and content of blocks.
3. While editing a layout, click **Manage attributes** on a block and enter its ID,
   classes, style or data‑\* attributes.
