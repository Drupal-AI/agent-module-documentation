<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Encrypts the description of selected Events Log Track (ELT) log entries with a public key so sensitive log data is protected at rest and only decryptable offline with the matching private key.

---

Event Log Track Encrypt extends the Events Log Track (ELT) module so that the `description` portion of chosen
log entries is encrypted before it is written to the `event_log_track` table. It uses public-key cryptography
built on Drupal's Encrypt and Key frameworks: a public key (stored in a Key entity, in an Encrypt profile) seals
the text via PHP's `openssl_seal()` with AES256, and only whoever holds the matching private key can read it
back. The encrypted string is wrapped in `@@crypt@@ … @@endcrypt@@` tags so it is easy to locate. There is no
web-based decryption UI on purpose — the private key never needs to live on the server. Instead the module ships
three Drush commands (`elt:decrypt-db`, `elt:decrypt-file`, `elt:decrypt-string`) that take the private-key file
path and prompt for its passphrase to decrypt records from the database, a rotated log file, or a single string.
Which ELT event types get encrypted is chosen in an "Encryption" section the module adds to the ELT settings
form; encryption is off by default and nothing is encrypted until an admin selects event types.

---

- Protect sensitive values that land in ELT log descriptions (e.g. a config change containing credentials) at rest in the database.
- Keep a full, lossless audit trail while making the sensitive part of each entry unreadable to anyone without the private key.
- Encrypt only specific ELT event types (config, user, node, taxonomy, media, file, group, workflows, menu, comment, cache_clear, authentication, authorization).
- Store logs so that even a database dump or DB-level read exposure does not reveal the encrypted descriptions.
- Ensure the private key never resides on the web server — decryption happens offline via Drush.
- Decrypt the entire `event_log_track` table to screen with `drush elt:decrypt-db --private-key-file=…`.
- Export decrypted log rows to a CSV file with the `--output-file` option of `elt:decrypt-db`.
- Decrypt only a subset of rows using `--condition` filters (e.g. `"type LIKE co%"`, `"uid > 1"`) and `--limit`.
- Point decryption at a sharded/suffixed log table with `--table-suffix` for very large log volumes.
- Decrypt an exported or rotated ELT log file with `drush elt:decrypt-file --private-key-file=… /path/to/file.log`.
- Decrypt a single captured ciphertext string with `drush elt:decrypt-string --private-key-file=… <string>`.
- Comply with data-protection requirements by encrypting personal or sensitive data captured in activity logs.
- Reuse an existing OpenSSL RSA public/private key pair (2048-bit RSA, AES-encrypted private key) generated with the `openssl` CLI.
- Rotate the public key by editing the shipped `Event log track public key` Key entity at `/admin/config/system/keys`.
- Turn encryption on or off site-wide from the ELT settings form without uninstalling the module.
- Add a "Public key (PEM)" Key type and an "OpenSSL Public Encrypt" encryption method usable by the Encrypt framework.
- Integrate log encryption into an existing ELT deployment without changing how logs are recorded.
- Locate encrypted segments in exported logs quickly via the `@@crypt@@`/`@@endcrypt@@` markers.
- Meet the "encrypt sensitive audit data" control on sites that already run Events Log Track.
- Prevent site administrators or DB operators without the private key from reading protected log descriptions.
- Keep unencrypted metadata (type, path, user, IP, timestamp) readable for triage while only the description is sealed.
- Support redacting credentials that would otherwise appear in ELT config-change diffs.
