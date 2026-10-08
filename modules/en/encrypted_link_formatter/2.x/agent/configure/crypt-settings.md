<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure crypt settings

Route `encrypted_link_formatter.crypt_settings` → `/admin/config/system/crypt-settings` (`administer site configuration`). Requires the site's **private file system** to be configured.

Config object `encrypted_link_formatter.settings`:
- `seed` — private key. Required. Min 16 chars when AES is selected. Default ships as `your_private_key_here` — change it.
- `enc_types` — `base64` (encode only) or `aes-128-cbc` (Base64 + AES-128-CBC).
- `enc_lifetime` — seconds (3600–86400); only meaningful for AES; cron rotates the IV after this age.

Selecting AES writes a random IV to `private://iv/iv.bin` (via `openssl_random_pseudo_bytes(openssl_cipher_iv_length())`) and invalidates the `encrypted_file_download` cache tag.

Apply the formatter: on a file/image field's *Manage display*, pick **Encrypted file download**. It only appears for fields on the `private://` scheme (`isApplicable()`).

drush config example:
```
drush cset encrypted_link_formatter.settings enc_types aes-128-cbc -y
drush cset encrypted_link_formatter.settings seed 'a-strong-32-char-secret-value___' -y
```
