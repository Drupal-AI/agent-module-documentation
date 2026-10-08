<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Declared in `drush.services.yml` (legacy `drush.command`-tagged services).

| Command | Alias | Signature |
|---|---|---|
| `permissions-by-term:rebuild` | `pbtr` | `accessRebuild()` |
| `permissions-by-term:create-nodes-with-permissions` | `pbtcnwp` | `createNodesWithPermissions(int $numNodes = 1000)` |

## `permissions-by-term:rebuild` (`pbtr`)

Rebuilds the core node access records for every node this module manages.

```bash
drush permissions-by-term:rebuild
drush pbtr
```

**Both commands ask an interactive `confirm()` that defaults to No** and there is no `--yes`
option on them — in a non-interactive context (CI, an agent shell) the confirmation is answered
with the default and *nothing happens*. Use the service directly when scripting:

```bash
drush php:eval '\Drupal::service("permissions_by_term.node_access")->rebuildAccess();'
# or a full core rebuild
drush php:eval 'node_access_rebuild(TRUE);'
```

Internally it calls `NodeAccess::getNidsForAccessRebuild()` and then the static
`NodeAccess::rebuildNodeAccessOne($nid)` per node, with a progress bar.

Run it after: importing grants directly into `permissions_by_term_user` /
`permissions_by_term_role`, a content migration, or toggling `permission_mode` /
`disable_node_access_records`.

## `permissions-by-term:create-nodes-with-permissions` (`pbtcnwp`)

A **test-fixture generator**, not a production tool. For each of `$numNodes` (default 1000) it
creates a random term in the `tags` vocabulary, grants it to **uid 1**, and creates an `article`
node referencing it through `field_tags`. It therefore requires the standard profile's `tags`
vocabulary and `field_tags` field.

```bash
drush permissions-by-term:create-nodes-with-permissions 50
```

## Migrate destination (not Drush, but scriptable)

`@MigrateDestination(id = "permissions_by_term_user")` —
`Drupal\permissions_by_term\Plugin\migrate\destination\PermissionsByTermUser` writes user→term
grants from a migration:

```yaml
process:
  uid: uid
  tids:
    - plugin: explode
      delimiter: ','
      source: tids
    - plugin: entity_generate
      entity_type: taxonomy_term
      bundle_key: vid
      bundle: vocabulary
      value_key: name
destination:
  plugin: permissions_by_term_user
```
