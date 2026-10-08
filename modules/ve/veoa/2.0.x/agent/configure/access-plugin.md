# Configure — the "Entity Operation" Views access plugin

No admin page. Configure it inside a view.

## Set it up

1. Edit a view **page** display whose path contains an entity argument, e.g.
   `node/%node/related`.
2. In the display's **Access** section choose **Entity Operation**
   (`veoa_entity_access_operation`).
3. Set the three options:

| Option | Widget | Example | Meaning |
|---|---|---|---|
| `parameter` | textfield (prefixed `%`) | `node` | The path argument name that holds the entity (the `%node` in `node/%node/edit`). |
| `entity_type` | select of entity types | `node` | Entity type the parameter resolves to. |
| `operation` | textfield | `update` | Operation to check: `view`, `update`, `create`, `delete`, or any custom op. |

4. Save the view.

Config is stored under `views.access.veoa_entity_access_operation` (schema keys
`parameter`, `entity_type`, `operation`).

## What it does at save time

The plugin does **not** check access in `access()` — that method only returns
`isValidConfig()` (all three options set and the entity type exists). The real work is in
`alterRouteDefinition(Route $route)`, run when the view is saved:

```php
$options['parameters'][$parameter]['type'] = 'entity:' . $entity_type; // param upcasting
$route->setRequirement('_entity_access', $entity_type . '.' . $operation);
```

So it (a) makes core upcast the path parameter into a full entity object, and (b) adds the
core `_entity_access` route requirement. From then on Drupal's routing/access system
enforces `<entity_type>.<operation>` access on every request to that view path — honouring
the entity's access handlers and `hook_entity_access`.

## Gotchas

- The `parameter` must actually appear in the display's **path**; otherwise the upcast/
  requirement has nothing to bind to and access won't resolve as intended.
- Because enforcement is a route requirement wired at save time, re-save the view after
  changing any of the three options for the route to be rebuilt.
- This plugin only *adds* an access constraint (entity operation access). It grants no
  permissions and cannot loosen core's own access on the route.
