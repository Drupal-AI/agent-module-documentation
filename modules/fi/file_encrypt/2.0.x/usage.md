<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
File encrypt stores uploaded files encrypted on disk behind an `encrypt://` stream wrapper and transparently decrypts them as they are served to users who are allowed to download them.

---

The module registers an `encrypt://` stream wrapper (`EncryptStreamWrapper`, extending core `LocalStream`) whose base path is `$settings['encrypted_file_path']`, and whose URIs carry the profile in the host segment — `encrypt://{profile}/{path/to/file.ext}`. It performs **no cryptography of its own**: `stream_open()` attaches two PHP stream filters to the file handle — an `EncryptStreamFilter` on the write chain and a `DecryptStreamFilter` on the read chain — each of which calls the **`encrypt`** module's `encryption` service (`EncryptService::encrypt()` / `::decrypt()`) with the `EncryptionProfile` named in the URI, so the actual cipher, IV/nonce handling and any MAC are entirely the responsibility of the encryption-method plugin the profile selects (e.g. `real_aes` = AES-256-CBC + HMAC via defuse/php-encryption, or the sodium-based methods). Data is filtered **bucket by bucket**: the encrypt filter encrypts each stream bucket independently and prepends a 7-byte zero-padded length header; the decrypt filter buffers until it has a full header-delimited unit, then decrypts it — so a stored file is a sequence of `[length header][ciphertext chunk]` segments. A field is opted in on its *Field storage settings* form: `FieldStorageConfigEditFormAlter` adds an **Encryption profile** radio set (from `EncryptionProfileManager::getEncryptionProfileNamesAsOptions()`) shown when the upload destination (`uri_scheme`) is `encrypt`, storing the choice as the `file_encrypt` third-party setting on the field storage; `hook_field_config_presave()` then prepends the profile name to the field's `file_directory` so uploads land at `encrypt://{profile}/…`. Delivery mirrors Drupal's private-file pattern: routes `/encrypt/files/{filepath}` (core `system\FileDownloadController`) and `/encrypt/files` (`file_encrypt`'s `FileDownloadController`, which wraps the body in an `EncryptBinaryFileResponse` that recomputes `Content-Length` from the decrypted stream and marks the response private) are `_access: 'TRUE'` at the routing layer, with real authorization delegated to the `hook_file_download()` chain exactly as private files are; inbound path processors move the file path into a `file` query parameter. Image styles are handled by an `ImageStyleDownloadController` that subclasses core's and keeps its SA-CORE-2023-005 path-traversal guard and `hash_equals()` derivative-token check. `hook_cron()` writes a deny-all `.htaccess` into the encrypted directory. This is **2.0.0-alpha1** — an alpha, for a component whose failure mode is permanently unreadable files.

---

- Encrypt uploaded files at rest on the local filesystem.
- Protect sensitive documents on shared or multi-tenant hosting.
- Meet a contractual or regulatory encryption-at-rest obligation.
- Keep file contents unreadable in backups, snapshots and disk images.
- Store identity documents, ID scans or passports encrypted.
- Encrypt signed contracts and legal paperwork.
- Protect medical or other special-category personal records.
- Drive file encryption from a Key entity backed by an env var or KMS, not the database.
- Serve decrypted files only to users authorized by `hook_file_download()`.
- Encrypt a specific file or image field without touching other fields.
- Choose the cipher per profile via the `encrypt` module (e.g. `real_aes`, sodium).
- Use different encryption profiles (and keys) for different field types.
- Encrypt Webform file uploads via a dedicated "webform" profile.
- Serve encrypted images through image styles, decrypting derivatives on delivery.
- Reduce exposure if a database dump leaks but the key store does not.
- Support a data-protection impact assessment or security-audit finding.
- Pair with `field_encrypt` to also encrypt file title/description metadata.
- Segregate tenant files behind separate keys on one Drupal instance.
- Replace ad-hoc "private files are enough" assumptions with real at-rest encryption.
- Rotate file encryption by re-keying an encryption profile (re-encrypt required).
