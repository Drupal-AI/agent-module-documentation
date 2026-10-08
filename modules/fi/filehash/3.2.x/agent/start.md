<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Hash — agent index

Generates and stores hashes (checksums) for every uploaded file as base fields / columns on
the core `file` entity. Enables integrity checks, de-duplication, tokens, and an Identicon.
Depends on `file`. Defines **no permissions** of its own — admin pages use
`administer site configuration`. Configure route: `filehash.admin`
(`/admin/config/media/filehash`).

- **Enable algorithms, dedupe, autohash/rehash, original hash, MIME filter, config keys** →
  [configure/settings.md](configure/settings.md)
- **Drush: generate, clean, report** → [drush/commands.md](drush/commands.md)
- **Service, field type & formatters, tokens, Views filter, per-field dedupe validator** →
  [api/service.md](api/service.md)

Key facts:
- All config lives in `filehash.settings`. `algorithms` is a map of 18 booleans (default all
  `false` → no hashing until you enable one).
- Enabling an algorithm (or `original`) fires a config `onSave` subscriber that **adds a DB
  column** to `file_managed` immediately; disabling then `drush filehash:clean` drops it.
- 18 algorithms: `md5`, `sha1`, `sha224/256/384/512`, `sha512_224`, `sha512_256`,
  `sha3_224/256/384/512`, and `blake2b_128/160/224/256/384/512` (BLAKE2b needs the Sodium ext).
