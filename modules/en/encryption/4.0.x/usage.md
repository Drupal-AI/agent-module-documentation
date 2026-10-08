<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Encryption supplies a small two-way symmetric encrypt/decrypt service built on PHP's openssl (AES-256-CTR), with a single key held in settings.php. It is a lightweight way for other code to store and read back reversible encrypted values without pulling in a larger key-management stack.

---

The module has almost no surface: one service, registered as `encryption` (class `Drupal\encryption\EncryptionService`), and the `EncryptionTrait` it is built from. Both expose `encrypt()`, `decrypt()` and `getEncryptionKey()`. Call the service from your own code, or `use` the trait directly on a class such as a settings form so the two methods sit alongside your build/submit handlers. `encrypt()` returns a URL-safe base64 string by default (or the raw binary message when asked), and a fresh random 16-byte IV is generated on every call so repeated encryptions of the same input differ. `decrypt()` reverses it and returns the original string, or null when the input is empty or cannot be read back.

Setup is a single line: `$settings['encryption_key']` must hold a base64-encoded 32-byte value, which the README shows how to generate with `openssl base64` over 32 random bytes. There is no configuration form, no permissions, no drush commands and no plugins. A `hook_requirements()` check surfaces on the status report at `/admin/reports/status`, confirming the key is a valid 256-bit value and that a stored test string still decrypts — useful for catching a missing or changed key. It suits storing a token or other sensitive value in a reversible form; for configurable multi-key, multi-method setups the maintainers point to the Encrypt module instead.

---

- Encrypt a value from custom code with the `encryption` service.
- Decrypt a previously stored value.
- Store an API token in reversible encrypted form.
- Add `encrypt()`/`decrypt()` to a settings form via `EncryptionTrait`.
- Persist a secret in configuration without the plaintext on disk.
- Get a URL-safe base64 string suitable for storing in a column.
- Get the raw binary message form when you want the compact bytes.
- Round-trip a string: `decrypt(encrypt($x))` returns `$x`.
- Generate a proper 32-byte key with `openssl rand -base64 32`.
- Put the key in `$settings['encryption_key']` in settings.php.
- Share one key across instances that import the same encrypted config.
- Read the key bytes with `getEncryptionKey()` for a custom routine.
- Check key validity on the status report via `hook_requirements()`.
- Reset the stored test value with `?encryption_reset_test_string=1`.
- Confirm from drush that a valid key is loaded.
- Use AES-256-CTR without wiring up openssl calls yourself.
- Rely on a fresh random IV per encryption automatically.
- Inject the service with `EncryptionServiceInterface` type hint.
- Avoid adopting the full Encrypt/Key module stack for a simple need.
- Encrypt short secrets such as third-party credentials.
- Detect a changed key when stored values stop decrypting.
- Return null cleanly when there is nothing to decrypt.
