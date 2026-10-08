# Flat Taxonomy — manual setup guide

**Flat Taxonomy** (`flat_taxonomy`) adds a single **Flat taxonomy** checkbox to a
vocabulary's settings that forces the whole vocabulary to stay **flat** — terms can
be reordered, but they can never be nested under a parent. It's a small guardrail for
site builders who want a "Tags" or "Categories" list to remain a single level, no
matter what editors (or a migration) try to do.

Once you tick the box, the module enforces flatness everywhere it matters: the term
add/edit form hides the **parent** field (and rejects a parent if one is submitted),
the **Add child** operation disappears from the term overview, and the overview's
drag‑and‑drop is stripped of its indent/nesting behaviour so you can still reorder
terms but not turn them into sub‑terms. If a term is ever saved with a parent
programmatically — through a migration, REST, or custom code — a presave hook quietly
resets the parent back to the root and logs a warning. Ticking the box on a vocabulary
that already has nested terms flattens the existing terms immediately.

There is no settings page, no permissions, and no Drush command — the entire feature
is the per‑vocabulary checkbox plus the enforcement hooks behind it. The flat flag is
stored as a third‑party setting on the vocabulary's config entity, so it travels with
your exported configuration. The module works on core's Taxonomy and adds a
`hook_requirements()` warning if both it and Hierarchy Manager are set to manage the
same vocabulary.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.

## How to use it

There is no central settings page — flatness is a per‑vocabulary flag you set on the
vocabulary itself:

1. Go to **Structure → Taxonomy**, then edit the vocabulary you want to keep flat
   (**Structure → Taxonomy → *your vocabulary* → Edit**).
2. Tick **Flat taxonomy** — the help text reads *"If checked, the taxonomy will be
   flat, terms can be ordered but can't be nested."*
3. **Save**. If the vocabulary already contained nested terms, they are flattened
   (moved up to the root) right away.

From then on, the parent field is hidden on that vocabulary's term form, the *Add
child* link is gone from its term overview, and editors can drag terms up and down to
reorder them but can no longer indent one under another. To undo it, edit the
vocabulary again and untick the box — the flat setting is removed and normal hierarchy
is allowed once more.
