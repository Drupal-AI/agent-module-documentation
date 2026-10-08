# Taxonomy Term Glossary — manual setup guide

**Taxonomy Term Glossary** (`term_glossary`) turns a taxonomy vocabulary into a
site glossary. It scans your rendered content for words that match the terms in
your chosen vocabularies, highlights those matches automatically, and shows the
reader the term's description — in a modal dialog, a tooltip, or as an
abbreviation, depending on how you set it up.

The idea is simple and the payoff is that you maintain definitions in exactly one
place. Instead of manually linking every jargon word every time it appears, you
keep your definitions as taxonomy terms and let the module find and mark up the
matches for you. It works well for explaining medical, legal or technical
vocabulary to a general audience, for documentation sites that want inline
definitions, and for reusing an existing taxonomy as a glossary. There is also a
front‑end block that lets readers browse the glossary alphabetically or search
it.

Under the hood it uses a text filter that wraps matching words, plus a small
JavaScript layer that fetches each definition on demand. Presentation is
pluggable — the module defines its own `TermGlossaryHandler` plugin type — and
three optional submodules give you alternatives to the default dialog:
**term_glossary_abbr** renders matches as HTML `<abbr>` elements (good for
accessibility of acronyms), **term_glossary_tippy** shows definitions as Tippy.js
tooltips, and **term_glossary_per_node** lets editors turn glossary processing on
or off for individual nodes. It depends on core **Taxonomy** and **Text** plus the
**jQuery UI Dialog** module (`jquery_ui_dialog ^2`) for the default dialog, and
supports **Drupal 10.3 and 11**.

The module does **not** highlight anything on‑enable — you must choose your
vocabularies at its settings page and enable glossary processing on the text
fields you want scanned. See [Configuration](configuration/index.md).

> **Security note worth reading before you enable it.** The module exposes three
> JSON endpoints that the front‑end JavaScript uses to fetch definitions, and they
> are gated only by the *access content* permission — effectively anonymous on a
> typical site. According to the module's own security review, all three can
> return **unpublished** taxonomy terms to anonymous visitors, and the
> "get term by id" endpoint (`/glossary-get-term-by-id/{tid}`) additionally
> ignores the configured vocabulary list, so *any* term in *any* vocabulary can be
> retrieved by iterating through term IDs — even though Drupal core itself would
> deny access to those same terms. **Do not enable this module on a site whose
> taxonomy contains non‑public or draft terms without applying a patch to close
> that gap.** If your taxonomy is entirely public, this is not a concern.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and pick the submodules you need.
2. [Configuration](configuration/index.md) — choose your glossary vocabularies,
   pick a presentation, and enable scanning on your text fields.

## Where it lives in the admin menu

The settings form sits at **Configuration → Glossary** (`/admin/config/glossary`,
route `term_glossary.glossary_config_form`). Per‑field scanning is enabled on each
content type's *Manage display* settings, and the alphabetical/search block is
placed through **Structure → Block layout**.
