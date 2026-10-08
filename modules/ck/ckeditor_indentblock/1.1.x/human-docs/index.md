# CKEditor IndentBlock — manual setup guide

**CKEditor IndentBlock** (`ckeditor_indentblock`) lets editors indent and outdent
whole paragraphs — block-level indentation — in Drupal's CKEditor 5 editor, not
just list items. It reuses the standard **Indent** and **Outdent** toolbar
buttons and applies clean CSS classes (`Indent1` through `Indent10`) to the
paragraph instead of inline `margin` styles, which keeps your markup tidy and
easy to theme.

The module adds a single CKEditor 5 plugin that switches on CKEditor's built-in
`IndentBlock` feature. It ships **no toolbar button of its own** — it piggybacks
on core's Indent/Outdent buttons, so paragraph indentation only works once those
buttons are in a text format's toolbar. When active, clicking Indent adds an
`Indent1`…`Indent10` class to the paragraph (up to ten depths via successive
clicks); a bundled CSS library renders those classes both in the editor and on
the front end.

Everything is configured **per text format** at **Configuration → Content
authoring → Text formats and editors** (`/admin/config/content/formats`) — there
is no global settings page. Each format gets an **Indent block** settings tab with
a single **Enable indentation on paragraphs** checkbox (on by default). You can
therefore turn class-based paragraph indentation on for Full HTML while leaving
Basic HTML plain.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — turn on paragraph indentation for a
   text format, step by step.

## Where it lives in the admin menu

There's no dedicated settings page. You configure it inside each text format at
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), on the **Indent block** vertical tab of a
CKEditor 5 format's settings. Settings persist on that format's
`editor.editor.<format>` config.

## How to use it

Once enabled and configured (see [Configuration](configuration/index.md)),
editors use the familiar **Indent** and **Outdent** toolbar buttons: place the
cursor in a paragraph and click Indent to step it in, Outdent to step it back.
Successive clicks add deeper indent levels (up to `Indent10`). This is handy for
tiered body copy, legal/policy clauses and sub-clauses, blockquote-like offset
paragraphs, or outline-style content — all with clean, themeable CSS classes.
