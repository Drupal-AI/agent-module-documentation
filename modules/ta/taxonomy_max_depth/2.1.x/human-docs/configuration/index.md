# Configuration

Taxonomy Max Depth has no settings page of its own. Instead, the depth limit is a
setting on **each vocabulary**, so you configure it one vocabulary at a time.

## Set a vocabulary's maximum depth

1. Go to **Structure → Taxonomy** (`/admin/structure/taxonomy`).
2. Click **Edit** on the vocabulary you want to cap.
3. Find the **Maximum ancestor depth** select and choose a value:
   - **Unlimited** *(the empty option)* — no restriction; remove any existing cap.
   - **0 (no hierarchy)** — forbid parents entirely, forcing the vocabulary flat.
   - **1**–**10** — the maximum number of ancestor levels a term may have.
4. Save the vocabulary.

The chosen value is stored as a third‑party setting on the vocabulary's
configuration (under `taxonomy_max_depth`), so it is included in your
configuration export and deploys with the rest of your config.

## How the limit is enforced

The cap is applied through the standard term forms:

- When an editor **adds or edits a term**, a validator counts the depth the
  term's newly chosen parents would give it. If that exceeds the vocabulary's cap,
  the save is blocked with an error on the *parent* field.
- For an **existing term**, the validator also looks at the term's children, so
  that **moving a whole subtree** can't push its descendants past the limit — if
  it would, the move is blocked.
- With the limit set to **0**, choosing any parent triggers the error *"Terms are
  not allowed to have ancestors on this vocabulary,"* keeping the vocabulary flat.
- The **term overview** (drag‑and‑drop reorder) screen respects the same limit.

Editors get immediate, in‑form feedback rather than silently creating an
over‑deep tree.

## Turning an existing deep vocabulary flat

If you tighten the limit on a vocabulary that already has terms nested too deep,
the new limit is enforced going forward on the forms — you will need to move or
fix the terms that the validator flags to bring the whole vocabulary within the
new cap.

## A note for developers

Because enforcement lives in the term forms, terms created **programmatically**
via `$term->save()` are not automatically validated against the limit. If you
create terms in code and want the same rule applied, read the vocabulary's
configured limit and check the depth yourself — the module provides a settings
reader/writer service pair and a tree‑depth helper for exactly this (see the
sibling [`agent/`](../agent/start.md) docs for the service names and signatures).
