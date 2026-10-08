# Node Authorize Link — agent index

Per-node secret links (`?authkey=<token>`) that let an unauthenticated visitor view / view
revision / update / delete a specific node without logging in. Enabled per content type. Depends
on core `node`. Provides permissions; no config UI route (`configure` null — configured on the
node-type form), no config schema, no Drush.

- **Enable per content type, grants, expiry/cron, batch ops, the per-node admin form, config
  shape** → [configure/setup.md](configure/setup.md)
- **How the token/access actually works, the API functions, and the tokens** →
  [api/urls.md](api/urls.md)
- **Permissions and the access-enforcement chain** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Token = `hash('sha256', random_bytes(64))` (256-bit CSPRNG), one per node, stored in table
  `node_authlink_nodes` (`nid`, `authkey` varchar(64), `created`). **Not** guessable/enumerable.
- A valid `?authkey` grants exactly the operations enabled for the node's bundle
  (`view`, `view revision`, `update`, `delete`); grants are saved into `$_SESSION`.
- Enforced by: `NodeAuthlinkNodeAccessControlHandler` (set via `hook_entity_type_alter`),
  `NodeRevisionAccessCheck` (decorates `access_check.entity`), `hook_node_access()`, and a Group
  handler override. All defer to `node_authlink_check_authlink()`.
- Keys are **permanent by default**; optional cron regeneration after a configured age. Deleted
  with the node.
- Tokens: `[node:authlink:authkey|view-url|edit-url|delete-url]`. Bundled view `node_authlinks`
  lists/deletes keys.

Access model (see configure/setup.md): token is strong and per-node; grants are admin-configured
per bundle and default to none; the token travels in the URL query and keys are permanent by
default unless a regeneration age is set.
