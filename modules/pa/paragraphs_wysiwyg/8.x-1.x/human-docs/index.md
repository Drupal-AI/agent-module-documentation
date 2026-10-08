# Paragraphs WYSIWYG — manual setup guide

**Paragraphs WYSIWYG** (`paragraphs_wysiwyg`) lets editors **embed paragraphs
inside a rich‑text (WYSIWYG) field**. Instead of paragraphs living only in a
separate structured field, this module makes it possible to insert paragraph
items inline within body text, so structured components can appear in the middle
of ordinary prose. It provides a simple paragraph type with an editor‑enabled
field and hooks paragraphs into rich‑text editing via the Allowed Formats module.

Embedded paragraphs follow the normal paragraph and field handling, and the
inline content still passes through the text format's filters when it is rendered.
As with any rich‑text embedding, make sure the text format you use **sanitizes
its output** so embedded markup cannot introduce unsafe content. The module has
no access‑control role of its own. It depends on the Allowed Formats and
Paragraphs modules (plus core Field and Text).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside its Allowed Formats and Paragraphs dependencies.

There is **no global settings page** for this module — you set it up on the
text/paragraph fields involved, described in "How to use it" below.

## How to use it

1. With the module enabled, work with the paragraph type it provides (a simple
   paragraph with an editor‑enabled text field), or a Paragraphs field configured
   for inline WYSIWYG embedding.
2. Make sure the **text format** you use with the WYSIWYG field is one that
   sanitizes its output. Review formats at **Configuration → Content authoring →
   Text formats and editors** (`/admin/config/content/formats`).
3. When editing content, editors can embed paragraph items inline within the
   rich‑text field so structured components appear alongside body text.
4. Save and view the content — the embedded paragraphs render inline, filtered
   through the field's text format.
