# Fuzzy Term Merge — manual setup guide

**Fuzzy Term Merge** (`fuzzy_term_merge`) helps you clean up near‑duplicate
taxonomy terms. Vocabularies drift over time — "Aluminium" vs "Aluminum",
"T‑Shirt" vs "Tshirt" — and those duplicates fragment content, break faceted
search, and skew reporting. This module uses fuzzy string matching to surface the
likely duplicates in a vocabulary, then walks you through a short wizard to review
and merge them.

Matching is path‑aware. Every candidate pair is scored on two axes and blended
into one match score: a **leaf %** (name similarity) and a **path %** (how much of
the two terms' taxonomy ancestry overlaps). Because it compares across the whole
vocabulary, the same name in two different branches — "Apple" under *Fruit* vs
*Company* — is still surfaced but flagged with a low path score, which is the
signal that tells a genuine duplicate apart from a homonym. Each term shows its
hierarchy breadcrumb and a usage count across all entity‑reference fields (nodes,
products, paragraphs, media, and so on) to help you decide which term to keep.

The actual merge is performed by the **Term Merge** module, which this module
builds on. Children of a merged‑away term are re‑parented onto the surviving term
so no subtrees are orphaned, and you can optionally prune parent terms left empty
by the merge — opt‑in, with a preview of exactly what will be removed.

> **This is a destructive operation. Merges are permanent — there is no undo.**
> Merging rewrites entity references from one term to another and can delete
> terms. **Back up your database before running it on production**, and start on a
> copy if you can. The module is a `1.0.0-alpha3` and not covered by security
> advisories, which is another reason to rehearse the merge on a non‑production
> environment first.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer alongside Term
   Merge, enable it, and grant the merge permission.

There is **no global settings page**. The tool lives as a per‑vocabulary wizard
tab, and its thresholds are set right inside that wizard — described in "How to
use it" below.

## Where it lives in the admin menu

Once enabled, a **Fuzzy merge** tab appears on each vocabulary's admin page under
**Structure → Taxonomy → *(vocabulary)***. The merge itself requires the
**merge taxonomy terms** permission, which is defined by the Term Merge module and
managed at **People → Permissions**.

## How to use it

The wizard has three steps: analyse → choose a merge direction per pair →
confirm & execute.

1. Back up your database first — merges cannot be undone.
2. Go to **Structure → Taxonomy → *(your vocabulary)*** and open the **Fuzzy
   merge** tab.
3. Set the **similarity threshold** and **minimum term length**, then run the
   analysis. Results load via AJAX with no page reload; expand any pair to see the
   leaf/path score breakdown, the hierarchy breadcrumb, and usage counts.
4. For each pair you want to merge, choose which term survives (the direction),
   then continue to the confirmation step. If you opt to prune now‑empty parent
   terms, review the preview of what will be removed.
5. Confirm to execute. Large vocabularies are processed in batches, and the merge
   handles multilingual terms with a fallback to the default translation.

A Drush command (`ftm-tfd`) is also available for command‑line audits of a
vocabulary.
