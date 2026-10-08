<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Per-type permissions

## How they are generated

`site_settings_type_permissions.permissions.yml` contains only:

```yaml
permission_callbacks:
  - \Drupal\site_settings_type_permissions\SiteSettingTypePermissions::siteSettingTypePermissionsList
```

`siteSettingTypePermissionsList()` loads every `site_setting_entity_type` config entity and calls
`buildPermissions($type)`, so the permission list grows automatically when a new settings type is
created (after a permissions cache rebuild).

## The eight permissions per type `<id>`

| Permission | Title | Operation it satisfies |
|---|---|---|
| `view published <id> site setting entities` | *%type: View published site settings* | `view` on a published entity |
| `view unpublished <id> site setting entities` | *%type: View unpublished site settings* | `view` on an unpublished entity |
| `create <id> site setting` | *%type: Create new site setting* | create access |
| `edit <id> site setting` | *%type: Edit site setting* | `update` |
| `delete <id> site setting` | *%type: Delete site setting* | `delete` |
| `view <id> site setting entity revisions` | *%type: View Site Setting revisions* | `view revision`, `view all revisions` |
| `revert <id> site setting entity revision` | *%type: Revert site setting revisions* | `revert` |
| `delete <id> site setting entity revision` | *%type: Delete site setting revisions* | `delete revision` |

Example for a type `phone_number`: `edit phone_number site setting`.

## The access logic

`site_settings_type_permissions_site_setting_entity_access($entity, $operation, $account)` — an
implementation of `hook_ENTITY_TYPE_access()`:

- Handles only `view`, `update`, `delete`, `view revision`, `view all revisions`, `revert`,
  `delete revision`; anything else returns `AccessResult::neutral()`.
- For each operation it returns **allowed** when the account has the parent module's global
  permission **or** the type-specific one, and **forbidden** otherwise. Results are
  `cachePerPermissions()` and statically cached per user / type / operation (and per published
  state for `view`).

| Operation | Global permission | Type permission |
|---|---|---|
| `view` (published) | `view published site setting entities` | `view published <id> site setting entities` |
| `view` (unpublished) | `view unpublished site setting entities` | `view unpublished <id> site setting entities` |
| `update` | `edit site setting entities` | `edit <id> site setting` |
| `delete` | `delete site setting entities` | `delete <id> site setting` |
| `view revision` / `view all revisions` | `view all site setting entity revisions` | `view <id> site setting entity revisions` |
| `revert` | `revert all site setting entity revisions` | `revert <id> site setting entity revision` |
| `delete revision` | `delete all site setting entity revisions` | `delete <id> site setting entity revision` |

`site_settings_type_permissions_site_setting_entity_create_access($account, $context, $bundle)`
allows if the account has **either** `add site setting entities` **or**
`create <bundle> site setting` (`AccessResult::allowedIfHasPermissions(…, 'OR')`).

> **Important:** because the hook returns `forbidden` rather than `neutral` when neither
> permission is held, enabling this submodule makes non-admin access to site settings strictly
> opt-in. Users with `administer site setting entities` are unaffected (that is the entity type's
> `admin_permission`).

## Views filtering

`site_settings_type_permissions_views_pre_render(ViewExecutable $view)` runs on the view with id
**`site_settings`** and `unset()`s every result row whose `_entity` fails `access('view')`,
because Views table rows do not check entity access themselves
(see core issue [#777578](https://www.drupal.org/project/drupal/issues/777578)).

## Enabling and granting

```bash
drush en site_settings_type_permissions -y

drush role:perm:add editor 'edit phone_number site setting'
drush role:perm:add editor 'view published phone_number site setting entities'
drush role:perm:add editor 'create phone_number site setting'
```

```php
$role = \Drupal::entityTypeManager()->getStorage('user_role')->load('editor');
$role->grantPermission('edit phone_number site setting')->save();
```

List the generated permissions for a type:

```bash
drush php:eval '$p = \Drupal::service("user.permissions")->getPermissions();
foreach (array_keys($p) as $name) { if (str_contains($name, "phone_number site setting")) { print $name . "\n"; } }'
```

Check a live access decision:

```bash
drush php:eval '$e = \Drupal::entityTypeManager()->getStorage("site_setting_entity")->load(1);
$u = \Drupal::entityTypeManager()->getStorage("user")->load(0);
var_export($e->access("view", $u));'
```
