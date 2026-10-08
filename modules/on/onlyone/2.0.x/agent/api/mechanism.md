# How it works — service, constraint, event, dynamic route

## The `OnlyOne` entity constraint (enforcement)

`onlyone_entity_type_alter()` adds a validation constraint to the `node` entity type:
`$entity_types['node']->addConstraint('OnlyOne')`.

- `Plugin/Validation/Constraint/OnlyOneConstraint` (`@Constraint id "OnlyOne"`, type
  `entity:node`).
- `OnlyOneConstraintValidator` — if the node's type is in `onlyone.settings.onlyone_node_types`
  and a node of that type already exists in the node's language (and it isn't the node being
  updated), it adds a violation on `langcode`. This is what actually blocks a second node.

## The `onlyone` service

`Drupal\onlyone\OnlyOne` (service id `onlyone`, interface `OnlyOneInterface`). Useful methods:

- `existsNodesContentType($type, $language = NULL)` → nid of an existing node of that type in
  the (current or given) language, or `0`. Language-aware only on multilingual sites.
- `deleteContentTypeConfig($type)` → removes a type from `onlyone_node_types`.
- `getContentTypesList()`, `getAvailableContentTypes()`, `getNotAvailableContentTypes()` and
  their `*Summarized()` / `*ForPrint()` variants — "available" = has ≤ 1 node per language.
- `setFormatter(OnlyOnePrintStrategyInterface)` — swap the print formatter (admin page vs.
  drush) for the summary lists.

```php
$nid = \Drupal::service('onlyone')->existsNodesContentType('homepage');
if ($nid) { /* a homepage node already exists */ }
```

## Redirect on add

`onlyone_form_node_form_alter()`: when creating a new node of a restricted type that already
has a node, it issues a `RedirectResponse` to the existing node's edit form
(`entity.node.edit_form`) or canonical (`entity.node.canonical`) per `onlyone_redirect`.

## The event

`Drupal\onlyone\Event\OnlyOneEvents::CONTENT_TYPES_UPDATED` (`'onlyone.content_types_updated'`)
is dispatched by the config form when the restricted-types list changes — the
`onlyone_admin_toolbar` submodule subscribes to rebuild its menu.

## Dynamic "Add content (Only One)" route

When `onlyone_new_menu_entry` is true, `Routing\OnlyOneRoutes::routes()` registers
`onlyone.add_page` at `/onlyone/add`; `Routing\RouteSubscriber` removes it again when the
option is off (route rebuild required — the setting form triggers it).

## No plugin *types* to implement

The module defines a Symfony validation constraint plugin and a service, but no plugin manager
of its own. To hook in, subscribe to `OnlyOneEvents::CONTENT_TYPES_UPDATED` or call the
`onlyone` service.
