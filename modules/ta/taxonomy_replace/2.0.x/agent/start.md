<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Taxonomy Replace (taxonomy_replace) — agent index

**Replaces all node references to a term with one or more other terms in the same vocabulary, then deletes the old term.**

- **Version:** 2.0.x
- **Core:** ^8 || ^9 || ^10 || ^11
- **Depends on:** taxonomy
- **Route:** `entity.taxonomy_term.replace` (`/taxonomy/term/{taxonomy_term}/replace`) — a **Replace** tab + entity operation.
- **Access:** permission `replace taxonomy terms` **and** `_entity_access: taxonomy_term.delete` on that term.
- **Form:** `TaxonomyReplaceForm` extends `ContentEntityDeleteForm` (confirm + delete); autocomplete limited to the same vocabulary, multiple replacement terms allowed.
- **Service:** `taxonomy_replace.replacer` (`TaxonomyReplaceService`) — finds nodes via `taxonomy_index`, swaps the term on the reference field, saves, logs.
- **Drush:** `taxonomy:replace <oldTid> <newTid> [--delete]` (note: known argument bug in this branch).

**Security:** UI is correctly gated (permission + per-term delete access); DB queries use bound conditions (no raw SQL concatenation). Action is destructive by design (re-saves affected nodes, deletes the source term).

See [drush/replace.md](drush/replace.md)
