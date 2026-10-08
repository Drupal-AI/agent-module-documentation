# Views Term Hierarchy Weight Field — manual setup guide

**Views Term Hierarchy Weight Field** (`views_term_hierarchy_weight_field`)
solves a specific annoyance: when you build a View of taxonomy terms, there's no
straightforward way to list them in true *tree* order — parents immediately
followed by their own children — the way they appear on the admin term overview
page. This module makes that possible by adding two automatically maintained
fields to every term.

When you enable it, the module adds two integer fields to all your taxonomy
terms:

| Field | Label | What it holds |
|-------|-------|---------------|
| `field_tax_hierarchical_weight` | Hierarchical Weight | The term's position in the flattened, hierarchy‑ordered tree (parents come before children). |
| `field_tax_hierarchical_depth` | Hierarchical Depth | The term's nesting level — top‑level terms are 0, their children 1, and so on. |

Because these are just ordinary entity fields, you expose them in a View of
taxonomy terms and sort ascending on **Hierarchical Weight** to render the
vocabulary in exactly the tree order shown on the admin overview. The **depth**
field lets you indent labels, filter to a single level (say, top‑level terms
only), or group a listing by nesting.

The values look after themselves. They're recalculated automatically — in a
safe, batched job (25 terms at a time) — whenever you add or edit a term, or
reorder the vocabulary with drag‑and‑drop on the overview page, and they're kept
in sync across every language on multilingual sites. There's nothing to
configure.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (it requires core Views and Taxonomy).

## Where it lives in the admin menu

There is no configuration page (`configure` is `null`) and nothing is added to
the admin menu. The module works purely by provisioning the two term fields; you
use them inside the Views UI.

## How to use it

1. Create or edit a View of **Taxonomy terms**.
2. Add the **Hierarchical Weight** field or sort
   (`field_tax_hierarchical_weight`) and set the sort to **ascending** — this
   reproduces the exact order of the admin term overview page.
3. Optionally add **Hierarchical Depth** to indent term labels by their level, or
   add it as a filter (for example, depth = 0 to show only top‑level terms).

Because the two values are plain entity fields, all the normal Views handlers
apply — filter, sort, group, relationship, and REST/JSON export — so you can also
feed hierarchy‑ordered term data to a decoupled front end.

## Refreshing the values

The weights recalculate automatically when you save a term or re‑submit the
taxonomy overview page. There's no Drush command or admin button to force a
rebuild — if you ever need to recompute, just re‑save a term or re‑submit the
overview.
