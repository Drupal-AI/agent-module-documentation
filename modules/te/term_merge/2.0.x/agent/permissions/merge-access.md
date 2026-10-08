<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Who can merge terms — the two-layer gate

A user needs **both** layers to reach any of the three merge routes. Granting only the
module's own permission is the usual reason the Merge tab does not appear.

## Layer 1 — the module's permission

`term_merge.permissions.yml`:

```yaml
merge taxonomy terms:
  title: 'Merge taxonomy terms'
  restrict access: true
```

`restrict access: true` means Drupal flags it on the permissions page as security-sensitive.
This is the only permission the module defines.

## Layer 2 — `_term_merge_access_check`

Every merge route also carries `_term_merge_access_check: 'TRUE'`, served by
`term_merge.access_checker` (`Drupal\term_merge\Access\MergeAccess`, tagged
`access_check` / `applies_to: _term_merge_access_check`). It resolves to:

```php
AccessResult::allowedIfHasPermission($account, 'edit terms in ' . $vocabulary->id())
  ->orIf(AccessResult::allowedIfHasPermission($account, 'administer taxonomy'));
```

So per vocabulary the user needs either the core per-vocabulary permission
`edit terms in <vocabulary_id>` or the global `administer taxonomy`.

## The working grants

```bash
# an editor who may merge only in the "topics" vocabulary
drush role:perm:add content_editor 'merge taxonomy terms'
drush role:perm:add content_editor 'edit terms in topics'

# a taxonomy admin who may merge everywhere
drush role:perm:add taxonomy_admin 'merge taxonomy terms'
drush role:perm:add taxonomy_admin 'administer taxonomy'
```

Check what a role actually has:

```bash
drush role:list --filter='merge taxonomy terms'
drush cget user.role.content_editor permissions
```

## Notes

- Merging **deletes** the source terms, so treat `merge taxonomy terms` as a destructive
  permission — it lets a user remove terms without holding `delete terms in <vocab>`.
- The service (`term_merge.term_merger`) performs **no** access checking at all. Anything
  calling it from code — an update hook, a Drush script, a queue worker — bypasses both layers,
  which is intended but worth knowing.
- Upgrading from Drupal 7: `term_merge.module` implements
  `hook_migration_plugins_alter()` to map the D7 `merge terms` permission onto
  `merge taxonomy terms` in the `d7_user_role` migration.
