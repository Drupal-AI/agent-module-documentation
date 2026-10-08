# Footnotes — manual setup guide

**Footnotes** (`footnotes`) lets content editors insert automatically numbered
footnotes into rich text with a single CKEditor 5 toolbar button. At display time a
text‑format filter turns each footnote into a superscript reference link and gathers
all the notes into a numbered list at the foot of the content — or, if you prefer,
into a click‑to‑open dialog or a separate block placed anywhere on the page. It's the
straightforward way to add scholarly, legal, or editorial citations to long‑form
content without writing any HTML by hand.

Three pieces cooperate. A **CKEditor 5 plugin** gives editors the *Footnotes* button
and an insert dialog (with a live preview). A **text‑format filter**
(`filter_footnotes`) does the real work at display time: auto‑numbering, collapsing
duplicate citations into a single shared number, optionally showing notes in a
popup, and building the notes list. And a **Footnotes Group block** (plus a
"footnotes" display component) lets you render the collected notes outside the body
— in a sidebar "References" section, for instance.

Importantly, Footnotes has **no global settings page**. You switch it on per **text
format**: enable the filter and add the toolbar button to a format. The module even
ships an optional ready‑made "Footnote" text format and editor so you can start
without configuring one from scratch. It also provides a Search API processor to keep
citation text out of your search index, four overridable Twig templates for the
markup, and a Drush command to migrate content authored with the older 3.x footnote
markup.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the filter internals
and theming hooks — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (and its CKEditor 5 / Editor / Media dependencies).
2. [Configuration](configuration/index.md) — turn footnotes on for a text format,
   tune the filter settings, and optionally move the notes list into a block.

## Where it lives in the admin menu

There's no dedicated settings page. You configure Footnotes on a text format at
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), where you enable the filter and add the toolbar
button. The optional **Footnotes Group** block is placed from **Structure → Block
layout**. The module adds no permissions of its own; it does provide a Drush command
(`footnotes:upgrade-3-to-4`) for migrating legacy content.
