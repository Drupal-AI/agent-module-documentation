# Node Authorize Link — API, token flow, tokens

All functions are procedural, in `node_authlink.module`.

## How access is granted (request flow)
1. `hook_node_load` attaches `$node->authkey` (from `node_authlink_nodes`) to every loaded node.
2. Access handlers run `node_authlink_check_authlink($node, $op, $account)`:
   - if `?authkey` is present and equals `$node->authkey`, the bundle's grant list is written to
     `$_SESSION['node_authlink_nodes'][$nid]` (starting a session for anonymous users);
   - access is allowed when `$op` is in that session grant list.
   Once seeded into the session, the visitor keeps the granted ops for that node **without**
   needing the `?authkey` on subsequent requests (until the session ends or the key changes).
3. Enforcement points (all defer to the check above):
   - `NodeAuthlinkNodeAccessControlHandler` — set as node's access handler via
     `hook_entity_type_alter`; short-circuits when `authkey` request param is present.
   - `hook_node_access()` — returns `allowed` on a valid authlink (neutral otherwise).
   - `NodeRevisionAccessCheck` — decorates `access_check.entity`; grants revision routes when the
     node is a non-default revision, bundle enabled, and the authlink checks out.
   - `NodeAuthlinkGroupContentAccessControlHandler` — same layering in front of Group access.

## Key management functions
| Function | Purpose |
|---|---|
| `node_authlink_create($node\|$nid)` | Generate (`sha256(random_bytes(64))` if none) and insert a key row. No-op if bundle disabled (when passed an object). |
| `node_authlink_delete($node\|$nid)` | Delete the node's key row. |
| `node_authlink_load_authkey($nid)` | Return the stored key or NULL. |
| `node_authlink_node_is_enabled($node)` | True if the node's bundle has authlinks enabled. |
| `node_authlink_get_url($node\|$nid, $op='view', $revision_id=null)` | Build a `\Drupal\Core\Url` (absolute) to the node/revision/edit/delete route with `?authkey=<key>`; NULL if no key or unknown op. |
| `node_authlink_get_node_url($node, $op)` | Same as above, returned as a string (used by tokens). |

`$op` maps to routes: `view`/`view revision` → `entity.node.canonical` or `entity.node.revision`;
`update` → `entity.node.edit_form`; `delete` → `entity.node.delete_form`.

```php
// Programmatically mint + fetch a shareable edit link:
node_authlink_create($nid);
$node = \Drupal\node\Entity\Node::load($nid);           // authkey now attached on load
$url  = node_authlink_get_url($node, 'update')->toString();
```

## Tokens (`hook_token_info` / `hook_tokens`)
Available on the `node` token type when the node has a key:

| Token | Value |
|---|---|
| `[node:authlink:authkey]` | The raw key. |
| `[node:authlink:view-url]` | Absolute view URL with `?authkey`. |
| `[node:authlink:edit-url]` | Absolute edit URL with `?authkey`. |
| `[node:authlink:delete-url]` | Absolute delete URL with `?authkey`. |

Use in emails, fields, or blocks (e.g. via Token Filter) to hand a recipient a scoped link.
Note these tokens embed a live access credential — anywhere they render, the link grants the
configured ops on that node.
