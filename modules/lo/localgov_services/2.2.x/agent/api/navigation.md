# Service-navigation mechanism (how content joins a service tree)

The shared navigation is implemented by the **`localgov_services_navigation`** submodule (documented here
because it is the integration surface other content types plug into; enable it with
`drush en localgov_services_navigation -y`). The top-level module only installs the node types, menu and
pathauto patterns that this mechanism drives.

## The parent reference field

- Field storage `node.localgov_services_parent` — `entity_reference` to `node`, cardinality 1,
  `translatable: true`. Any node bundle that adds an instance of this field becomes attachable to a service.
- The service node types (page, sub-landing, status) each ship a `localgov_services_parent` field instance
  configured to use the selection handler below; other LocalGov modules (directories, guides, step-by-step)
  add the same field to opt their content into a service section.

## The `localgov_services` selection handler

- `@EntityReferenceSelection` id `localgov_services`, class
  `Drupal\localgov_services_navigation\Plugin\EntityReferenceSelection\ServicesSelection`, group `localgov_services`.
- Offers **landing** and **sub-landing** nodes as parents (its settings form checkboxes are hard-coded to
  `localgov_services_landing` + `localgov_services_sublanding`).
- `getReferenceableEntities()` labels sub-landing options as `Parent landing » Sub-landing` for
  disambiguation; queries filter and sort on both `title` and `localgov_services_parent.entity:node.title`.
- Access is enforced: the query uses `accessCheck(TRUE)`, adds the `node_access` tag, and — when the user
  lacks `bypass node access` and no `node_grants` module is installed — restricts to published nodes.
- `localgov_services_navigation_field_widget_single_element_entity_reference_autocomplete_form_alter()`
  swaps in `EntityReferenceValue::valueCallback` so the autocomplete field shows the parent label correctly.

## Pathauto hierarchy integration

- The `localgov_services_hierarchy` pattern (installed by the top-level module) prefixes a child's alias with
  `[node:localgov_services_parent:entity:url:path]` — so a page's URL nests under its service.
- `localgov_services_navigation_pathauto_pattern_alter()` also lets **any** bundle that merely carries a
  `localgov_services_parent` field opt in: if the active pattern doesn't already include the parent token,
  the hook prepends `[node:localgov_services_parent:entity:url:path]/` to it.

## Landing-page destinations sync

`localgov_services_navigation_field_config_insert()` / `_delete()` keep the landing type's
`localgov_destinations` entity-reference field's `target_bundles` in step: whenever a
`localgov_services_parent` field instance is added to (or removed from) a node bundle, that bundle is added
to / removed from the bundles a landing page may point to.

## Child-reorder UI

`Drupal\localgov_services_navigation\EntityChildRelationshipUi` (invoked from
`hook_entity_extra_field_info()` and `hook_form_alter()`) adds a "child pages" pseudo-field and drag-and-drop
weighting UI to landing/sub-landing node forms, letting editors order the children shown in navigation.

## Attaching your own content type to a service

Add a `localgov_services_parent` field instance to your bundle using the selection handler, e.g. in config
`field.field.node.<bundle>.localgov_services_parent.yml`:

```yaml
field_type: entity_reference
settings:
  handler: 'localgov_services'
  handler_settings:
    target_bundles:
      localgov_services_landing: localgov_services_landing
      localgov_services_sublanding: localgov_services_sublanding
```

The pathauto opt-in, destinations sync and child-listing then apply automatically.
