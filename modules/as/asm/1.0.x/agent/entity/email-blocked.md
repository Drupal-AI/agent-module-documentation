<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `asm_email_blocked` content entity

Defined in `src/Entity/EmailBlocked.php` (`@ContentEntityType`), implementing
`EmailBlockedInterface` (adds `getEmail(): string`).

## Definition

- `id = "asm_email_blocked"`, `base_table = "asm_email_blocked"`.
- `admin_permission = "administer asm email blocked"` — declared in `asm.permissions.yml` with
  `restrict access: true`. This permission grants all entity operations; there is no separate
  view/create/update/delete permission split.
- `entity_keys`: `id`, `label = "email"`, `uuid`.
- Handlers: `storage_schema = Drupal\asm\EmailBlockedStorageSchema`,
  `views_data = Drupal\views\EntityViewsData` (so blocked emails are exposable to Views).
- No form/route/list handlers are declared here — the `asm_ui` submodule adds them at runtime via
  `hook_entity_type_alter()`. Without `asm_ui`, the entity exists (and mail blocking works) but has
  no admin UI.

## Base fields (`baseFieldDefinitions()`)

- `email` — `email` field, **required**, `->addConstraint('UniqueField')` (no duplicate blocked
  addresses). Form widget `string_textfield`; shown in view. This is the `label`.
- `reason` — `text_long` (needs core `text`, the module's only dependency). Widget
  `text_textarea`. Free-text note explaining why the address is blocked.
- `created` — `created` timestamp ("Authored on").

No `changed`, no owner/uid field, no bundles.

## Storage schema

`EmailBlockedStorageSchema` extends `SqlContentEntityStorageSchema` and overrides
`getSharedTableFieldSchema()` to add an index on the `email` column of `asm_email_blocked` (via
`addSharedTableFieldIndex()`), speeding the `WHERE email IN (...)` lookup that `MailAlter` runs on
every outgoing message.

## Programmatic use

```php
$storage = \Drupal::entityTypeManager()->getStorage('asm_email_blocked');
$storage->create([
  'email' => 'test@example.com',
  'reason' => 'Staging environment — do not email real users.',
])->save();
```

`getEmail()` returns the stored address. The `UniqueField` constraint means a create/save with an
already-blocked address fails validation.
