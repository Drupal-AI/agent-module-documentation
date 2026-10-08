# Copy Layout Builder section — manual setup guide

**Copy Layout Builder section** (`lb_copy_section`) adds **Copy** and **Paste** links to
Layout Builder sections, so an editor can duplicate a whole section — its layout,
settings, blocks and inline content — within the same page or onto a completely
different page.

Building the same complex section twice is tedious and error-prone. With this module, an
editor copies a fully built section (columns, blocks, configuration and all) and pastes
it wherever they need it, in two clicks, instead of rebuilding it by hand. It's ideal for
reusing a hero/banner across landing pages, repeating a card row within a page, or
moving a section's design between a node's layout and a content type's default layout.

Crucially, the copies are **independent**. When a section contains an inline (custom)
block, pasting it deep-clones that block — generating fresh IDs and duplicating any
referenced inline blocks and paragraphs — so the pasted copy can be edited without
affecting the original. The copy buffer lives in the editor's own private session store,
which means a section copied while editing one page can be pasted on any other page that
same editor opens.

The module has **no configuration UI and no settings** — its only setup is a single
permission that controls who can copy and paste. Everything works within the Layout
Builder editing interface over AJAX, refreshing the layout in place.

This guide is written for a **human**. If you want terse, token-cheap references for an
AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module, and
   grant the permission.

## Where it lives in the admin menu

The module adds no settings page. Its one control is the **Copy/paste sections**
permission at **People → Permissions** (`/admin/people/permissions`). The Copy and Paste
links themselves appear directly in the Layout Builder editing UI.

## How to use it

1. Make sure Layout Builder is enabled for the layout you're editing, and that your role
   has the **Copy/paste sections** permission (see
   [Installation](installation/index.md)).
2. Edit a layout. Every existing section now shows a **Copy** link, and every "add
   section" position shows a **Paste** link.
3. Click **Copy** on the section you want to duplicate. It's stored in your private copy
   buffer.
4. Navigate to where you want it — the same page, or any other page you edit — and click
   **Paste** at the target position.

The section is inserted with all its content deep-cloned, so any inline blocks and
paragraphs become new, independent copies you can edit without touching the original.

Because the copy buffer is tied to your user session, only trusted content roles should
be granted the permission — it lets an editor duplicate arbitrary section content.
