# Facets Missing Merge — manual setup guide

**Facets Missing Merge** (`facets_missing_merge`) provides a
[Facets](https://www.drupal.org/project/facets) processor that folds the
**"missing"** facet item into an existing facet value. When a facet has its
"missing" option enabled, Facets adds an extra item (with a configurable title such
as "None") to collect all results that have no value for the faceted field. This
processor lets you merge that "missing" bucket onto a real facet item instead of
showing it as a separate option.

For example, a facet listing *Cat*, *Dog*, *Lizard* with the missing option
enabled becomes *Cat*, *Dog*, *Lizard*, *None*. With this processor you can merge
*None* onto, say, *Cat*, so the list reads *Cat*, *Dog*, *Lizard* again — and
choosing *Cat* now also returns the results that had no value. It is a tidy way to
give a sensible default home to un‑valued content rather than exposing a bare
"None" entry.

It is a facet presentation/aggregation helper with no access‑control role — it
only shapes how the facet displays and groups its items.

**Important ordering note:** when you enable this processor on a facet, make sure
it runs **before the URL processor** in the build phase, because it modifies the
missing filters on a facet item. See the configuration note in "How to use it".

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Facets dependency.

There is **no configuration page** for this module — you enable and order the
processor on each facet, described in "How to use it" below.

## Where it lives in the admin menu

Facets Missing Merge adds no admin page of its own. You configure it from the
**Facets** admin UI (**Configuration → Search and metadata → Facets**,
`/admin/config/search/facets`) when editing an individual facet.

## How to use it

1. Edit the facet at **Configuration → Search and metadata → Facets** and make sure
   its **"missing"** option is enabled (this is what creates the item to merge).
2. In the facet's **processors**, enable the **Missing Merge** processor and choose
   the target facet item that the missing item should merge into.
3. Order the processor so it executes **before the URL processor** in the build
   phase — this is required, because the processor modifies the missing filters on
   the facet item.
4. Save, then load the page with the facet and confirm the "None"/missing item no
   longer appears separately and its results are folded into your chosen target.
