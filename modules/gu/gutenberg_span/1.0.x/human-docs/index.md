# Gutenberg Span — manual setup guide

**Gutenberg Span** (`gutenberg_span`) adds the ability to wrap a selected piece
of text in a `<span>` tag — with one or more CSS classes — directly inside the
Gutenberg editor. It's a small but genuinely useful gap-filler: Gutenberg has no
built-in way to apply inline `span` styling hooks, and this module supplies it.

Editors highlight a run of text and apply a span, optionally attaching classes,
so designers and themers get a reliable styling hook inside otherwise plain
prose (think highlighted phrases, inline badges, or hooks for JavaScript). It is
purely a content-editing convenience — it inserts `<span>` markup into your
content and has no access-control or data role of its own.

One practical note: because the module writes `<span class="…">` into the stored
markup, make sure the text format used with the Gutenberg editor **allows the
`span` tag and the class attribute** through its filters, or the tag will be
stripped on output.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. The span formatting control
appears in the Gutenberg editor toolbar once the module is enabled; there are no
site-wide settings to fill in.

## How to use it

1. Edit a piece of content on a content type where the Gutenberg editing
   experience is enabled.
2. Select the text you want to wrap, then apply the **span** formatting option
   from the inline formatting controls and add any CSS class(es) you need.
3. Confirm the text format tied to the editor permits `<span>` and its `class`
   attribute so the markup survives to the rendered page.
