<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions & how term access is gated

## Permission defined

| Permission | Source | Gates |
|---|---|---|
| `view terms in <vocabulary_id>` | dynamic, one per vocabulary — `TaxonomyPermissions::permissions` (a `permission_callbacks` entry in `taxonomy_permissions.permissions.yml`) | Viewing published taxonomy terms of that **one** vocabulary. |

The machine name is literally `view terms in {vocabulary machine name}` (e.g. `view terms in tags`).
Title is "View terms in <label>", description "View the terms of <label> vocabulary". One key is
emitted per vocabulary loaded via `Vocabulary::loadMultiple()`, so the list grows/shrinks with your
vocabularies. Provider is `taxonomy_permissions`.

Grant on **People → Permissions** (`/admin/people/permissions`) or programmatically:

```php
\Drupal\user\Entity\Role::load('editor')
  ->grantPermission('view terms in tags')
  ->save();
```
```bash
drush role:perm:add editor 'view terms in tags'
```

## How the `view` operation is enforced

`hook_entity_type_alter()` (in `taxonomy_permissions.module`) sets the taxonomy_term access class to
`Drupal\taxonomy_permissions\TaxonomyPermissionsControlHandler`, which extends core's
`TermAccessControlHandler`. Its `checkAccess()`:

- `administer taxonomy` → `AccessResult::allowed()` (per-permissions cache) for any operation.
- operation `view` → `AccessResult::allowedIf($account->hasPermission("view terms in {$entity->bundle()}") && $entity->isPublished())`, with the term added as a cacheable dependency and cache-per-permissions. When the condition is false the result is **neutral** (no opinion, so access is denied unless another module's `hook_entity_access` grants it) and a reason string is set: "The 'view terms in <bundle>' permission is required and the taxonomy term must be published."
- any other operation (create, update, delete) → `parent::checkAccess()`, i.e. **unchanged core behavior** (core's `edit terms in <vocab>` / `delete terms in <vocab>` / `administer taxonomy` still govern those). This module does not add create/update/delete permissions.

So the only operation this module changes is term **view**; unpublished terms are viewable only via
`administer taxonomy`.

## Field access for taxonomy reference fields

`hook_entity_field_access($operation, $field_definition, $account, $items)` covers the `edit`
operation on any `entity_reference` field whose `target_type` is `taxonomy_term`:

- handler `views` → allowed only if the account holds `access taxonomy overview`.
- other handlers → reads `handler_settings['target_bundles']` and allows if the account holds
  `view terms in <vid>` for **at least one** target vocabulary; otherwise `AccessResult::forbidden()`.
- all other fields/operations → `AccessResult::neutral()`.

Effect: a user can edit (select terms in) a taxonomy reference field only when they can view at least
one of the field's target vocabularies. This ties reference-field editing to the same per-vocabulary
view permission.

## Default-open grants (why you see no effect until you change permissions)

To avoid locking terms away on enable, the module grants the view permission to Anonymous +
Authenticated by default:

- `hook_install()` → for every existing vocabulary, grants `view terms in <id>` to
  `AccountInterface::ANONYMOUS_ROLE` and `AUTHENTICATED_ROLE`.
- `hook_entity_insert()` → when a vocabulary is created, grants its `view terms in <id>` to those two roles.
- `hook_entity_delete()` → when a vocabulary is deleted, revokes it from those two roles.

Because of this, terms remain visible to everyone until you remove these grants on the Permissions
page. No config entities, schema, settings form, or Drush commands — the module is permissions +
access handlers only.
