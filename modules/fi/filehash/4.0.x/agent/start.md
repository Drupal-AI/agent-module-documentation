<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Hash — agent index

Generates and stores hashes (checksums) for every uploaded file as base fields / columns on
the core `file` entity. Enables integrity checks, de-duplication, tokens, and an Identicon.
Depends on `file`. Defines **no permissions** of its own — admin pages use
`administer site configuration`. Configure route: `filehash.admin`
(`/admin/config/media/filehash`).

- **Enable algorithms, dedupe, autohash/rehash, original hash, MIME filter (+ exclude mode), config keys** →
  [configure/settings.md](configure/settings.md)
- **Drush: generate, clean, report, benchmark** → [drush/commands.md](drush/commands.md)
- **Service, algorithm enum & state machines, field type & formatters, tokens, Views filter, per-field dedupe validator** →
  [api/service.md](api/service.md)

Key facts:
- All config lives in `filehash.settings`. `algorithms` is a map of 18 booleans (default all
  `false` → no hashing until you enable one).
- Enabling an algorithm (or `original`) fires a config `onSave` subscriber that **adds a DB
  column** to `file_managed` immediately; disabling then `drush filehash:clean` drops it.
- 18 algorithms: `md5`, `sha1`, `sha224/256/384/512`, `sha512_224`, `sha512_256`,
  `sha3_224/256/384/512`, and `blake2b_128/160/224/256/384/512` (BLAKE2b needs the Sodium ext
  or the `paragonie/sodium_compat` polyfill).
- Dedupe rejects an upload whose hash matches an existing file. Global `dedupe` (Off/Enabled/
  Strict) or per-file-field third-party setting. Runs only on initial file creation.

## What changed in 4.0.x (major bump from 3.3.x)

- **Drupal 11.3+ / 12 only.** `core_version_requirement` is now `^11.3 || ^12` — Drupal 10
  support dropped (3.3.x was `^10.2 || ^11`).
- **No procedural `.module` file.** Every hook is now an invokable OOP class under `src/Hook/`
  with the `#[Hook('...')]` attribute (`FileCreate`, `FilePresave`, `EntityStorageLoad`,
  `EntityBaseFieldInfo`, `Tokens`, `TokenInfo`, `ViewsDataAlter`, `Help`, `RuntimeRequirements`,
  `FieldWidgetSingleElementFormAlter`, `FormFieldConfigEditFormAlter`).
- **Enum + state-machine hashing internals.** Algorithms are a backed enum
  `Drupal\filehash\Algorithm` (implements `AlgorithmInterface`) with a `Mechanism` enum
  (`Hash` PHP ext vs `Sodium`); multi-algorithm hashing streams the file in 8 KB chunks through
  `HashStateMachine` / `SodiumStateMachine` (`StateMachineInterface`). Single Hash-extension
  algorithms use the optimized `hash_file()` path.
- **New Drush command `filehash:benchmark`** (times each enabled algorithm).
- **Dedupe violation message now gates filename disclosure** on the uploader having the
  `access files overview` permission; otherwise a generic "duplicate files are not permitted"
  message is shown.
- Identicon library suggestion bumped to `yzalis/identicon:^3.0` (was `^2.0`).
- Feature set otherwise carried forward from 3.x: `mime_types` + `mime_types_exclude`
  (allow-list ↔ deny-list), `rehash`, `original` + `dedupe_original`, `autohash`,
  `suppress_warnings`, tokens, three formatters, `filehash_has_duplicate` Views filter.
