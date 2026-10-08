<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Node Co-Authors (node_co_authors) — agent index

Adds a single `co_authors` base field to every node (entity reference → `user`, unlimited
cardinality, revisionable) and lets those referenced users act on the node with the *same*
"own content" rights the real author has. The mechanism is two access hooks, no routes, no config
page: `node_co_authors_node_access()` (a `hook_ENTITY_TYPE_access`) grants `update`/`delete`/view-of-
unpublished to a co-author **only by conjoining** co-authorship with the core permission the user
would already need (`edit own <type> content`, `delete own <type> content`,
`view own unpublished content`) — it uses `->andIf($isCoAuthor)`, never `orIf`, and never returns
`forbidden`, so the grant is purely additive and can hand a co-author nothing their role does not
already carry. `node_co_authors_entity_field_access()` gates who may edit the co-author list itself
via three module permissions (plus `administer nodes`).

The field is placed into the node form's `author` group (`hook_form_node_form_alter`) with an
autocomplete-tags widget. The module also registers a Views filter that matches author *or* any
co-author by name, and a `[node:co_authors_email]` token.

- Depends on: `drupal:node` (core). No other dependencies, no external libraries.
- Core: `^9 || ^10 || ^11`. Package: none declared. Version **1.2.3**.
- **No** settings page / `configure` route, **no** services, **no** routes/controllers/forms of its
  own, **no** drush, **no** config schema, and it **defines** no plugin types. It provides 3
  permissions and implements one Views filter plugin.

## What you'd do → where

- **Understand exactly what a co-author can view/edit/delete (the two access hooks + the field)** →
  [api/access-model.md](api/access-model.md)
- **Filter a View by "author or one of the co-authors", or use the co-authors email token** →
  [api/views-and-tokens.md](api/views-and-tokens.md)
- **Decide which role may add/remove co-authors (own / co-authored / all content)** →
  [permissions/permissions.md](permissions/permissions.md)

## Key facts (real machine names)

- Base field: `co_authors` — `entity_reference` to `user`, `CARDINALITY_UNLIMITED`, revisionable;
  form widget `entity_reference_autocomplete_tags` (weight 17, `match_operator` CONTAINS,
  `match_limit` 10), display-configurable on both form and view; view display default region
  `hidden`. Added by `node_co_authors_entity_base_field_info()`.
- Hooks (all in `node_co_authors.module`): `hook_help`, `hook_ENTITY_TYPE_access`
  (`node_co_authors_node_access`), `hook_entity_base_field_info`,
  `hook_form_BASE_FORM_ID_alter` (`node_co_authors_form_node_form_alter`, moves field to `author`
  group), `hook_entity_field_access` (`node_co_authors_entity_field_access`), `hook_views_data`,
  `hook_token_info`, `hook_tokens`.
- Permissions (`node_co_authors.permissions.yml`): `edit co-authors of own content`,
  `edit co-authors of co-authored content`, `edit co-authors of all content`.
- Views: `hook_views_data()` adds filter `author_co_author_name` on `node_field_data` (field `uid`);
  plugin `Drupal\node_co_authors\Plugin\views\filter\AuthorCoAuthorName`
  (`@ViewsFilter("author_co_author_name")`, extends `user`'s `Name` filter).
- Token: `[node:co_authors_email]` (type `array`) — the node's co-authors' email addresses
  (`hook_token_info` / `hook_tokens`).
