# Gutenberg Editor — manual setup guide

**Gutenberg Editor** (`gutenberg`) brings the WordPress Gutenberg block editor to
Drupal. Instead of a single rich‑text box, editors compose a page out of **blocks** —
paragraphs, headings, images, galleries, columns, quotes, tables, embeds, reusable
blocks, and more — in a full‑screen editing experience. The composed content is
stored as block markup in a regular long‑text field and rendered back out through a
text filter.

The key thing to know is that Gutenberg is switched on **per content type**, not
per field. Under the hood it ships a `gutenberg` text format paired with a matching
editor, but you do not assign that format field by field. Instead, each content
type's edit form gains an **"Enable Gutenberg experience"** checkbox; tick it and
Drupal swaps that type's node form for the block editor.

Beyond the core block library, Gutenberg supports embedding media from the Media
Library, inserting oEmbed content (YouTube, Vimeo, and so on), creating and reusing
**reusable blocks**, and building custom inline blocks. Developers can add their own
editor blocks through a `MODULE.gutenberg.yml` discovery file, register server‑side
"dynamic" blocks, and write editor JS plugins — but for day‑to‑day authoring you just
enable it on a content type and start writing.

Three permissions gate it — using the editor, managing block locks, and creating
custom content blocks — and there is no single admin settings page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   grant the permissions.
2. [Configuration](configuration/index.md) — enable Gutenberg on a content type,
   set a starter template and allowed image styles, and understand the text format
   and permissions.

## Where it lives in the admin menu

Gutenberg has no global settings page. You turn it on from **Structure → Content
types → (your type) → Edit** (`/admin/structure/types/manage/<type>`) with the
**Enable Gutenberg experience** checkbox. Its text format lives at **Configuration →
Content authoring → Text formats and editors**, and its permissions are at **People →
Permissions**.

## How to use it

1. Enable the module and grant the **Use Gutenberg** permission to authoring roles.
2. Edit a content type and tick **Enable Gutenberg experience**, then save.
3. Add or edit content of that type — you now get the full block editor instead of
   the standard node form.

See [Configuration](configuration/index.md) for templates, image‑style limits, and
the permissions in detail.
