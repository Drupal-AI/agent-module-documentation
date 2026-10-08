# Locale Translation Context — manual setup guide

**Locale Translation Context** (`locale_translation_context`) adds **context
filtering** to Drupal's interface‑translation screens — something core supports
under the hood but never exposes to translators.

Gettext contexts exist because one English word is often several different words
in another language. "Order" is a sequence and a purchase; "Post" is a verb, a
noun, and a piece of mail; "Right" is a direction and an entitlement. Drupal
supports this properly in code —
`t('Order', [], ['context' => 'Commerce order'])` — but then gives the translator
no way to *see* or *filter by* that context in the translation UI. A translator
searching for "Order" gets every occurrence undifferentiated and ends up picking
one meaning for all of them, so the site reads oddly in one language for reasons
nobody can find (because the English source looks correct). This module turns that
unanswerable question into a normal one: show me the strings in this context,
translate them together, move on.

Two things are worth knowing up front:

- **Context is set by the developer, not the translator.** The filter exposes what
  already exists in the code; it cannot create contexts. A site whose custom code
  calls `t()` without contexts on ambiguous words cannot be fixed from this
  screen. Also, *adding* a context to an existing string makes it a **new** string
  that needs translating again.
- **`.po` files carry contexts** as `msgctxt`, so an import/export round‑trip
  preserves them — handy when translation happens outside Drupal and comes back as
  files.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no settings form**. The module enhances existing core screens rather
than adding a configuration page — see "Where it lives" below.

## Where it lives in the admin menu

The module adds its filtering to two existing core screens under **Configuration
→ Regional and language → User interface translation**:

- **Translate** — adds a filter so you can narrow the list of strings by
  translation context.
- **Export** — lets you export the strings for a specific context.

## How to use it

1. Go to **Configuration → Regional and language → User interface translation →
   Translate**.
2. Use the new **context** filter to show only the strings in the context you care
   about (for example a custom project's context, or `Commerce order`), then
   translate them together.
3. To hand a single context off for external translation, use the **Export**
   screen's context option to export just those strings as a `.po` file; the
   contexts are preserved on re‑import.
