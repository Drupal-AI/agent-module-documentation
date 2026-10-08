<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Node Boolean (node_boolean) — agent index

Provides one core **Condition plugin** (id `node_boolean`) that evaluates a node's boolean
(checkbox) field values, for use as **block visibility** — or any context that consumes core
condition plugins. In a block's *Visibility* UI, the "Node boolean" tab lists every boolean field
defined on any node bundle; pick one or more, and the block shows depending on whether those fields
are checked on the node being viewed. Version dir **2.x** (installed 2.0.0).

- The plugin, its config keys, the any/all logic, and how to operate it →
  [plugins/condition.md](plugins/condition.md)

## What it actually is

- One plugin: `NodeBoolean` (id **`node_boolean`**, label *"Node boolean"*), in
  `src/Plugin/Condition/NodeBoolean.php`, extending `Drupal\Core\Condition\ConditionPluginBase`
  and implementing `ContainerFactoryPluginInterface`.
- Declares a **required `node` context** (`@ContextDefinition("entity:node", required = TRUE)`).
- It changes only **display** (whether a block/entity governed by conditions is rendered). No new
  entity, no field type, no widget, no formatter.
- **No** settings page (`configure` = null), **no** routes, **no** `*.services.yml`, **no**
  permissions, **no** config schema, **no** `.module`/`.install`, **no** hooks, **no** Drush. Defines
  **no new plugin type** — it implements core's `@Condition` type.

## Dependencies & packaging

- Depends on: nothing declared in `info.yml` (no `dependencies:` key). README notes it relies on core
  **Node**, and the field map only ever covers `node` entities.
- Core: `^8 || ^9 || ^10 || ^11`. Package **Fields**. Composer `drupal/node_boolean`, empty
  `require`. License GPL-2.0-or-later.

## Key facts (real machine names)

- Injected dependency: core service **`entity_field.manager`** (no custom service defined).
- Config keys (stored inside the host block/condition config, not a standalone config object):
  `boolean` = array of selected boolean field machine names (e.g. `field_featured`); `all` = bool
  (evaluate **all** vs **any**). Defaults `boolean: []`, `all: FALSE`.
- Field source: `getBooleanNodeFieldMap()` → `entity_field.manager->getFieldMapByFieldType('boolean')['node']`.
- Evaluation: `evaluate()` → `evaluateAny()` (default) or `evaluateAll()`; reads
  `$node->get($field)->first()->get('value')` guarded by `$fields[$field]['bundles'][$node->getType()]`.
  With `boolean` empty the condition returns TRUE (no-op). Core "Negate the condition" inverts it.
- Tests: `tests/src/Unit/Plugin/Condition/NodeBooleanConditionTest.php` (unit coverage of any/all).

## Nature

Display condition, **not access control** — a block hidden by it is simply not rendered, not
access-protected. Its config form lives only inside admin-gated block/visibility UIs.
