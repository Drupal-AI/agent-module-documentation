<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `route` condition plugin

Class `Drupal\route_condition\Plugin\Condition\RouteCondition` (attribute `#[Condition(id: 'route', label: "Route")]`).
It is a normal `ConditionPluginBase`, so it plugs into anything that uses condition plugins:
the block **Visibility** tab, the Context module, or code calling `plugin.manager.condition`.

## Configuration

Single key, `routes` — a string (textarea, **one route name per line**). Default `''`.

| Syntax | Meaning |
|---|---|
| `entity.node.canonical` | exact route-name match |
| `entity.*.canonical` | `*` is a wildcard, compiled to regex `.*` (matches every entity canonical route) |
| `~user.login` | leading `~` (tilde) **excludes** this route (returns the negated result) |

- Input is lowercased before matching (case-insensitive).
- `\r\n` / `\r` are normalized to `\n`; empty lines are filtered out.
- **Empty `routes` ⇒ `evaluate()` returns TRUE** (matches everywhere).
- Lines are checked in order; the **first** line that matches the current route decides the
  result (`return !$negate;`). If nothing matches, returns FALSE.
- The base class also provides the standard **"Negate the condition"** checkbox
  (`negate`), applied on top of the plugin result.

The current route comes from the injected `current_route_match` service
(`$this->currentRouteMatch->getCurrentRouteMatch()->getRouteName()`).

## Where it is stored (block visibility)

When used on a block, it lives in the block config entity:

```yaml
# block.block.<block_id>
visibility:
  route:
    id: route
    negate: false
    routes: |-
      entity.node.canonical
      entity.*.canonical
```

Read it back: `drush cget block.block.<id> visibility.route`.

## Via the UI

1. Go to *Structure → Block layout*, place or edit a block.
2. Open the **Visibility → Route** vertical tab.
3. Enter route names (one per line); optionally use `*` and `~`. Save.
   (JS summary shows "Restricted to certain routes" / "Not restricted".)

## Programmatic use

```php
/** @var \Drupal\Core\Condition\ConditionManager $manager */
$manager = \Drupal::service('plugin.manager.condition');
/** @var \Drupal\route_condition\Plugin\Condition\RouteCondition $condition */
$condition = $manager->createInstance('route');
$condition->setConfiguration([
  'routes' => "entity.node.canonical\nentity.*.canonical",
  'negate' => FALSE,
]);
$matches = $condition->execute();   // TRUE on any node canonical page
```

`summary()` returns a human string: "Return true on the following routes: …" (or
"Do not return true on the following routes: …" when negated).

## Config schema

`config/schema/route_condition.schema.yml` defines `condition.plugin.route` (extends
`condition.plugin`) with mapping `routes: string`.
