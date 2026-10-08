<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Action Link proofs of concept (action_link_poc) — agent index

**Experimental / demo** submodule of **action_link**. Ships proof-of-concept State Action plugins and
a demo page. Depends on `action_link`. No permissions, no config schema. `info.yml` sets
`experimental: true`; classes are documented as "Proof-of-concept only, needs more work."

## What it provides

- **State Action** `poc_add_to_cart` (`src/Plugin/StateAction/PocAddToCart.php`,
  `#[StateAction(dynamic_parameters: ['entity'], directions: ['add','remove'])]`, extends
  `StateActionBase`). A repeatable counter stored in `\Drupal::state()` under `poc_add_to_cart:count`;
  labels reflect the current count. Route entity type hardcoded to `entity:node`.
- **State Action** `poc_subscribe` (`src/Plugin/StateAction/PocSubscribe.php`,
  `#[StateAction(dynamic_parameters: ['entity_type','entity_id'], directions: ['toggle'], states:
  ['sub','unsub'])]`, extends `StateActionBase`, uses `ToggleGeometryTrait`, `ConfigurableInterface`,
  `PluginFormInterface`). State stored in `\Drupal::state()` keyed `poc_subscribe:<type>:<id>`.
- **Controller** `src/Controller/ActionLinkPocController.php`, route
  `action_link_poc.action_link_poc` at `/action_link_poc` (`_access: 'TRUE'`). Read-only page that
  loads all action links, and for those using the two poc plugins builds link sets against **node 1**
  (assumes node 1 exists).

## Status

Demo code. The plugins' `checkStateAccess()` / `checkOperandStateAccess()` are placeholder overrides
and `advanceState()` mutates global `\Drupal::state()` rather than per-user storage — appropriate for
a demonstration, not production. The `/action_link_poc` page only renders links; a click is still
routed through the core `ActionLinkController` and its permission check.

## Solution docs

- `agent/plugins/poc-plugins.md` — the two demo plugins and the demo route.
