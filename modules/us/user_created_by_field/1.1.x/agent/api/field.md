<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `field_user_created_by_field` field

A configurable Field API field (not a base field) installed via `config/install`. It records who
created each user account.

## Definition (from config/install)

- Storage `field.storage.user.field_user_created_by_field`: `field_name`
  `field_user_created_by_field`, `entity_type` `user`, `type` `entity_reference`,
  `settings.target_type: user`, `cardinality: 1`, `translatable: true`, `locked: false`.
- Instance `field.field.user.user.field_user_created_by_field`: `bundle` `user`, `label`
  "User Created By Field", `required: false`, handler `default:user` with
  `include_anonymous: true`, `auto_create: false`, `target_bundles: null`.
- Both configs carry `dependencies.enforced.module: [user_created_by_field]`, so they are owned by
  the module and removed on uninstall.

## How it is populated

`hook_user_presave($account)` in `user_created_by_field.module`:

```php
if ($account->isNew()) {
  $uid = \Drupal::currentUser()->id();
  $account->set('field_user_created_by_field', ['target_id' => $uid]);
}
```

- Set **only on new accounts** (`isNew()`); later saves do not overwrite it.
- Value is the acting user at save time: an admin creating an account is recorded; self-registration
  records the current (usually anonymous, uid 0) user — anonymous is a valid value because
  `include_anonymous: true`.
- Programmatic creation records whatever `\Drupal::currentUser()` is in that context.

## Reading / surfacing the value

- The field is not shown anywhere until you expose it. Add it to a user view mode under
  *Manage display*, or to a View (e.g. the People listing at `/admin/people`).
- In code, read it like any entity-reference field:
  `$account->get('field_user_created_by_field')->target_id` (the creator uid) or
  `->entity` (the creator user). It is a Views-usable entity-reference relationship to `user`.
- Note viewing is gated — see [../permissions/permissions.md](../permissions/permissions.md).

## Uninstall

`hook_uninstall` in `user_created_by_field.install` deletes the field storage and instance
(`FieldStorageConfig`/`FieldConfig::loadByName(...)->delete()`), which removes the field and its
stored data. To keep the data, comment out that hook before uninstalling.
