# Hierarchy-based breadcrumbs

## Setup

Enable the module — that's the entire configuration.

```
drush en entity_hierarchy_breadcrumb -y
```

Any content entity type that has an `entity_reference_hierarchy` field (see the parent
module) will now get its breadcrumb from that field's tree.

## How it works

- Service `entity_hierarchy.breadcrumb` = `HierarchyBasedBreadcrumbBuilder`, registered with
  tag `breadcrumb_builder` at **priority 10**.
- `applies(RouteMatchInterface)` returns TRUE when: the route is a canonical entity route,
  the route is **not** an admin route (`router.admin_context`), and the entity has a field of
  type `entity_reference_hierarchy`.
- `build()`:
  1. Gets the entity's `NodeKey` (`entity_hierarchy.nested_set_node_factory`).
  2. Fetches ancestors from the field's nested-set table
     (`entity_hierarchy.nested_set_storage_factory` → `getAncestors()`).
  3. Loads the ancestor entities with access checks
     (`entity_hierarchy.entity_tree_node_mapper`).
  4. Emits a **Home** link followed by root→parent links; attaches cacheability metadata
     from each ancestor so the breadcrumb invalidates when they change.

## Overriding / ordering

It is an ordinary tagged breadcrumb builder. To take precedence, register your own
`breadcrumb_builder` service with a **higher priority** than `10` and return TRUE from
`applies()`. To disable hierarchy breadcrumbs for a route, uninstall the module or provide a
higher-priority builder that handles that route.

There is no settings form and no config; behaviour is entirely driven by which entity types
have a hierarchy field.
