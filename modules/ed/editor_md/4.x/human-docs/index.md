# Editor.md — manual setup guide

**Editor.md** (`editor_md`) plugs the open-source
[Editor.md](https://github.com/pandao/editor.md) JavaScript editor into Drupal's
text-editor system, giving authors a full **Markdown editor with live preview**
in any textarea attached to a text format. Instead of CKEditor's WYSIWYG surface,
writers get a Markdown pane on the left and a rendered preview on the right, with
a toolbar for tables, code blocks, images, and more, plus optional fullscreen
"distraction-free" writing.

It solves the problem of authoring Markdown comfortably inside Drupal — useful
for documentation-style content, or for comment/issue fields where Markdown is
the natural syntax. You can swap CKEditor for Editor.md on whichever formats you
choose and leave the rest untouched.

There is one thing to understand clearly: **Editor.md is an authoring aid, not a
renderer.** It stores exactly what the author types (raw Markdown) and marks
itself as *not* XSS-safe, which means the job of turning that Markdown into HTML
and sanitising it belongs to the **text format's filter pipeline** — specifically
the required **Markdown** module's filter plus Drupal's HTML-restriction/XSS
filters. So this module has a hard dependency on the contrib `markdown` module,
and output safety depends on you configuring the format correctly (see
Configuration). It also needs the Editor.md JavaScript library placed in
`/libraries/editor.md`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, add the
   Editor.md library, and enable the module and its `markdown` dependency.
2. [Configuration](configuration/index.md) — assign Editor.md to a text format
   and tune the toolbar, themes, size, and preview options (field by field),
   including the filters that keep output safe.

## Where it lives in the admin menu

Editor.md adds no standalone settings page. You enable and configure it per text
format at **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`) by choosing **Editor.md** as the format's text
editor.
