<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Event Log Track Encrypt (event_log_track_encrypt) — agent index

Encrypts the **`description`** of selected **Events Log Track (ELT)** log entries with a **public
key** before they are stored, so sensitive audit data is protected at rest. Package `Logging`.
Core `^10 || ^11`. License GPL-2.0-or-later. Version 1.0.0.

Depends on three contrib modules: **`event_log_track`** (Events Log Track, `^4.0@beta`), **`encrypt`**
(`^3.1`) and **`key`** (`^1.17`). Requires the PHP **OpenSSL** extension.

- **Config objects, schema, the ELT form additions, the shipped Encrypt profile + Key entity, and how to enable encryption** →
  [config/settings.md](config/settings.md)
- **The encryption method plugin, the PEM KeyType plugin, and the encrypt-on-write hook** →
  [plugins/encryption.md](plugins/encryption.md)
- **The three Drush decryption commands and their options** →
  [drush/decrypt-commands.md](drush/decrypt-commands.md)

## What it actually is

- No routes, no controllers, **no permissions**, no entities of its own, no settings form of its
  own. It hooks into ELT.
- Two plugins:
  - `OpenSslPublicEncryptMethod` (Encrypt `@EncryptionMethod` id **`openssl_public_encrypt`**,
    `src/Plugin/EncryptionMethod/`) — seals text with a public key via `openssl_seal()` / AES256.
  - `PemPublicFormatKeyType` (Key `@KeyType` id **`public_pem`**, `src/Plugin/KeyType/`, extends
    `PemFormatKeyTypeBase`) — a PEM public-key key type in group `encryption`.
- One helper value object: `Tags\EncryptTags` — constants `TAG_START` = `@@crypt@@`,
  `TAG_END` = `@@endcrypt@@` that wrap every ciphertext.
- Three Drush commands (service `event_log_track_encrypt.commands`,
  `src/Commands/EventLogTrackDecryptCommands.php`): `elt:decrypt-db` (eltddb), `elt:decrypt-file`
  (eltdf), `elt:decrypt-string` (eltds). CLI only; require the **private key** file + passphrase.

## Mechanism (from source)

- `hook_event_log_track_alter(&$log)` in `event_log_track_encrypt.module`: for each log whose
  `type` is checked in config `event_log_track.encrypt.settings:event_types_to_encrypt`, it loads
  the Encrypt profile **`event_log_track_encryption`**, calls the `encryption` service
  `encrypt($log['description'], $profile)`, and rewraps the result as
  `@@crypt@@<ciphertext>@@endcrypt@@`. Only `description` is touched; all other columns stay plain.
- Encryption is **one-way on the server**: the profile uses the public key; the plugin's
  `decrypt()` deliberately returns the input unchanged. Decryption requires the private key and is
  done offline through the Drush commands.
- `hook_form_events_track_form_alter()` adds an **Encryption** fieldset (an *Enable encryption*
  checkbox + a per-event-type checkbox list) to the ELT settings form and saves them via the
  `_event_log_track_encrypt_form` submit handler into `event_log_track.encrypt.settings`.

## Config & install artifacts

- Config object **`event_log_track.encrypt.settings`** — `enable_encrypt` (bool) +
  `event_types_to_encrypt` (13 booleans). Schema in `config/schema/event_log_track_encrypt.schema.yml`.
- Shipped on install (`config/install/`): Encrypt profile
  `encrypt.profile.event_log_track_encryption` (method `openssl_public_encrypt`, key
  `event_log_track_public_key`) and Key entity `key.key.event_log_track_public_key` (type
  `public_pem`, provider `config`, placeholder value `!changeMe!` you must replace with your real
  public key at `/admin/config/system/keys`).

See the linked solution docs for exact keys, values and commands.
