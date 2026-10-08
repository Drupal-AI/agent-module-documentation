<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mechanism: constraint swap + gated bypass

## Removing core uniqueness

`sharedemail_entity_base_field_info_alter(&$fields, $entity_type)` (in `sharedemail.module`) runs for the
`user` entity type and rewrites the `mail` base field's constraints:

```php
$constraints = $fields['mail']->getConstraints();
unset($constraints['UserMailUnique']);       // drop core's one-account-per-email rule
$constraints['SharedEmailUnique'] = [];      // add ours
$fields['mail']->setConstraints($constraints);
```

## The constraint

`Plugin/Validation/Constraint/SharedEmailUnique` extends core `UserMailUnique` (annotation id
`SharedEmailUnique`) and points `validatedBy()` at `SharedEmailUniqueValidator`.

`SharedEmailUniqueValidator extends UniqueFieldValueValidator`. Its `validate()`:

```php
if ($this->currentUser->hasPermission('create shared email account')) {
  $allowed = \config('sharedemail.settings')->get('sharedemail_allowed');
  if (empty($allowed) || stripos($allowed, $item->value) !== FALSE) {
    return;   // skip uniqueness -> duplicate email allowed
  }
}
parent::validate($items, $constraint);   // otherwise enforce normal uniqueness
```

So a duplicate email is only accepted when **both**: the acting user has `create shared email account`,
**and** the allowlist is empty or contains the address. Everyone else still gets core's uniqueness error.

## The post-save warning

`sharedemail_form_user_form_alter()` appends `_sharedemail_form_submit` to the user form's submit
handlers. After save, if the current user has `access shared email message` and more than one account now
shares that `mail` value, it shows `sharedemail_msg` as a warning via the messenger.

There are no services to call and no Drush commands; behaviour is entirely constraint + config + permission.
