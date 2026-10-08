<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File encrypt (file_encrypt) — agent index

Encrypts uploaded file **contents** at rest through an **`encrypt://` stream wrapper**, decrypting
transparently on delivery. Version **2.0.0-alpha1** (alpha). Core `^10.3 || ^11`.
Depends on **`encrypt`** (encryption profiles + `encryption` service) and core **`file`**.
The **Key** module is the practical companion (the profile's key source), and an encryption method
plugin such as **`real_aes`** is required for the profile to function.

## What it is / is not
- **It is** at-rest encryption of the file bytes: what lands on disk (and in backups/snapshots) is
  ciphertext. It does **no crypto itself** — cipher, IV/nonce and MAC are the encryption-method
  plugin's job (chosen per encryption profile in the `encrypt` module).
- **It is not** access control. *Who* may download a file is still decided by the
  `hook_file_download()` chain, exactly as for private files. Encryption and authorization are
  independent layers.
- **It does not** encrypt file metadata (title/description) — use `field_encrypt` for that.

## Mechanism (real names)
- **`Drupal\file_encrypt\EncryptStreamWrapper`** (extends `LocalStream`, scheme `encrypt`,
  service `stream_wrapper.encrypt`). Base path = `$settings['encrypted_file_path']`.
  URIs are `encrypt://{profile}/{path}`; the profile lives in the URL host.
- On `stream_open()` it attaches two PHP stream filters via `appendAllStreamFilters()`:
  - **`EncryptStreamFilter`** (write chain) → `encryption->encrypt($data, $profile)`, prepends a
    7-byte zero-padded length header per bucket.
  - **`DecryptStreamFilter`** (read chain) → buffers to a full `[header][ciphertext]` unit, then
    `encryption->decrypt(...)`.
  - Both extend **`StreamFilterBase`**; the `encryption` service + resolved `EncryptionProfile` are
    passed as filter params. Files are encrypted **chunk-by-chunk** (per stream bucket), each chunk
    an independent ciphertext.
- **Opt-in per field**: `Hooks\FieldStorageConfigEditFormAlter` adds an *Encryption profile* radio
  set to the field storage form (visible when `uri_scheme == encrypt`), stored as the `file_encrypt`
  third-party setting. `hook_field_config_presave()` prepends the profile name to `file_directory`
  so uploads write to `encrypt://{profile}/…`.
- **Delivery**: routes are `_access: 'TRUE'` at the routing layer, authorization delegated to
  `hook_file_download()` (private-file pattern):
  - `system.encrypt_file_download` `/encrypt/files/{filepath}` → core `system\FileDownloadController`.
  - `file_encrypt.file_download` `/encrypt/files` → `Controller\FileDownloadController`, wraps body
    in **`EncryptBinaryFileResponse`** (recomputes `Content-Length` from the decrypted stream,
    `setPrivate()`).
  - `image.style_encrypt` → `Controller\ImageStyleDownloadController::deliver()` (subclasses core;
    keeps SA-CORE-2023-005 traversal guard + `hash_equals()` token check).
  - `PathProcessor\PathProcessorFiles` / `PathProcessorImageStyles` move the file path into a `file`
    query parameter. `Routing\RouteSubscriber` disables route normalization when `redirect` is on.
- **`hook_cron()`** writes a deny-all `.htaccess` (`FileSecurity::writeHtaccess`) into the encrypted
  directory.

## Setup (from README)
1. `$settings['encrypted_file_path'] = 'sites/default/files-encrypted';` in `settings.php`.
2. Create a key (via **Key**) and an encryption method (e.g. **`real_aes`**).
3. Create an **encryption profile** at `/admin/config/system/encryption/profiles`.
4. On a file/image field's *storage settings*, set upload destination to **Encrypted files** and pick
   the profile. For Webform uploads, create a `webform`-named profile.

## Operational realities
1. **Key loss = permanent data loss.** No recovery path. Design key backup/rotation before first
   upload. Re-keying a profile requires re-encrypting existing files.
2. **Image derivatives** are generated from decrypted bytes and stored under the profile — confirm
   the derivative store is itself the encrypted scheme, not a plaintext copy.
3. **Alpha** software guarding data whose failure mode is unreadable files — test restore paths.

## No provides
No permissions, no routes you configure (`configure: null`), no Drush commands, no plugin types.
Only config it owns is the `field.storage.*.*.third_party.file_encrypt` schema (encryption_profile).

## Subpages
- `stream-wrappers/encrypt-stream.md` — the `encrypt://` wrapper, stream filters and on-disk format.
- `config/setup.md` — settings.php, profiles, per-field opt-in, Webform.
