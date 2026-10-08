<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Encrypted link formatter (encrypted_link_formatter) — agent index

**Renders private file/image fields as base64/AES-encrypted download links and overrides the core file-download route to decrypt and stream them.**

- **Version:** 2.x (composer `dev-2.x`)
- **Core:** ^9 || ^10 || ^11
- **Formatter:** `encrypted_file_download_link` (field types file, image; only applicable when `uri_scheme` = private)
- **Service:** `encrypted_link_formatter.crypter` (`LinkCrypter::crypt()` / `::decrypt()`)
- **Config route:** `encrypted_link_formatter.crypt_settings` → `/admin/config/system/crypt-settings` (`administer site configuration`)
- **Config:** `encrypted_link_formatter.settings` (seed, enc_types, enc_lifetime)
- **Route override:** subscriber repoints `system.files` + `system.private_file_download` to `EncryptedFileDownloadController::download`
- **Cron:** rotates `private://iv/iv.bin` when AES mode is active

**Security:** Config form gated by `administer site configuration`; the download controller inherits core's route access and still delegates to `hook_file_download`. The "encryption" is URL obfuscation only — base64 mode is trivially reversible, AES mode uses the seed as the raw key with one static IV and a weak default seed. Not a confidentiality control. See the controller `Content-Disposition`/`count($headers)` ordering note.

See [configure/crypt-settings.md](configure/crypt-settings.md) and [api/crypter.md](api/crypter.md).
