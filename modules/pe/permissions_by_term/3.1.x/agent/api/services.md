<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services and the enforcement path

## Services (`permissions_by_term.services.yml`)

| Service id | Class | Use it for |
|---|---|---|
| `permissions_by_term.access_storage` | `Service\AccessStorage` | Read/write grants, resolve permitted tids/nids, build node grant ids. |
| `permissions_by_term.access_check` | `Service\AccessCheck` | "May this user see this node/term?" |
| `permissions_by_term.node_access` | `Service\NodeAccess` | Node access record objects and rebuilds. |
| `permissions_by_term.term_handler` | `Service\TermHandler` | tid ↔ nid lookups, term name ↔ id. |
| `permissions_by_term.node_entity_bundle_info` | `Service\NodeEntityBundleInfo` | The read-only permissions panel on the node form. |
| `permissions_by_term.node_access_record_factory` | `Factory\NodeAccessRecordFactory` | Builds grant value objects. |
| `permissions_by_term.access_result_cache` / `.key_value_cache` | `Cache\*` | Backed by the `permissions_by_term` cache bin (`cache.permissions_by_term`). |
| `permissions_by_term.cache_invalidator` | `Cache\CacheInvalidator` | Invalidate after a grant change. |
| `permissions_by_term.kernel_event_listener` | `Listener\KernelEventListener` | Request-time enforcement (also for term pages / path aliases). |
| `logger.channel.permissions_by_term` | core | Log channel `permissions_by_term`. |

## `AccessStorage` — the main API

```php
$as = \Drupal::service('permissions_by_term.access_storage');

AccessStorage::NODE_ACCESS_REALM;                 // 'permissions_by_term'

// read
$as->getAllTermPermissionsByUserId($uid);
$as->getUserTermPermissionsByTid($tid, $langcode);
$as->getUserTermPermissionsByTids(array $tids, $langcode);
$as->getRoleTermPermissionsByTid($tid, $langcode);
$as->getRoleTermPermissionsByTids(array $tids, $langcode);
$as->getPermittedTids($uid, array $rids);
$as->getAllowedUserIds($tid, $langcode);
$as->getTidsByNid($nid);
$as->getNidsByTid($tid);
$as->getAllNidsUserCanAccess($uid);
$as->getGids(AccountInterface $user);             // what hook_node_grants() returns
$as->getNodeType($nid); $as->getLangCode($nid); $as->getAllNids(); $as->getAllUids();

// write
$as->addTermPermissionsByUserIds(array $uids, string $tid, string $langcode = '');
$as->addTermPermissionsByRoleIds(array $rids, $tid, $langcode = '');
$as->deleteTermPermissionsByUserIds(array $uids, $tid, $langcode);
$as->deleteTermPermissionsByRoleIds(array $rids, $tid, $langcode);
$as->deleteAllTermPermissionsByUserId($uid);
$as->deleteAllTermPermissionsByTid($tid);
$as->deleteAllTermPermissionsByTermBundle(string $vid): void;
$as->saveTermPermissions(FormStateInterface $formState, string $tid);   // used by the term form
```

`$langcode = ''` means "current interface language" — pass the **term's** langcode explicitly when
scripting, or grants will not match at check time.

## `AccessCheck`

```php
$ac = \Drupal::service('permissions_by_term.access_check');

$ac->canUserAccessByNode(Node $node, $uid = FALSE, $langcode = ''): bool;
$ac->isAccessAllowedByDatabase($tid, $uid = FALSE, $langcode = '');
$ac->isTermAllowedByUserRole($tid, $rid, $langcode): bool;
$ac->isAnyPermissionSetForTerm($tid, $langcode = ''): bool;
$ac->isAnyTaxonomyTermFieldDefinedInNodeType(string $nodeType): bool;
$ac->handleNode(Node $node, string $langcode): AccessResult;
$ac->dispatchDeniedEventOnRestricedAccess(Node $node, string $langcode);
```

`canUserAccessByNode()` short-circuits to `TRUE` when the node type has **no** taxonomy reference
field at all, and honours the core permissions `bypass node access`,
`view own unpublished content` and `view any unpublished content` before looking at terms. It
reads the node's terms from `taxonomy_index` (joined against `taxonomy_term_data` when
`target_bundles` is set) and only considers terms whose langcode matches. With
`permission_mode` off and no terms on the node → allowed; with it on → denied unless a term grants.

## Enforcement path (`permissions_by_term.module`)

| Hook | Effect |
|---|---|
| `hook_node_grants()` | Returns `AccessStorage::getGids($account)` in the `permissions_by_term` realm — unless `disable_node_access_records` is on. |
| `hook_node_access_records()` | One grant per restricted node (`gid = nid`), skipped when the node type has no taxonomy field, when the node has no terms (and `permission_mode` off), when no term carries any permission, or when records are disabled. |
| `hook_node_access()` | `AccessCheck::dispatchDeniedEventOnRestricedAccess()` — denies and fires the denied event. |
| `hook_options_list_alter()` | Removes term options the current user may not use from taxonomy reference widgets (respecting `target_bundles`). |
| `permissions_by_term_validate()` (added to **every** form via `hook_form_alter`) | Rejects a submitted taxonomy reference the user is not allowed to use, with the message *"You are not allowed to use taxonomy terms like: …"*. |
| `hook_user_insert` / `hook_user_update` / `hook_node_insert` | Invalidate the module's caches. |
| `hook_theme()` | `permissions_by_term_render_node_details` (template `src/View/node-details.html.twig`). |

## Rebuilding after changes

```php
\Drupal::service('permissions_by_term.node_access')->rebuildAccess($changedTids = []);
\Drupal::service('permissions_by_term.cache_invalidator')->invalidate();
node_access_rebuild(TRUE);   // full core rebuild
```

`hook_install()` and `hook_uninstall()` both call `node_access_rebuild(TRUE)`.

## Requirements warning

`hook_requirements()` warns (severity WARNING) when `dynamic_page_cache` or `page_cache` is not
installed — without dynamic page cache the per-user checks on Views pages cannot run correctly.
