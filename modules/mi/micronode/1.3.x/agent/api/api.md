# API — helpers, plugins, alters

## Helper functions (`micronode.module`, procedural)

- `micronode_get_node_types($return_microcontent = NULL): NodeTypeInterface[]` — content types keyed by
  id. `TRUE` = only micro-content types, `FALSE` = only non-micro-content types, `NULL` = all. Result
  is cached in `cache.default` (cid `micronode_get_node_types:{TRUE|FALSE|NULL}`, tag
  `config:node_type_list`).
- `micronode_is_micro_content(NodeInterface $node): bool` — whether the node's type is flagged.

Note: types whose flag was never set (NULL, e.g. pre-existing types not re-saved) are treated as
non-micro-content by these helpers.

## Hooks it implements (via `Hook\MicronodeHooks`, autowired)

- `hook_form_node_type_form_alter` — adds the Micro-content settings tab (see
  [configure/microcontent.md](../configure/microcontent.md)).
- `hook_ENTITY_TYPE_access` (`node`) — the canonical-route hide rule.
- `hook_menu_links_discovered_alter` — regroups `admin_toolbar_tools` add links under
  `micronode.add_microcontent_page`.
- `hook_form_views_exposed_form_alter` — strips disallowed bundles from exposed `bundle` filters when
  a `micronode_is_microcontent` filter is present on the view.
- `hook_views_plugins_wizard_alter` — swaps the `node` Views wizard for
  `Plugin\views\wizard\Micronode` (new node views exclude micro-content by default).
- `hook_element_info_alter` — prepends `MicronodeAutocompleteHelper::disallowMicronodes` to the
  `entity_autocomplete` element `#process`, blocking micro-content from autocompletes unless allowed.
- `hook_views_data_alter` (`micronode.views.inc` → `MicronodeViewsHooks`) — registers the filter.

## Views filter

`Plugin\views\filter\MicronodeIsMicrocontent` (id `micronode_is_microcontent`, a boolean filter) —
include or exclude micro-content nodes in a listing. Config schema
`views.filter_value.micronode_is_microcontent` (boolean).

## Route + access (`micronode.services.yml`)

- `micronode.route_subscriber` (`Routing\MicronodeRouteSubscriber`, priority 95 on ALTER):
  - Repoints `node.add_page` to `Controller\MicronodeController::addPage` (unless `type_tray` present).
  - Adds `micronode.add_microcontent_page` → `/node/add-microcontent`
    (`MicronodeController::addMicrocontentPage`), guarded by requirement
    `_micronode_create_any_access: node` and option `_node_operation_route`.
- `micronode.micronode_create_any` (`Access\MicronodeCreateAnyAccessCheck`, `applies_to`
  `_micronode_create_any_access`) — allows the add-microcontent page if the user can create at least
  one micro-content bundle (or can create new bundles); mirrors core's
  `EntityCreateAnyAccessCheck` but scoped to micro-content types. Cache tags include the node-type
  list cache tags.

## Controller

`Controller\MicronodeController extends NodeController` — `addPage()` removes micro-content types from
the standard add list; `addMicrocontentPage()` removes non-micro-content types, leaving only
micro-content ones.
