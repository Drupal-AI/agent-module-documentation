<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, forms and where grants live

![Permissions by Term settings form](../../../../../../../screenshots/permissions_by_term/3.1.x/settings.png)

## Settings (`permissions_by_term.settings`)

Form: `/admin/permissions-by-term/settings` (route `permissions_by_term.settings`, permission
`access pbt settings`, menu *Configuration → System → Permissions by Term*).

| Key | Default | Meaning |
|---|---|---|
| `permission_mode` | `false` | Whitelist mode: a node is only accessible if a term **explicitly** grants it. Nodes with no terms, or with terms that grant nothing, become invisible. |
| `require_all_terms_granted` | `false` | The user must be granted **every** term on the node, not just one. |
| `disable_node_access_records` | `false` | Do not publish core node access records. Restriction then only applies on node view/edit; Views, menus and `/admin/content` stop being filtered. Big performance win on large listings. Toggling it runs `node_access_rebuild(TRUE)`. |
| `only_parents` | *(unset)* | Show only top-level terms in the user-form selector. |
| `target_bundles` | `{}` (all) | Sequence of vocabulary ids the module manages. **Unchecking a vocabulary deletes its stored term permissions** (`AccessStorage::deleteAllTermPermissionsByTermBundle()`); leaving the list empty means "all vocabularies". |
| `show_terms_in_user_form` | `true` | Render the *Permissions → Vocabularies* selector on the user edit form. |
| `hide_terms_permissions_info_in_node_form` | `false` | Hide the read-only "Permissions by Term" panel on the node form (saves load time). |

```bash
drush config:get permissions_by_term.settings
drush config:set permissions_by_term.settings permission_mode 1 -y
drush php:eval '\Drupal::configFactory()->getEditable("permissions_by_term.settings")
  ->set("require_all_terms_granted", TRUE)
  ->set("target_bundles", ["tags"])->save();'
# after changing permission_mode / disable_node_access_records:
drush php:eval 'node_access_rebuild(TRUE);'
```

## Where grants are stored

Two tables created by `permissions_by_term_schema()` — there is **no config entity** for grants:

```
permissions_by_term_user   tid (int), uid (int), langcode (varchar_ascii 12)   PK(tid, uid, langcode)
permissions_by_term_role   tid (int), rid (varchar 60), langcode              PK(tid, rid, langcode)
```

`langcode` is the **term's** language (the user form uses the account's preferred langcode).
Access checks compare against the term's langcode, so grants written with the wrong langcode are
silently ignored.

```bash
drush sql:query "SELECT * FROM permissions_by_term_role;"
drush sql:query "SELECT * FROM permissions_by_term_user;"
```

## The two forms that write them

- **Taxonomy term form** (`hook_form_taxonomy_term_form_alter`) — adds a *Permissions* details
  element with `access[user]` (entity autocomplete, comma separated) and `access[role]`
  (checkboxes). Only rendered for users with `show term permission form on term page`, and only
  for vocabularies inside `target_bundles`. Submit → `AccessStorage::saveTermPermissions()`, then
  a node-access rebuild for that term plus a cache invalidation (skipped when
  `disable_node_access_records` is on).
- **User edit form** (`hook_form_user_form_alter`) — a *Permissions → Vocabularies* multi-select
  per vocabulary. Requires `show term permissions on user edit page` and
  `show_terms_in_user_form`. Submit deletes **all** of that user's grants and re-inserts the
  selection with `$user->getPreferredLangcode()`.

## Writing grants programmatically

```php
$as = \Drupal::service('permissions_by_term.access_storage');

$as->addTermPermissionsByRoleIds(['editor'], $tid, 'en');
$as->addTermPermissionsByUserIds([$uid], (string) $tid, 'en');

$as->getRoleTermPermissionsByTid($tid, 'en');   // ['editor', 'administrator', …]
$as->getUserTermPermissionsByTid($tid, 'en');   // uids
$as->getPermittedTids($uid, $account->getRoles());

$as->deleteTermPermissionsByRoleIds(['editor'], $tid, 'en');
$as->deleteAllTermPermissionsByUserId($uid);
$as->deleteAllTermPermissionsByTid($tid);
```

**Gotcha:** `addTermPermissionsByRoleIds()` silently also grants the term to **every role holding
`bypass node access`** (typically `administrator`), so the row count is usually one more than you
asked for.

After changing grants outside the forms, rebuild:

```bash
drush permissions-by-term:rebuild   # alias: pbtr
```

## Automatic cleanup

- `hook_user_cancel()` → `deleteAllTermPermissionsByUserId()`.
- `hook_taxonomy_term_delete()` → `deleteAllTermPermissionsByTid()`.
- Both then invalidate the `permissions_by_term` cache bin via
  `permissions_by_term.cache_invalidator`.
