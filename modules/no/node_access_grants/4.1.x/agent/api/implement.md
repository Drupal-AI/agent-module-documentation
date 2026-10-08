<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Implementing grants with a tagged service

The whole module is one interface plus a collector. You get into the node-access
grants system by **registering a tagged service** instead of implementing the two
procedural hooks yourself.

## The mechanism (what the module actually does)

- `node_access_grants.module` implements exactly two core hooks and forwards each to
  the collection service:
  - `hook_node_grants($account, $op)` → `node_access_grants.collection`→`grants($account, $op)`.
  - `hook_node_access_records(NodeInterface $node)` → `…collection`→`accessRecords($node)`.
- `node_access_grants.services.yml` declares `node_access_grants.collection`
  (`Drupal\node_access_grants\NodeAccessGrantsCollection`) with a **`service_collector`**
  tag: `{ name: service_collector, tag: node_access_grants, call: addImplementation }`.
  At container-build time every service tagged `node_access_grants` is passed to
  `addImplementation()` and stored in an array.
- `NodeAccessGrantsCollection::grants()` / `::accessRecords()` iterate those
  implementations and **`array_merge`** their return values
  (`src/NodeAccessGrantsCollection.php:39-46` and `:52-59`). No filtering, no dedup, no
  priority resolution of its own — it returns exactly the concatenation of what your
  implementations return, in service-collection order.

So the module changes **who writes the code** (an OOP service), not **what the arrays
mean**. Core still consumes the merged arrays with its normal OR-combining grant
semantics.

## Step 1 — depend on the module

In your module's `.info.yml`:

```yaml
dependencies:
  - node_access_grants:node_access_grants
```

## Step 2 — implement the interface

`Drupal\node_access_grants\NodeAccessGrantsInterface` (`src/NodeAccessGrantsInterface.php`)
has two methods that mirror the two hooks 1:1:

```php
namespace Drupal\my_module;

use Drupal\Core\Session\AccountInterface;
use Drupal\node\NodeInterface;
use Drupal\node_access_grants\NodeAccessGrantsInterface;

class MyGrants implements NodeAccessGrantsInterface {

  // === hook_node_access_records() ===
  // Return the access records to WRITE for this node (the {node_access} rows).
  public function accessRecords(NodeInterface $node) {
    if ($node->bundle() !== 'article') {
      return [];               // return [] to say "nothing to add for this node"
    }
    return [[
      'realm'        => 'my_module_realm',   // your realm name (namespace it)
      'gid'          => 1,                    // grant id — meaningful only within the realm
      'grant_view'   => 1,
      'grant_update' => 0,
      'grant_delete' => 0,
      'priority'     => 0,                    // optional; see "priority" below
      // 'langcode'   => $node->language()->getId(),  // optional, for translations
    ]];
  }

  // === hook_node_grants() ===
  // Return the (realm => [gid, gid, …]) grants this ACCOUNT holds for $op.
  // $op is one of 'view', 'update', 'delete'.
  public function grants(AccountInterface $account, $op) {
    if ($op === 'view' && $account->hasPermission('access content')) {
      return ['my_module_realm' => [1]];   // matches gid 1 in that realm
    }
    return [];
  }
}
```

Both methods **must return an array** (return `[]` when they have nothing to add) —
`accessRecords()` output is `array_merge`d into the record list, `grants()` output into
the grants map. Returning a non-array will break the merge.

## Step 3 — register and tag the service

In `my_module.services.yml`:

```yaml
services:
  my_module.my_grants:
    class: 'Drupal\my_module\MyGrants'
    tags:
      - { name: node_access_grants }
```

The tag is all that's needed — the collector finds it automatically. Constructor
injection works as normal (add `arguments:`), so you can inject entity/config/current-user
services into your grants class.

## Step 4 — rebuild node access

Access records are written to the `{node_access}` table by core, not on the fly. After
adding/changing implementations you must rebuild so existing nodes get new records:

```bash
drush php:eval 'node_access_rebuild();'   # or Reports → Status report → "Rebuild permissions"
```

Until the rebuild finishes, node **listings, views and search are computed from stale
records** — content can be wrongly visible or wrongly hidden in listings during that
window. New/updated nodes get fresh records on save via the two hooks.

## Grant semantics you still own (the module does not change these)

- **Grants are OR-combined across every module and realm.** If *any* record grants
  `view` to a gid the user holds, the user can view — another module's grant cannot be
  revoked by yours, and yours cannot be revoked by another. There is no "deny". A single
  over-broad record (e.g. a realm every account matches, granting `grant_view = 1`) is a
  silent read-access bypass. Scope realms/gids tightly and grant to the narrowest set of
  accounts.
- **Empty grants for a `$op` means "no opinion", not "deny".** Returning `[]` from
  `grants()` just contributes nothing; access can still be granted by another module or by
  core's own `node` grant realm (`node`/`all`) when node access modules are otherwise
  absent for that op.
- **`priority`** in a record: if any record for a `(realm)` sets a higher priority, only
  the highest-priority records are honored for that node — use it only when you must
  suppress lower-priority realms; leave it `0` otherwise.
- **`$op` is only `view` / `update` / `delete`.** There is no `create` here; grants govern
  access to existing nodes.
- **Test what must NOT be visible.** The failure mode is over-disclosure that no happy-path
  test catches — assert that an unprivileged/anonymous account is *denied*.

## Files

- `src/NodeAccessGrantsInterface.php` — the interface (two methods).
- `src/NodeAccessGrantsCollection.php` — the collector; `array_merge`s all
  implementations (`:39-46`, `:52-59`).
- `node_access_grants.services.yml` — the `service_collector` wiring.
- `node_access_grants.module` — the two hook forwarders.
