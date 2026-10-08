# Taxonomies Fast Import — manual setup guide

**Taxonomies Fast Import** (`taxonomy_fast_import`, the module is named
"Taxonomies Fast Import") gives you a simple screen for bulk‑loading taxonomy
terms into a vocabulary — including nested, multi‑level terms — instead of adding
them one at a time through the usual term form. You paste a plain list of terms
into a text area, choose or create the target vocabulary, and the module creates
them all in a batch.

The nesting rule is deliberately simple: one term per line, and each leading
`-` marks a level of depth. So a list like `Bird`, then `- Crow`, then
`-- Black crow`, then `--- Black crow with red eyes` creates a four‑level branch.
You can point the import at an existing vocabulary or create a brand‑new one
right on the form. The screen can also **delete** terms — load a vocabulary and
its terms are listed as `id|name`; remove the lines you no longer want, tick the
**Overwrite** option, and import to apply the deletions.

Because it creates and can delete taxonomy content, bulk term import is an
editorial/administrative action — the module provides its own permission, so
grant it only to trusted users. It depends on core **Taxonomy**, needs nothing
outside Drupal core, sits in the *Taxonomy* package, and supports Drupal 10 and
11. Note that this module is not covered by Drupal's security advisory policy.

This guide is written for a **human** setting the site up through the admin UI.
If you are an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The import screen is at **Structure → Taxonomies Fast Import**
(`/admin/structure/quick_import`).

## How to use it

1. Go to **Structure → Taxonomies Fast Import** (`/admin/structure/quick_import`).
2. Choose the target **vocabulary** from the *Vocabularies* select. If the
   vocabulary does not exist yet, fill in the **Name** and **System Name**
   fields and press **Create** — the new vocabulary then appears in the select.
3. Paste your list of terms into the text area, following the format: **one term
   per line**, with a leading **`-`** for each level of depth (`-` for a child,
   `--` for a grandchild, and so on).
4. Press **Submit Import**. The module runs a batch that creates the terms.

To remove terms instead, load the vocabulary so its existing terms are listed as
`id|name`, delete the lines for the terms you want gone, select the
**Overwrite** option, and import.
