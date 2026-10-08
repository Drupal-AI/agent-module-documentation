<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush decryption commands

Service `event_log_track_encrypt.commands` (`drush.services.yml`) →
`src/Commands/EventLogTrackDecryptCommands.php` (extends `DrushCommands`), constructed with
`@database` and `@module_handler`. CLI only — there is no web decryption interface.

All three commands need the **private key** (matching the public key used to encrypt) and prompt
for its passphrase via `io()->askHidden()` (no echo). `openssl_pkey_get_private()` opens it; a bad
key or passphrase throws. The private key file is read from disk (`--private-key-file`) and is
never stored by the module.

## Decryption internals

- `decrypt()`: splits the `,`-separated envelope into `sealed,ekey,iv`, base64-decodes each, and
  calls `openssl_open($data, $out, $ekey, $privateKey, 'AES256', $iv)`. If the envelope does not
  have exactly 3 parts it is returned unchanged; if `openssl_open` fails it throws
  *"Decryption failed !"*.
- `findAndDecrypt()`: `preg_replace_callback` over `@@crypt@@(.*)@@endcrypt@@`, decrypting each
  match and restoring newlines as `#012` / `#015` (matching ELT's log encoding).

## `elt:decrypt-string` (alias `eltds`)

`decryptString($encryptedString, $options)`. Decrypts a **single raw ciphertext** (the value
*between* the tags, tags omitted).

```bash
drush eltds --private-key-file=/var/keys/event_log_track_private_key.pem '<sealed>,<ekey>,<iv>'
```

## `elt:decrypt-file` (alias `eltdf`)

`fileDecrypt($logFile, $options)`. Streams a log file line by line, decrypting any tagged
segments. Options: `--private-key-file`, `--output-file` (write instead of echo; prompts before
overwriting an existing file). Errors if the log file is missing or unreadable.

```bash
drush eltdf --private-key-file=/var/keys/...pem --output-file=/home/me/out.log /home/me/in.log
```

## `elt:decrypt-db` (alias `eltddb`)

`dbDecrypt($options)`. Queries the `event_log_track` table, decrypts each row's `description`, and
echoes ` | `-joined rows or writes CSV (`fputcsv`). Options:

- `--private-key-file` — private key path.
- `--output-file` — CSV output (prompts before overwrite).
- `--table-suffix` — query `event_log_track_<suffix>` instead; suffix validated
  `^[0-9a-zA-Z]+$`; table existence checked.
- `--limit` — validated `^[0-9]+$`, applied as `range(0, limit)`.
- `--condition` (repeatable) — `"<field> <operator> <value>"`. `field` must be a real
  `event_log_track` column (validated against `event_log_track_schema()`); `operator` must be one
  of `= != < > <= >= LIKE` (LIKE only for varchar/text columns, comparisons only for int/serial);
  `value` is bound as a parameter via `$query->condition()`. Multiple conditions AND together.

```bash
drush eltddb --private-key-file=/var/keys/...pem \
  --condition="type LIKE co%" --condition="uid > 1" --limit=1000 \
  --output-file=/home/me/extract.csv
```

## Related docs

- What produces the `@@crypt@@…@@endcrypt@@` payloads → [../plugins/encryption.md](../plugins/encryption.md)
- Turning encryption on → [../config/settings.md](../config/settings.md)
