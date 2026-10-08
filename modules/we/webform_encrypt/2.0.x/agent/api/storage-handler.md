<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Runtime mechanism (storage + access handlers)

`hook_entity_type_alter()` swaps two handlers on the `webform_submission` entity type:

- **storage** → `Drupal\webform_encrypt\WebformEncryptSubmissionStorage` (extends `WebformSubmissionStorage`)
- **access** → `Drupal\webform_encrypt\WebformEncryptSubmissionAccessControlHandler`

## Encrypt / decrypt lifecycle (storage)

- `doPreSave()` calls `encryptElements($data, $webform)` — for every element that has
  `webform_encrypt.element.<key>` config with an `encrypt_profile`, the scalar value (or every
  scalar child, recursively via `encryptChildren()`) is replaced by the encrypted value.
- Stored form: `serialize(['data' => $this->encryptionService->encrypt($value, $profile), 'encrypt_profile' => $profile->id()])`.
- `doPostSave()` immediately decrypts back (with `$check_permissions = FALSE`) so multistep
  wizards and post-save logic keep working on plaintext.
- `loadData()` decrypts on load via `decryptElements($submission)` (permission-checked).

Encryption is delegated to core service **`encryption`** (`EncryptServiceInterface`), injected in
`createInstance()`. The profile is loaded with `EncryptionProfile::load(<id>)`.

## Permission gating on decrypt

`decrypt($data, $check_permissions = TRUE)`:

```php
if ($check_permissions && !$currentUser->hasPermission('view encrypted values')) {
  return '[Value Encrypted]';
}
```

So a user without `view encrypted values` sees the literal string `[Value Encrypted]` for every
encrypted element wherever submission data is loaded and rendered.

## Access rule (access handler)

`checkAccess()` overrides the `update` operation: if any element in the submission is encrypted
(`config[$name]['encrypt']` truthy) and the account lacks `view encrypted values`, it returns
`AccessResult::forbidden()` — you cannot edit a submission you are not allowed to decrypt. All
other operations defer to the parent Webform handler.

## Uninstall safety

`hook_uninstall()` walks `webform_submission_data`, decrypts every value belonging to an encrypted
element back to plaintext, and writes it back — so removing the module never leaves unreadable
ciphertext in the database.

## When to touch this

You normally never call these classes directly. Interact through the webform third-party setting
(see [../configure/encrypt-elements.md](../configure/encrypt-elements.md)); the handlers do the
rest transparently on save/load.
