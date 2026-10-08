# Paragraphs — manual setup guide

**Paragraphs** (`paragraphs`) is a content-building tool that replaces a single
freeform "body" field with structured, mix-and-match components. Instead of asking
editors to pour text, images, and embeds into one WYSIWYG box, you define a set of
reusable **Paragraph types** — a text block, an image, a quote, a slideshow, a
call-to-action, a two-column layout — each with its own fields and display
settings. Editors then add, duplicate, reorder, and nest those components inside a
field on a node (or any other fieldable entity).

Under the hood each paragraph is a proper content entity, referenced from the host
through an **Entity Reference Revisions** field, so every paragraph is fully
revisionable and travels with its parent's revision history. Editors work through a
purpose-built widget (the modern "Stable" widget by default, with a legacy
"Classic" widget still available) that supports collapsing, previewing, and
drag-and-drop reordering — including moving paragraphs between nesting levels.

Paragraphs works as soon as you enable it, but it does no visible work until you
**build your own Paragraph types and add a Paragraphs field** — the module ships no
default types on purpose, so the structure is entirely yours to design. Its only
hard dependencies are the contributed **Entity Reference Revisions** module and
core's **File** module. Three optional submodules extend it: **Paragraphs Library**
(reuse one authored paragraph across many pages), **Paragraphs Type Permissions**
(grant or deny create/edit/delete per type), and **Paragraphs Demo** (example
types to learn from).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its dependency, and choose the submodules you need.
2. [Configuration](configuration/index.md) — create Paragraph types, add a
   Paragraphs field, and the optional global settings form.

## Where it lives in the admin menu

You manage Paragraph types at **Structure → Paragraphs types**
(`/admin/structure/paragraphs_type`, the `entity.paragraphs_type.collection`
route). A small global settings form sits separately at **Configuration → Content
authoring → Paragraphs settings** (`/admin/config/content/paragraphs`).

## How to use it

The typical flow has three parts:

1. **Define one or more Paragraph types.** Each type is like a mini content type —
   give it a label and add the fields it needs (for a "Text" type, a formatted-text
   field; for an "Image" type, an image field; and so on). Optionally attach
   **behavior plugins** to add layout, spacing, or CSS-class options without adding
   storage fields.
2. **Add a Paragraphs field to a host entity.** On a content type's *Manage
   fields*, add a field of type **Paragraph**, then choose which Paragraph types
   editors may add and set the field's cardinality (usually *Unlimited*).
3. **Tune the editing experience** on the host's *Manage form display* — pick the
   Stable or Classic widget and configure edit/preview modes and the add-item UX
   (dropdown, buttons, or modal).

Editors then see the Paragraphs widget on the content form, where they add
components, reorder them by dragging, duplicate them, and collapse them to a
summary for easier management of long pages.
