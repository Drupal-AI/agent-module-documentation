# Configuration

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (File Hash
   defines no permission of its own).
2. Go to **Configuration → Media → File Hash**, or navigate directly to
   `/admin/config/media/filehash`.

All of the module's configuration lives in the `filehash.settings` object, edited on
this one form.

## Choose hash algorithms

The heart of the form is the list of **18 algorithms** you can enable:

- **MD5** and **SHA‑1** — fast, legacy-compatible (not for security-critical use).
- **SHA‑2 family** — `sha224`, `sha256`, `sha384`, `sha512`, plus `sha512_224` and
  `sha512_256`.
- **SHA‑3 family** — `sha3_224`, `sha3_256`, `sha3_384`, `sha3_512`.
- **BLAKE2b family** — `blake2b_128/160/224/256/384/512` (these require the Sodium
  PHP extension or the `paragonie/sodium_compat` polyfill).

Tick as many as you need — for example MD5 for legacy compatibility alongside
SHA‑512 for strength. **Important:** enabling an algorithm immediately adds a new
column to the `file_managed` table (via a config event subscriber), and new uploads
are hashed with it from then on.

## Other options

- **Original hash** — keep the hash of the file exactly as it was originally
  uploaded, even if other modules later modify (reprocess) the file. Useful for
  matching processed derivatives back to their source.
- **Always rehash file when saving** — recompute the live hash every time a file is
  saved, so it stays in sync with files modified by other modules.
- **Autohash** — automatically generate any missing hashes when files are loaded.
- **Suppress warnings** — silence log warnings about files that are missing or
  unreadable (`suppress_warnings`).
- **MIME types** (`mime_types`) — restrict hashing to specific MIME types, so
  irrelevant files are skipped.
- **Exclude MIME types** (`mime_types_exclude`, new in 3.3) — flip the MIME list from
  an *allow*-list into a *deny*-list, so the listed types are the ones **skipped**
  instead of the only ones hashed.

Click **Save configuration** when done.

## Prevent duplicate uploads (de-duplication)

File Hash can reject uploads whose contents already exist on the site. There are two
places to control this:

- **Site-wide**, via a checkbox on the File Hash settings form.
- **Per file field**, via a setting on each file field (under **Structure → …
  → Manage fields → your file field**) with three modes:
  - **Off** — no duplicate checking on this field.
  - **Enabled** — reject an upload whose hash matches an existing *permanent* file.
  - **Strict** — also reject duplicates among *temporary* files (catches
    simultaneous uploads).

Per-field settings let only certain upload fields reject duplicates. Note the
project describes the duplicate-prevention feature as a proof-of-concept — the UX for
a rejected upload is basic — so test it against your workflow.

## Tokens, formatters, and Views

Each enabled algorithm exposes file **tokens** you can use in filenames, emails, or
config — for example `[file:filehash-sha256]`, plus two-character "pairtree" variants
`[file:filehash-sha256-pair-1]` / `-pair-2` useful for content-addressable storage
directory structures. Three **field formatters** are provided, including a
`filehash_table` (files with their hashes) and a `filehash_identicon` (an avatar
image generated from the hash). A **Views filter**, `filehash_has_duplicate`, lets
you build a listing of only files that have a duplicate.

## Drush commands

File Hash ships three Drush commands for maintenance:

| Command | What it does |
|---------|--------------|
| `drush filehash:generate` | Backfill hashes for files that existed before you enabled an algorithm. |
| `drush filehash:clean` | Drop the database columns for algorithms you have disabled. |
| `drush filehash:report` | List all duplicate files currently on the site. |

The typical lifecycle is: enable an algorithm → run `filehash:generate` to backfill
existing files; later, disable an algorithm → run `filehash:clean` to remove its
now-obsolete column.
