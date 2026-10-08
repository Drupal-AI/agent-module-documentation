# Currency Taxonomy — manual setup guide

**Currency Taxonomy** (`currency_taxonomy`) creates a **taxonomy vocabulary of
currencies** — populated with currency ISO codes and their associated countries —
so your content can reference currencies as taxonomy terms. Each term name is in
the format *Currency Name (ISO code)*, where the ISO code is the alphabetic ISO
code of that currency.

This is handy wherever currencies should be available as reference data:
multi‑currency listings, financial content, or a currency selector built on an
entity reference to the vocabulary. The module simply provides the vocabulary and
the terms — the currency terms are reference content, and the module has no
access‑control role.

It depends on core **Taxonomy** and provides **Drush commands** to populate and
manage the vocabulary. Per the project's own notes, **there is no configuration
UI** — once enabled and populated, you reference the terms wherever you need them.
It works on Drupal 8.8 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module together with core Taxonomy.

There is **no configuration page** for this module. You populate the vocabulary
and reference its terms, as described in "How to use it" below.

## Where it lives in the admin menu

The generated vocabulary appears under **Structure → Taxonomy**
(`/admin/structure/taxonomy`), alongside your other vocabularies. You browse and
manage its currency terms there like any taxonomy.

## How to use it

1. Enable the module (see [Installation](installation/index.md)) — this creates
   the currency vocabulary.
2. Populate it with the currency terms using the module's Drush command (run
   `drush list` to see the module's commands if you're unsure of the exact name).
3. Reference the vocabulary where you need currency selection — for example, add a
   **Term reference** field to a content type pointing at the currency vocabulary,
   so editors pick a currency term. Each term carries the currency name and its
   ISO code.
