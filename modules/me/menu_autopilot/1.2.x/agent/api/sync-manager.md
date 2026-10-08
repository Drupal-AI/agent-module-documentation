<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Autopilot — programmatic API

The work lives in two services (`menu_autopilot.services.yml`). Normally you never call them: menus stay in sync automatically via entity insert/update/delete hooks (`_menu_autopilot_react` routes node saves to `syncNode()` and menu-link saves to `syncParentIfDynamic()`). Call the API directly only for bulk/scripted reconciliation.

Note on node-form saves: a node saved through its edit form is **queued** (`queueNode()`) and reconciled by `flushQueued()` after menu_ui's own submit handler runs, so the module never deletes a managed child that menu_ui still holds. The `menu_autopilot.sync_manager` service is tagged `needs_destruction`, so any queued node still pending at the end of the request is flushed in `destruct()`.

## `menu_autopilot.sync_manager` — `Drupal\menu_autopilot\NavSyncManager`

Constructor args: `@entity_type.manager`, `@config.factory`, `@menu_autopilot.source_resolver`, `@token`. Implements `DestructableInterface`.

Public methods:

- `isSyncing(): bool` — re-entrancy guard; TRUE while a reconcile is writing links (so the child writes it makes don't trigger a nested reconcile).
- `destruct(): void` — flushes any queued node reconciles at request end.
- `queueNode(NodeInterface $node): void` — defer a node's reconcile until after node-form submit handlers.
- `flushQueued(): void` — reconcile every queued node now (called by the node-form flush submit handler and by `destruct()`).
- `syncNode(NodeInterface $node): void` — reconcile every dynamic parent this node can affect (called on node insert/update/delete).
- `syncParentIfDynamic(MenuLinkContentInterface $link): void` — reconcile the link's children if it is a dynamic parent.
- `syncParent(MenuLinkContentInterface $parent): void` — reconcile one specific parent's managed children.
- `reconcile(): void` — reconcile all dynamic parents across the managed menus (what `ma:rebuild` calls). Idempotent, diff-before-write.
- `normalizeNodeUris(?array $menu_names = NULL): array` — rewrite editorial/internal node link URIs to canonical `entity:node/<nid>` (what `ma:fix-uris` calls). Defaults to the managed menus. Returns a map of changed link id => description; empty when nothing changed.
- `managedMenus(): array` — the menu machine names configured as managed.

Example:

```php
$sync = \Drupal::service('menu_autopilot.sync_manager');
$sync->reconcile();
$changed = $sync->normalizeNodeUris();
```

## `menu_autopilot.source_resolver` — `Drupal\menu_autopilot\NavSourceResolver`

Constructor arg: `@entity_type.manager`. Resolves a stored source descriptor (term / bundle / manual) into the ordered set of **published** nodes that should become children. It queries only `status = 1` nodes; menu visibility to a given viewer is then governed by the generated links and the menu tree's own access checks, not by the resolver. Injected into the sync manager; you rarely call it directly.

Note: a dynamic parent's configuration and each managed child's bookkeeping are stored in a single **internal** `menu_autopilot` map base field on `menu_link_content` (installed by `menu_autopilot_install()`; `setInternal(TRUE)`, so it is kept out of JSON:API/REST/GraphQL output). Managed children carry `['managed' => TRUE, 'node' => <nid>]`; dynamic parents carry `['source' => [...]]`. Child link titles are produced by `Token::replacePlain()` (plain text, unreplaced tokens cleared) and child URIs are always `entity:node/<nid>` — URIs are never tokenized.
