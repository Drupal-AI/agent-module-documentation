# Language Display — manual setup guide

**Language Display** (`language_display`) adds two **field formatters** for the core
language field that let you surface language information about translated content in
the rendered display. Where core's own language formatter always shows the
*current* language of the content, this module can show:

- the **original (source) language** the content was authored in, and
- the original language **together with a count of how many translations exist**.

That's useful on multilingual sites that want to tell visitors — or editors
reviewing content — which language a piece was written in and how widely it's been
translated, rather than baking that logic into a theme.

To make the original‑language display work correctly, the module also swaps in its
own **node view builder** (`LanguageDisplayNodeViewBuilder`) in place of core's,
working around a long‑standing core issue. Styling comes from a small CSS library
the module provides. It depends only on core's **Language** module.

A note on status: this is an **alpha release** (2.1.0‑alpha1), and its README notes
that the language formatter behaviour was historically hard‑coded in core and
references a core patch. Verify it behaves as expected on your specific core version
before relying on it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no settings page** for this module. You configure it per field on the
entity's *Manage display* screen — see "How to use it" below.

## How to use it

1. Make sure the entity you're working with is **translatable** and has a language
   field to display.
2. Go to the entity's **Manage display** — for a content type that's **Structure →
   Content types → *(type)* → Manage display** — and choose the view mode you want
   to affect (Default, Teaser, etc.).
3. For the relevant field, set its **format** to one of the module's formatters:
   - **Original language** — shows the source language the content was authored in.
   - **Original language with translation counter** — the same, plus a count of the
     available translations.
4. Save the display. The chosen language information now appears wherever that view
   mode is rendered. The module's CSS library styles the output.
