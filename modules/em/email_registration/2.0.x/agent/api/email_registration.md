# Programmatic API — username generation

## Service — `email_registration.username_generator`

`Drupal\email_registration\UsernameGenerator` (also autowirable by class name). Constructed with
the core `uuid` service.

```php
/** @var \Drupal\email_registration\UsernameGenerator $gen */
$gen = \Drupal::service('email_registration.username_generator');
$temp = $gen->generateRandomUsername(); // "email_registration_" . UUID
```

`generateRandomUsername()` returns a guaranteed-unique placeholder of the form
`email_registration_<uuid>`. The module uses it to fill the username on new/blank registrations and
in the bulk action; `hook_user_presave` then replaces any name that is empty or still starts with
`email_registration_` with the real generated name.

## Procedural helpers (in `email_registration.module`)

```php
// Take the local part of an email, clean it, return a legal username.
$name = email_registration_strip_mail_and_cleanup('jane.doe@example.com'); // "jane.doe"

// Clean an arbitrary string into a legal username: strips illegal chars,
// collapses whitespace to "_", trims, falls back to "user", truncates to
// UserInterface::USERNAME_MAX_LENGTH - 10.
$name = email_registration_cleanup_username($raw);

// Ensure a name is unique among {users_field_data}, appending _1, _2, ...
// $uid is the account id to ignore (0 when the row doesn't exist yet).
$unique = email_registration_unique_username($name, (int) $account->id());
```

## How a username gets generated (flow)

1. A user is saved. `email_registration_user_presave(UserInterface $account)` runs.
2. It invokes `hook_email_registration_name_alter($newAccountName, $account)`. The module's own
   implementation, when the name is empty or a `email_registration_*` placeholder, sets it to
   `email_registration_strip_mail_and_cleanup($account->getEmail())`.
3. If the name changed, it is de-duplicated with `email_registration_unique_username()` and set via
   `$account->setUsername()`.

To change the pattern, implement the alter hook — see
[../hooks/email_registration.md](../hooks/email_registration.md). There is **no** central "create
a user by email" service; you create users the normal way and this presave logic handles the name.
