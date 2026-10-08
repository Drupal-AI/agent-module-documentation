<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Encrypted link formatter renders private file/image fields as download links whose URL path is base64- or AES-encrypted, and overrides the core file-download route to decrypt and stream the file.

The module ships a `encrypted_file_download_link` field formatter (only applicable to fields whose `uri_scheme` is `private`). When rendering, it builds the real `private://` URI, runs it through the `encrypted_link_formatter.crypter` service, and outputs a link of the form `private://$$/<encoded>`. A route subscriber repoints core's `system.files` and `system.private_file_download` routes to `EncryptedFileDownloadController::download`, which splits on `$$/`, decrypts the tail, reconstructs the `private://…` URI, and returns a `BinaryFileResponse`. Two modes exist: `base64` (encoding only) and `aes-128-cbc` (OpenSSL AES-128-CBC using the admin-entered `seed` as the raw key and a single site-wide IV stored in `private://iv/iv.bin`); `hook_cron` rotates the IV every 1–24h when AES is selected. Configure at `/admin/config/system/crypt-settings` (`administer site configuration`).

Security note: this is URL obfuscation, not an access-control layer. The base64 mode is reversible by anyone; the AES mode uses the seed verbatim as key with one static IV (weak, low-entropy defaults — the shipped default seed is `your_private_key_here`). Actual file access is still delegated to `hook_file_download`, so it does not by itself keep unauthorized users out — and see the controller finding about the `Content-Disposition` header being set before the `count($headers)` access gate. Treat it as link tidying/obfuscation, not confidentiality.
---
Encrypted link formatter is a field formatter plus a file-download controller override for private files.
---
- Format a private file field as an encrypted download link
- Format a private image field's download link
- Choose base64 (encode-only) URL obfuscation
- Choose Base64 + AES-128-CBC encryption of the URL
- Set the private key (seed) used for AES encryption
- Enforce a 16-character minimum key when AES is enabled
- Set link auto-regeneration lifetime (1, 3, 6, 12, or 24 hours)
- Rotate the AES IV automatically on cron
- Add a custom link text, with token support when Token is installed
- Add a link title attribute (tooltip)
- Open the download in a new tab
- Add the HTML5 download attribute to force download
- Append additional URL query params (token-replaced)
- Add custom CSS classes to the rendered link
- Call the crypter service from custom code to encrypt other strings
- Decrypt an incoming encrypted target in a custom controller
- Restrict the formatter to fields stored on the private:// scheme
- Invalidate encrypted links via the `encrypted_file_download` cache tag
