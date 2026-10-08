<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — the encryption key

There is **no settings form and no config object**. The only thing to configure is
one entry in settings.php: `$settings['encryption_key']`. Every method of the
`encryption` service reads its key from there via
`Drupal\Core\Site\Settings::get('encryption_key', '')`.

## Set the key

The value must be a **base64-encoded 256-bit (32-byte) random value**. Generate one:

```bash
dd bs=1 count=32 if=/dev/urandom | openssl base64
# or
openssl rand -base64 32
```

Add the result to `settings.php` (or `settings.local.php`):

```php
$settings['encryption_key'] = 'IPMj1A1H5w+EMrN5a+w3Y8MUv0CsAAPM5OfaGwMOou4=';
```

Generate your own value — do not reuse the example above.

Rules enforced by `EncryptionTrait::getEncryptionKey()`:

- The setting is `base64_decode`d, then its length must be **exactly 32 bytes**.
- Anything else (missing setting, wrong length, non-base64) makes `getEncryptionKey()`
  return `NULL`, and `encrypt()` / `decrypt()` then also return `NULL`.

Keep the **same key** on every instance that imports the same encrypted configuration.
If the key changes, previously encrypted values can no longer be decrypted
(`decrypt()` returns `NULL`).

## Runtime status check (`hook_requirements`)

`encryption_requirements()` in `encryption.install` adds an `encryption` entry to the
status report at `/admin/reports/status`:

| Condition | Severity | Meaning |
|---|---|---|
| Setting missing | ERROR | "The encryption key was not found." |
| Decodes to a length other than 32 bytes | ERROR | Reports the wrong bit length; a 256-bit key is expected. |
| Valid 32-byte key | OK | "The encryption key is OK." |
| Stored test value fails to decrypt | WARNING | Usually means the key changed since install. |

How the test value works:

- On first run (and after a reset) the module encrypts the string `simple test value`
  and stores it in state under `encryption.test_value`.
- On later runs it decrypts that stored value and compares; a mismatch raises the
  WARNING above with a **Reset** link.
- Reset the stored test value by visiting the status report with
  `?encryption_reset_test_string=1`.

## Verify from drush

The key must live in settings.php, so drush cannot set it. You can confirm a valid key
is loaded without printing it:

```bash
drush php:eval "var_dump((bool) \Drupal::service('encryption')->getEncryptionKey());"
# bool(true) means a valid 32-byte key is present
```
