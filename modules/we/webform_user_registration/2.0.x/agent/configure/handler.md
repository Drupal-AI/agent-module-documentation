# The User Registration webform handler

`src/Plugin/WebformHandler/UserRegistrationWebformHandler.php`, id `user_registration`. Add it to a
webform: *Structure › Webforms › (webform) › Settings › Emails/Handlers › Add handler → User
Registration*. No global settings page. Requires `webform:^6.2` and core `user`.

## Configuration (schema `webform.handler.user_registration`)

```
create_user:
  enabled: false                  # allow anonymous submitters to create an account
  roles: []                       # roles to assign (UI only if admin has 'administer permissions')
  admin_approval: true            # account is blocked until an admin approves
  admin_approval_message: "…"     # status shown after submit when approval required
  email_verification: true        # generated password + verify email before login
  email_verification_message: "…"
  success_message: "Registration successful. You are now logged in."
  keep_email_as_username: false   # true → username = full email; false → '@' replaced with '.'
update_user:
  enabled: false                  # authenticated submitter updates their own account
user_field_mapping:               # webform element key => user entity field/property
  { element_key: mail, other_key: field_phone, … }
```

Defaults come from `defaultConfiguration()`. Messages are stored in config (config-translatable) and are
printed **without** re-running `t()`.

## Field mapping

- `user_field_mapping` maps each webform element key to a user entity property/field. Destination
  options are ALL user fields (`entity_field.manager` `getFieldDefinitions('user','user')`); source
  options are the webform's value elements.
- `getWebformUserData()` reads the submission and produces `['<user_field>' => <submitted value>]`.
- Validation requires a mapping to `mail` when `create_user.enabled` (else form error "User creation
  requires at least a source for email address").

## Create vs update lifecycle (`validateForm()` → `postSave()`)

- **Anonymous + create enabled:** `createUserAccount()` builds an unsaved user — `init` = mail, `name`
  from mail (`@`→`.` unless `keep_email_as_username`), generated `pass`
  (`password_generator->generate()`), current langcode, configured `roles`; then `block()` if
  `admin_approval` else `activate()`. With `keep_email_as_username`, an existing name/mail match is
  rejected inline.
- **Authenticated + update enabled:** loads the current user and `set()`s mapped values
  (`updateUserAccount()`; a `mail` change without `pass` is dropped, matching core's constraint).
- `$account->validate()` runs; entity violations are mapped back onto the originating webform elements
  via `user_field_mapping`.
- `postSave()` saves the account. For a NEW account: if `admin_approval` → `_user_mail_notify(
  'register_pending_approval')` and the submission owner is set; elif `email_verification` →
  `_user_mail_notify('register_no_approval_required')` + set owner; else `user_login_finalize()` logs
  the user in. The matching configured message is shown via `messenger()->addStatus()`.

## Limitations & guards (grounded in code)

- **No AJAX support** — with AJAX enabled the form shows a warning linking to disable AJAX or set a
  confirmation redirect (`user_login_finalize()` under AJAX trips Drupal's suspicious-form check).
- **Role assignment is access-gated** — the `roles` checkboxes have
  `#access => $roles && currentUser->hasPermission('administer permissions')`, and the Authenticated
  role is forced/disabled. A webform admin lacking `administer permissions` cannot grant roles through
  this UI. (Configuring the handler at all requires webform admin rights, a trusted permission.)
- Safe out of the box: creation and update are both disabled by default, and when creation is enabled,
  admin approval and email verification are both on by default.

## Set the handler with Drush (example)

```php
// drush php:eval — attach the handler to webform "register"
$webform = \Drupal::entityTypeManager()->getStorage('webform')->load('register');
$webform->addWebformHandler(\Drupal::service('plugin.manager.webform.handler')->createInstance('user_registration', [
  'settings' => [
    'create_user' => ['enabled' => TRUE, 'admin_approval' => FALSE, 'email_verification' => TRUE],
    'user_field_mapping' => ['email' => 'mail', 'full_name' => 'field_full_name'],
  ],
]));
$webform->save();
```
