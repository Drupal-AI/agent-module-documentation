<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Autopilot — programmatic API

The work lives in two services (`menu_autopilot.services.yml`). Normally you never call them: menus stay in sync automatically via entity insert/update/delete hooks in `menu_autopilot.module` (`_menu_autopilot_react()` routes node saves to `syncNode()` and menu-link saves to `syncParentIfDynamic()`). Call the API directly only for bulk/scripted reconciliation or to read status.

Note on node-form saves: a node saved through its edit form is **queued** (`queueNode()`) and reconciled by `flushQueued()` after menu_ui's own submit handler runs, so the module never deletes a managed child that menu_ui still holds. The `menu_autopilot.sync_manager` service is tagged `needs_destruction`, so any queued node still pending at the end of the request is flushed in `destruct()`.

## `menu_autopilot.sync_manager` — `Drupal\menu_autopilot\NavSyncManager`

Constructor args: `@entity_type.manager`, `@config.factory`, `@menu_autopilot.source_resolver`, `@token`, `@module_handler`, `@current_user`, `@logger.channel.menu_autopilot`. Implements `DestructableInterface`. (The last two args are new in 1.4.x — they drive the disabled-by-save logging and the once-per-account re-enable attempt.)

Public methods:

- `isSyncing(): bool` — re-entrancy guard; TRUE while a reconcile is writing links (so child writes don't trigger a nested reconcile).
- `destruct(): void` — flushes any queued node reconciles at request end.
- `queueNode(NodeInterface $node): void` — defer a node's reconcile until after node-form submit handlers.
- `flushQueued(): void` — reconcile every queued node now (called by the node-form flush submit handler and by `destruct()`).
- `syncNode(NodeInterface $node): void` — reconcile every dynamic parent this node can affect (called on node insert/update/delete).
- `syncParentIfDynamic(MenuLinkContentInterface $link): void` — reconcile the link's children if it is a dynamic parent (skips managed links and `none`/unavailable-term sources).
- `syncParent(MenuLinkContentInterface $parent): void` — reconcile one specific parent's managed children.
- `reconcile(): void` — reconcile all dynamic parents across the managed menus (what `ma:rebuild` and the settings-form save call). Idempotent, diff-before-write.
- `normalizeNodeUris(?array $menu_names = NULL): array` — rewrite editorial/internal node link URIs to canonical `entity:node/<nid>` (what `ma:fix-uris` calls). Defaults to the managed menus. Returns a map of changed link id => "old → new"; empty when nothing changed.
- `managedMenus(): array` — the menu machine names configured as managed (empty list = none; missing = `['main']`).
- `parentStatus(int $max_parents = 50, int $max_listed = 25): array` — **new in 1.4.x.** A bounded, read-only report of dynamic parents in the managed menus: per parent uuid/title/menu/enabled/source_type/existing_children policy and counts of `owned`/`adoptable`/`extra`/`disabled`/`disabled_by_save` children, plus a listed subset of the disabled children (title + node id). Describes what is there now; never resolves the source, never returns a label pattern or a node field value. This is the method the MCP `menu_autopilot_status` tool reads.
- `disabledManagedChildren(?MenuLinkContentInterface $parent = NULL): array` — **new in 1.4.x.** One row per disabled managed child (parent id/title, link id, title, node id, `disabled_by_save`), for a single parent or every dynamic parent. Used by `ma:rebuild` and the parent form.
- `releaseDisabledBySaveFlag(MenuLinkContentInterface $link): void` — drop the `disabled_by_save` flag (the editor chose disabled). Does not save.
- `flagManagedIfParentMoving()`, `clearStaleDisabledBySaveFlag()`, `onParentDeleted()`, `flushPendingManagedDeletes()`, `releaseOwnedChildrenIfSourceCleared()` — internal-lifecycle helpers driven by the entity hooks.

Example:

```php
$sync = \Drupal::service('menu_autopilot.sync_manager');
$sync->reconcile();
$changed = $sync->normalizeNodeUris();
$status = $sync->parentStatus();
```

## `menu_autopilot.source_resolver` — `Drupal\menu_autopilot\NavSourceResolver`

Constructor args: `@entity_type.manager`, `@module_handler`. `resolve(array $source): int[]` maps a stored source descriptor (`term` / `bundle` / `manual`) to the ordered, de-duplicated set of **published** node ids that should become children. It queries only `status = 1` nodes with `accessCheck(FALSE)`; menu visibility to a given viewer is then governed downstream by the generated links and the menu tree's own access checks, not by the resolver. A `term` source returns `[]` when Taxonomy is not installed. Injected into the sync manager; you rarely call it directly.

## Storage / internal fields

A dynamic parent's configuration and each managed child's bookkeeping are stored in a single **internal** `menu_autopilot` map base field on `menu_link_content`, alongside a queryable `menu_autopilot_dynamic` boolean marker (both installed in code by `menu_autopilot_install()` / `_menu_autopilot_install_fields()`; `menu_autopilot_update_10201()` added and backfilled the marker). Both are `setInternal(TRUE)`. Dynamic parents carry `['source' => [...]]`; managed children carry `['managed' => TRUE, 'node' => <nid>]` (plus `disabled_by_save => TRUE` when a sync save left an intended-enabled child disabled). `menu_autopilot_entity_field_access()` forbids `view` and `edit` on both fields for every account, so the module's in-code writes are the only writers; JSON:API/REST/GraphQL neither read nor write them. Child link titles are produced by `Token::replacePlain()` (plain text, unreplaced tokens cleared) and child URIs are always `entity:node/<nid>` — URIs are never tokenized.
