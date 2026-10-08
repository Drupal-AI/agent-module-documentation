# Configure Group Term

No module settings form. Setup happens through the **Group** module's relationship system plus its
permission matrix.

## 1. Enable the relation on a group type

The module registers the `group_term` relation type with a deriver (`GroupTermDeriver`) that creates one
plugin **per taxonomy vocabulary**: `group_term:<vocabulary_id>` (e.g. `group_term:tags`). Each derivative
targets entity type `taxonomy_term`, bundle = that vocabulary, and forces `entity_cardinality = 1` (the
field is shown but disabled in the relation config form — one group per term).

Install it on a group type at *Structure → Group types → (type) → Set available content*
(`admin/group/types/manage/<type>/content`), choosing the "Group term (<vocabulary>)" plugin, or via
Drupal's config / the Group relationship storage. New vocabularies automatically appear as available
relations because `hook_ENTITY_TYPE_insert` (`group_term_taxonomy_vocabulary_insert`) clears the group
relation type definitions.

## 2. Terms overview view, routes, and operations

- Bundled Views view **`group_terms`** (config `views.view.group_terms`) → page display at
  `group/%group/terms`, a "Terms" menu tab. Lists the group's related terms (name, tid, updated,
  operations). Its access plugin requires the group permission `access group_term overview`.
- `group_term_entity_operation()` adds a **Terms** operation link to each group entity for users with
  `access group_term overview` (requires `views`, and the `view.group_terms.page_1` route to exist).
- `RouteSubscriber::alterRoutes()` clones Group's generic relationship pages to friendly paths and
  registers them as `entity.group_relationship.group_term_create_page`
  (`group/{group}/term/create`) and `entity.group_relationship.group_term_add_page`
  (`group/{group}/term/add`), with `base_plugin_id = group_term`.
- Action links (`group_term.links.action.yml`) put **"Create taxonomy term"** and
  **"Relate taxonomy term"** buttons on the terms view.
- `GroupTermOperationProvider` (relation handler, `shared: false`) adds a per-vocabulary
  **"Create <vocabulary>"** group operation to the group collection when the current user has
  `create group_term:<vocab> entity` (per-group) or the global `create any group_term entity`.

See [../permissions/permissions.md](../permissions/permissions.md) for the exact permission names.

## 3. Tokens

`group_term.tokens.inc` adds term tokens exposing the owning group(s):

| Token | Value |
|---|---|
| `[term:group]` | Label of one parent group (the last group relationship for the term). |
| `[term:group:*]` | Chained group tokens (e.g. `[term:group:id]`, `[term:group:url]`), language-aware. |
| `[term:groups]` | Rendered array of all the term's parent group labels (needs contrib `token`). |
| `[term:groups:*]` | Chained array tokens over the parent groups. |

Group relationships for a term are loaded via `group_relationship` storage `loadByEntity($term)`.
