<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Turn the user-1 protection on/off

## Config (note the inverted semantics)

Config object `disable_user_1_edit.settings`, key **`disabled`** (integer, schema
`disable_user_1_edit.settings` → `disabled: integer`, shipped default `0`):

| `disabled` | Effect |
|---|---|
| `0` (default) | Restriction **ACTIVE** — user 1 is locked (all entity access forbidden) |
| `1` | Restriction **OFF** — user 1 is editable again |

The name is the module's own restriction being "disabled", not user 1 — so `disabled: 0` means the
module IS protecting user 1.

## Settings form

- Route `disable_user_1_edit.config_form` → `/admin/config/people/disable_user_1_edit`
  (`ConfigForm`), permission **`administer disable user 1 edit`** (`restrict access: true`).
- Single checkbox **"Disable restriction"** ("Make user 1 editable again"): checked → `disabled = 1`.

## Read / write

```bash
drush cget disable_user_1_edit.settings disabled          # 0 = protected, 1 = editable
drush cset disable_user_1_edit.settings disabled 1 -y      # make user 1 editable again
drush cset disable_user_1_edit.settings disabled 0 -y      # re-lock user 1 (shipped default)
```

```php
\Drupal::configFactory()->getEditable('disable_user_1_edit.settings')->set('disabled', 0)->save();
```

## Mechanism

`disable_user_1_edit_user_access(EntityInterface $entity, $operation, AccountInterface $account)`:

```php
if ($entity->id() == 1) {
  if (empty($config->get('disabled'))) {                // restriction active
    return AccessResult::forbiddenIf(!$account->hasPermission('Stare into the abyss ' . uniqid()));
  }
}
return AccessResult::neutral();
```

- The guarding permission is a random string that no role can hold, so `forbiddenIf(TRUE)` → the
  result is always **forbidden** while active.
- `$operation` is **not** checked, so update, delete **and view** of user 1 are all forbidden while
  active. (Verify: `\Drupal\user\Entity\User::load(1)->access('update')` is forbidden when
  `disabled = 0`, neutral when `disabled = 1`.)
- Because it returns `neutral` (not `allowed`) when off, disabling the restriction just steps aside
  and lets core's normal user access decide.
