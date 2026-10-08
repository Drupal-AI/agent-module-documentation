# Taxonomy Term Root — manual setup guide

**Taxonomy Term Root** (`taxonomy_term_root`) adds a computed base field to every
taxonomy term that points at the term's **highest ancestor** — the root term at
the top of its branch in the vocabulary's hierarchy. Given a deeply nested term,
you can reference or filter by its top‑level category directly, without writing
code to walk the parent chain upward each time.

This is handy whenever your vocabulary is a tree and you want to group or filter
content by its broad top‑level category rather than its specific leaf term. Because
the root is exposed as a base field, it is available in **Views** (as a field or a
filter) and to any custom logic, and its value always reflects the current term
hierarchy. The field is derived data — it plays no access‑control role, it simply
tells you which root a term belongs to. The module depends only on core's
**Taxonomy** module.

There is nothing to configure. Once enabled, the root‑term field exists on all
terms automatically; you use it wherever you build listings or logic.

This guide is written for a **human** working through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

The root field is a base field, so it needs no per‑vocabulary setup. The most
common use is in Views: when building a view of taxonomy terms (or content
referencing terms), add the root‑term field to display each term's top‑level
category, or add it as a filter to narrow a listing to everything under one root.
Custom code can read the same field to branch on a term's root category instead of
climbing the parent chain by hand.
