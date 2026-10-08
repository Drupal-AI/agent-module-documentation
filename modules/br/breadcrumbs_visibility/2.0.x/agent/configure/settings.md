# Field, defaults & block-access logic

## The node field

`breadcrumbs_visibility_entity_base_field_info()` adds base field `display_breadcrumbs` to the
`node` entity type: boolean, revisionable, translatable, `setDefaultValue(TRUE)`, form widget
`boolean_checkbox`, view display hidden by default but `setDisplayConfigurable` on both form and
view. On the node edit form (`breadcrumbs_visibility_form_node_form_alter`) it is moved into a
"Page display options" `details` group under the `advanced` sidebar.

## Per-content-type default

`breadcrumbs_visibility_form_node_type_edit_form_alter()` adds a "Default to 'Display
breadcrumbs' on." checkbox (in a "Page display defaults"/"Page display options" group). Saved by
`breadcrumbs_visibility_node_type_edit_form_submit()` to editable config
`breadcrumbs_visibility.content_type.<bundle>`, key `display_breadcrumbs` (schema
`config/schema/breadcrumbs_visibility.schema.yml`, a `config_entity`-typed simple config).
For new nodes (or legacy nodes with an empty value, and not clones) the node form seeds the
checkbox `#default_value` from this config.

## Enforcement (`hook_block_access`)

`breadcrumbs_visibility_block_access(Block $block, $operation, $account)`:
1. Acts only when `$block->getPluginId() == 'system_breadcrumb_block'` and `$operation == 'view'`.
2. Resolves the current node from the route (`node_revision` param — loading the revision when
   it's a string — else the `node` param). Non-node routes → `neutral` (breadcrumbs unaffected on
   Views, taxonomy, etc.).
3. Reads `$node->get('display_breadcrumbs')->value`; if NULL, falls back to
   `config('breadcrumbs_visibility.content_type.'.$node->bundle())->get('display_breadcrumbs')`.
4. Returns `AccessResult::forbiddenIf($display_breadcrumbs == "0")->addCacheableDependency($block)`;
   otherwise `neutral`.

Effect: only the breadcrumb block is hidden, only on node routes, only when the resolved value
is "0". Everything else defers to core/other block visibility settings.

## Install-time behavior

`hook_install` (`breadcrumbs_visibility.install`) backfills `display_breadcrumbs = 1` for
published rows in `node_field_data` and matching `node_field_revision` rows (direct DB updates),
then `module_set_weight('breadcrumbs_visibility', 99)` so it runs after modules like Scheduler.
`breadcrumbs_visibility_clone_node_alter()` sets `$node->cloned_node = TRUE` so a cloned node
keeps the source value instead of re-seeding from the type default.
