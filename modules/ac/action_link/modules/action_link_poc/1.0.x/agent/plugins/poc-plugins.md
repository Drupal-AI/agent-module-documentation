<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Proof-of-concept plugins & demo route

Demo/reference code (`experimental: true`). Both plugin classes carry the docblock "Proof-of-concept
only, needs more work."

## poc_add_to_cart — `src/Plugin/StateAction/PocAddToCart.php`

`#[StateAction(id: 'poc_add_to_cart', dynamic_parameters: ['entity'], directions: ['add' => 'add',
'remove' => 'remove'])]`, extends `StateActionBase`; injects `state`.
- `getNextStateName()`: reads `state->get('poc_add_to_cart:count', 0)`; `add` → count+1, `remove` →
  count-1 (or NULL at 0).
- `advanceState()`: `state->set('poc_add_to_cart:count', $state)` — a single **global** counter, not
  per-user or per-product.
- `getLinkLabel()` / `getMessage()`: count-aware labels ("Add to cart (@count in cart)").
- `getActionRoute()`: sets `entity` parameter type to `entity:node` (`@todo` from config).

## poc_subscribe — `src/Plugin/StateAction/PocSubscribe.php`

`#[StateAction(id: 'poc_subscribe', dynamic_parameters: ['entity_type', 'entity_id'], directions:
['toggle' => 'toggle'], states: ['sub', 'unsub'])]`, extends `StateActionBase`, uses
`ToggleGeometryTrait`, implements `ConfigurableInterface` + `PluginFormInterface`; injects
`entity_type.manager`, `state`. Two dynamic parameters because it needs the entity type id and id in
the path (`@todo` collapse via a route enhancer).
- `getNextStateName()`: reads `state->get('poc_subscribe:<type>:<id>', 'unsub')` and flips it.
- `advanceState()`: `state->set('poc_subscribe:<type>:<id>', $state)`.
- `buildConfigurationForm()`: just the toggle texts form.

## Demo route — `src/Controller/ActionLinkPocController.php`

`action_link_poc.action_link_poc` → `/action_link_poc`, `_access: 'TRUE'`, `content()`. Loads all
`action_link` entities and, for those whose plugin id is `poc_add_to_cart` or `poc_subscribe`, builds
a link set against **node 1** (`->load(1)`; comment says "Assume node 1 exists!"). This is a
read-only rendering page — it displays links; performing an action still goes through the core
`ActionLinkController` action route and its access check.

## Caveats for reuse

These plugins are intentionally minimal: access hooks are placeholder overrides and state is stored
globally in `\Drupal::state()`. When copying them into real code, implement genuine operand access
checks and per-user/per-product storage, and make the target entity type configurable rather than
node-only.
