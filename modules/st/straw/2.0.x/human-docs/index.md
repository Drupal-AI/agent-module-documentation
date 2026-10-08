# Super Term Reference Autocomplete Widget (Straw) — manual setup guide

**Straw** (`straw`) is a smarter autocomplete for taxonomy term-reference
fields. Where Drupal's standard term autocomplete only shows and searches the
term's own name, Straw shows and searches the **whole hierarchy**: each selected
term is displayed together with its full parent path, joined by `>>` — for
example `Travel >> Europe >> France`. That makes it easy to tell apart terms
that share a name but live under different parents (two "Paris" terms, say), and
it keeps a deep vocabulary usable in a field without a giant select list.

It also speeds up tagging. If the field is allowed to create new terms, an editor
can type a path like `Travel >> Tourist Destinations` and Straw creates every
missing term in that chain, parenting each one to the term before it — reusing
any ancestors that already exist rather than duplicating them. This keeps new
terms placed correctly in the hierarchy instead of piling up at the top level.

Straw is configured **per field**, not from a global settings page — there is no
admin screen for it. Turning it on for a field is a two-step change (choose a
reference method on the field, and a matching widget on the form display),
described below. It needs only core Taxonomy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere of its own — Straw has no settings page and no permissions. You enable
it per field through Drupal's normal field configuration screens.

## How to use it

Straw needs **two** settings on an existing entity-reference field that targets
**taxonomy terms**. Both must be in place for it to work.

1. **Set the field's reference method.** On the field's settings
   (**Manage fields → the field → Field settings / Reference type**), choose
   **Straw selection** as the reference method / selection handler. This is what
   feeds hierarchy-aware matches into the autocomplete. If you want editors to be
   able to create new terms with the `>>` syntax, also turn on the field's
   "Create referenced entities if they don't already exist" option.
2. **Set the form widget.** On the bundle's **Manage form display**, change the
   field's widget to **Autocomplete (Straw style)**. This renders the values with
   their full `>>` ancestry and drives the create-on-the-fly behaviour.

Once both are set:

- Existing values display as their full path, e.g. `Travel >> Europe >> France`.
- The autocomplete searches the entire hierarchy, so same-named terms are
  disambiguated by their parents.
- If term creation is enabled, typing `Parent >> Child` creates every missing
  term in the path, each parented to the previous one, reusing existing
  ancestors.

This works on any entity-reference field pointing at taxonomy terms (on nodes,
media, users, and so on), including multi-value fields, and you can migrate an
existing term field to Straw by changing just the widget and reference method —
the stored data does not change.
