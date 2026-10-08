# Page Title Visibility — configuration

No dedicated settings route (`configure` = null). Configuration is two things: a per-node field and a
per-content-type default. All UI is injected into core node forms via `hook_form_*_alter`.

## Permission
`administer page display visibility config` (`restrict access: true`) — required to change either the
per-node checkbox or the per-type default. Users without it see the widget `#disabled` with the
description "Your account does not have permission to set the page title visibility."

## Per-node field
- Base field `display_page_title` (boolean, default `TRUE`, revisionable, translatable) added to every
  node by `page_title_visibility_entity_base_field_info()`.
- Rendered as a checkbox in a "Page display options" details group (advanced/vertical tabs) on the node
  form by `page_title_visibility_form_node_form_alter()`.
- For new/legacy nodes (and not clones), the checkbox default is seeded from the content-type default.

## Per-content-type default
- Stored in config object `page_title_visibility.content_type.<bundle>`, single key
  `display_page_title` (boolean). Schema: `page_title_visibility.content_type.*` in
  `config/schema/page_title_visibility.schema.yml`.
- Edited in a "Page display defaults" section on the node type edit form
  (`page_title_visibility_form_node_type_edit_form_alter()`), saved by an appended submit handler.
- Set via Drush:
  ```bash
  drush config:set page_title_visibility.content_type.page display_page_title 0 -y
  ```

## How the title gets hidden (`hook_preprocess_block`)
1. Return early on routes `entity.node.edit_form`, `entity.node.delete_form`,
   `entity.node.version_history` (title stays visible there).
2. Only acts on the block whose `plugin_id` is `page_title_block`.
3. Resolves the current node (incl. `node_revision`). Hide when the node's `display_page_title` is `"0"`,
   or when it is NULL and the content-type default config is `FALSE`.
4. Hiding = appending the `visually-hidden` class to the block attributes (the `<h1>` remains in markup
   for accessibility/SEO). Non-node routes (views, taxonomy, front page) are unaffected.

## Install behaviour (`hook_install`)
Backfills `display_page_title = 1` for existing published nodes/revisions and sets the module weight to
98 so it runs after modules such as Scheduler.
