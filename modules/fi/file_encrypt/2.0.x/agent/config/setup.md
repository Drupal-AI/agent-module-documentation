<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setup and configuration

file_encrypt has **no admin UI of its own** (`configure: null`). Configuration is: one setting in
`settings.php`, an encryption profile (owned by the `encrypt` module), and a per-field opt-in.

## 1. Storage path (`settings.php`) — required
```php
$settings['encrypted_file_path'] = 'sites/default/files-encrypted';
```
This is `EncryptStreamWrapper::basePath()`. Put it **outside** the public web root (or rely on the
deny-all `.htaccess` that `hook_cron()` writes there via `FileSecurity::writeHtaccess()`). Without
this setting the base path is `''` and the wrapper cannot store files.

## 2. Key + encryption method + profile (`encrypt` / `key`)
1. Create a key with the **Key** module (env var / file / KMS provider — keep it out of the DB).
2. Install an encryption **method** plugin. `real_aes` (AES-256, defuse/php-encryption) is the
   documented choice; the method decides the actual cipher/IV/MAC — file_encrypt only calls it.
3. Create an **encryption profile** at `/admin/config/system/encryption/profiles` binding that
   method + key. The profile's **machine name** becomes the `encrypt://{name}/…` host segment.

## 3. Opt a field in
On a **file or image field's *storage settings*** form
(`FieldStorageConfigEditFormAlter`, triggered for `FileItem`-derived field types):
- Set **Upload destination / URI scheme** to **Encrypted files** (`encrypt`).
- Pick an **Encryption profile** from the radio set (populated by
  `EncryptionProfileManager::getEncryptionProfileNamesAsOptions()`; if none exist it shows
  "No encryption profile found.").

Saved as the field storage's `file_encrypt` **third-party setting** `encryption_profile`
(schema: `field.storage.*.*.third_party.file_encrypt`). On `hook_field_config_presave()` the profile
name is prepended to the field's `file_directory`, so uploads write to `encrypt://{profile}/{dir}/…`
and the wrapper always knows which profile to use.

## 4. Webform uploads
Create an encryption profile named **`webform`** to encrypt Webform file uploads (per README).

## What it does NOT cover
- **File metadata** (title, description, alt): not encrypted — add `field_encrypt` for those.
- **Access control**: unchanged. Downloads go through `hook_file_download()` (private-file model),
  independent of encryption. Routes are `_access: 'TRUE'` by design, with authorization delegated to
  that hook chain.
- **Existing files**: switching a field to `encrypt` does not retro-encrypt already-uploaded files.
- **Key rotation**: changing a profile's key does not re-encrypt stored files; plan a re-encryption
  pass. Losing the key means the files are unrecoverable.
