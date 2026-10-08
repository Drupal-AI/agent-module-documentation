<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Duplication engine, services, Views field & hooks

## Duplication engine — `duplicate_node.entity.form_builder`

`src/Entity/DuplicateNodeEntityFormBuilder.php` extends core `EntityFormBuilder`.
`getForm($original_entity, 'duplicate_node')`:
1. `$new_node = $original_entity->createDuplicate()` (unsaved in-memory copy); sets `uid` to the
   current user and `created`/`changed`/`revision_timestamp` to `time()`.
2. If `gnode` is enabled, collects the source's group(s) into
   `$form_state_additions['duplicate_node_groups_storage']` for re-linking after save.
3. Computes the bundle's **default status** from a throwaway `node` create.
4. For **each translation**: deep-clones paragraphs (`duplicateParagraphs()`), invokes
   `hook_duplicated_node_alter`, unsets excluded node fields (`exclude.node.<type>`), sets the
   published key to the bundle default unless `duplicate_status` is TRUE, and prepends
   `prefix_for_node_title` to the title.
5. Builds the entity form via the `duplicate_node` form operation (`DuplicateNodeForm`) and
   returns the render array. Resets the address tempstore delta afterward.

`duplicateParagraphs(Node $node)`: for every field whose target type is `paragraph`, replaces
each referenced paragraph with `->createDuplicate()`, unsets excluded paragraph fields
(`excludeParagraphField()` → `exclude.paragraph.<bundle>`), and invokes
`hook_duplicated_node_paragraph_field_alter`. `getConfigSettings()` reads `duplicate_node.settings`.

## Save form — `src/Form/DuplicateNodeForm.php`

`DuplicateNodeForm` extends core `NodeForm`. `actions()` relabels the publish/unpublish buttons
with a "New Duplicate" prefix. `save()`:
- If `layout_builder` is on and `duplicate_layout_block_status` is TRUE and the node has
  `layout_builder__layout`: for each `block_content:` component in each `Section`, loads the inline
  block by UUID, relabels it with `prefix_for_node_title`, clears its id, `enforceIsNew()`, assigns
  a fresh UUID, saves it, and rewrites the component config `id`/`label` to point at the new block.
- Saves the node, logs/messages the creation, re-links stored Group(s) via `addContent`
  (Group 1.x) or `addRelationship` (2.x/3.x), and redirects to the node canonical (or `<front>`).

## `.module` hooks

- `duplicate_node_entity_type_build()` — registers the `duplicate_node` form class on the node
  entity type.
- `duplicate_node_entity_operation()` — adds the Duplicate operation to node rows (gated by
  `_duplicate_node_has_duplicate_permission()`).
- `_duplicate_node_has_duplicate_permission()` — shared access helper (see
  [routes/duplicate.md](../routes/duplicate.md)).
- `duplicate_node_form_alter()` — when duplicating a Content-Moderation-moderated node, moves
  `moderation_state` into the form footer.
- `duplicate_node_help()` — renders `README.md` on the module help page (via the `markdown`
  filter when available).

## Alter hooks (`duplicate_node.api.php`)

- `hook_duplicated_node_alter(NodeInterface &$node)` — mutate the duplicate before form build.
- `hook_duplicated_node_paragraph_field_alter(Paragraph &$paragraph, $pfield_name, $pfield_settings)`.

## Node finder — `duplicate_node.node_finder`

`src/DuplicateNodeFinder.php`: derives the source node from the current
`/duplicate/{nid}/duplicate_node` request URI. `currentPathIsValidDuplicatePath()` validates the
`duplicate/*/duplicate_node` shape; `findNodeFromCurrentPath()` / `findNodeFromPath()` resolve the
node (alias-aware via `path_alias.manager`) and load it through `entity_type.manager`.
`getLinksByType()` returns an entity type's link templates.

## Address subscriber — `duplicate_node.address_event_subscriber`

`src/EventSubscriber/AddressEventSubscriber.php`: only subscribes when the `address` module's
`AddressEvents::INITIAL_VALUES` exists. On that event, `getInitialValues()` reads the source node
(via the finder) and returns the address field values at the current delta (tracked in the
`duplicate_node` private tempstore, incremented per field), so Address fields keep their values on
the duplicate form. `onInitialValues()` sets them on the event.

## Views field — `duplicate_node_link`

`duplicate_node.views.inc` (`hook_views_data_alter`) registers a `node.duplicate_link` field
handled by `src/Plugin/views/field/DuplicateLink.php` (`@ViewsField("duplicate_node_link")`,
extends `FieldPluginBase`). `query()` is a no-op; `render()` builds a link to
`duplicate_node.node.duplicate_node` for the row's node and returns `''` unless `$url->access()`
passes (so the link honors the module's access check). A configurable "Text to display" option
defaults to "Duplicate".
