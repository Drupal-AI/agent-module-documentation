# Paragraphs Clipboard — manual setup guide

**Paragraphs Clipboard** (`paragraphs_clipboard`) adds **Copy to clipboard** and
**Paste from clipboard** actions to the Paragraphs editing widget. Editors can copy
a saved paragraph — with all of its data and nested paragraphs — and paste it into
another paragraph field, even on a different node, without rebuilding it by hand.
It's a big time‑saver for reusing hero sections, calls to action, or any
repetitive layout blocks.

It works by enhancing the standard Paragraphs widget rather than replacing it. A
**Copy to clipboard** action appears on each saved paragraph; clicking it stores a
reference to that paragraph in your own private clipboard (kept per‑user for your
session). A **Paste from clipboard** button then appears on any compatible
paragraph field that still has room, and clicking it drops a fresh copy in. You can
also copy a paragraph straight from the admin Paragraphs listing, and — if the
`paragraphs_edit` module is installed — from a rendered paragraph on the page.

The module is careful about access and validity: you can only copy paragraphs you
have permission to edit, and you can only paste into a field whose allowed
paragraph types include the copied one (and only if the field hasn't hit its limit).
When the **Replicate** module is present it's used for deep, reference‑safe cloning;
otherwise the module uses Drupal's built‑in duplication.

There is **no settings page and no module‑specific permissions** — it relies on
the standard paragraph and entity access you already have. An optional submodule,
**Layout Paragraphs Clipboard** (`layout_paragraphs_clipboard`), extends the same
copy/paste to the Layout Paragraphs builder.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   the optional Layout Paragraphs submodule.

## Where it lives in the admin menu

There's nothing to configure and no admin page. The copy/paste actions appear
directly on the Paragraphs widget wherever you edit content that uses paragraph
fields.

## How to use it

1. Enable the module (see [Installation](installation/index.md)). No configuration
   is needed.
2. Edit any content that has a Paragraphs field, and make sure the paragraph
   you want to copy has been **saved** (the copy action is disabled on brand‑new,
   unsaved paragraphs).
3. Open that paragraph's actions dropdown and click **Copy to clipboard**. You'll
   see a confirmation message.
4. Go to the paragraph field where you want the copy — on the same form or on a
   different node's edit form. If the field accepts that paragraph type and still
   has room, a **Paste from clipboard** button appears in its *Add more* area.
5. Click **Paste from clipboard**. A full copy of the paragraph (including nested
   paragraphs) is added to the field.

> **Tips:**
> - You can also copy a paragraph from the admin **Paragraphs** listing view, and
>   (with `paragraphs_edit` installed) from a paragraph as rendered on the page.
> - Install the **Replicate** module for the most robust cloning of complex,
>   deeply nested paragraphs.
