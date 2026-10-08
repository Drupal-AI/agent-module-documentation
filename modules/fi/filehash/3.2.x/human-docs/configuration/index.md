# Configuration

All of File Hash's behaviour lives on one settings form (plus two sibling batch tabs) and
is stored in the `filehash.settings` config object.

## Open the settings form

Go to **Configuration → Media → File Hash** (`/admin/config/media/filehash`). You need
the **Administer site configuration** permission. Two related tabs sit beside it:
**Generate** (`/admin/config/media/filehash/generate`) and **Clean up**
(`/admin/config/media/filehash/clean`).

## Choose the hash algorithms

- **Algorithms** (`algorithms`, all off by default) — tick each algorithm you want to
  compute and store. Turning one on adds a matching column to the `file_managed` table and
  starts hashing new uploads. You can enable several at once (for example MD5 for legacy
  compatibility plus SHA‑512 for strength).

  The 18 available algorithms are: `md5`, `sha1`, `sha224`, `sha256`, `sha384`, `sha512`,
  `sha512_224`, `sha512_256`, `sha3_224`, `sha3_256`, `sha3_384`, `sha3_512`, and the
  Sodium‑based `blake2b_128`, `blake2b_160`, `blake2b_224`, `blake2b_256`, `blake2b_384`,
  `blake2b_512`. The BLAKE2b options need the **Sodium** PHP extension.

> **Important:** enabling an algorithm adds a database column, and *disabling* one leaves
> its column in a "pending delete" state until you run the **Clean up** batch (see
> below). Saving the form is what actually creates or schedules removal of columns.

## De‑duplication

- **Disallow duplicate files** (`dedupe`, default *Off*) — a global policy:
  - **Off** — hashes are stored but duplicates are allowed.
  - **Enabled** — reject an upload whose hash matches an existing **permanent** file.
  - **Strict** — also reject matches against **temporary** files (catches simultaneous
    duplicate uploads).
- **Match original hashes too** (`dedupe_original`, default off) — when checking for
  duplicates, also compare against other files' stored *original* hash. Requires the
  **original** option (below) and a dedupe policy above *Off*.

You can also set a de‑duplication policy **per file/image field** (independent of the
global setting): each field's *Field settings* form gains a "Disallow duplicate files"
radio (Off / Enabled / Strict), so only certain upload fields reject duplicates.

## Other options

- **Always rehash file when saving** (`rehash`, default off) — recompute the hash on
  every save. Turn this on if other modules modify files after upload; leave it off to
  hash the originally‑uploaded bytes once.
- **Store original hash** (`original`, default off) — keep an extra, never‑updated
  `original_<algo>` hash per algorithm. Only useful together with **rehash**, so you keep
  the source file's fingerprint even as derivatives change.
- **Generate missing hashes on load** (`autohash`, default off) — when a file is loaded,
  fill in any hashes it's missing. A gentle way to self‑heal older files over time.
- **MIME types** (`mime_types`, default empty = all) — if you list one or more MIME
  types, only files of those types are hashed; everything else is skipped.
- **Suppress warnings** (`suppress_warnings`, default off) — stop logging warnings for
  files that are missing or unreadable.

Click **Save configuration** to apply.

## Setting values from the command line

```bash
# Enable SHA-256 (adds the file_managed.sha256 column on save)
drush php:eval '$c=\Drupal::configFactory()->getEditable("filehash.settings");
  $a=$c->get("algorithms"); $a["sha256"]=TRUE; $c->set("algorithms",$a)->save();'

# Global strict de-duplication
drush config:set filehash.settings dedupe 2 -y

# Turn on auto-hash of missing hashes at load time
drush config:set filehash.settings autohash 1 -y
```

## The Drush commands

File Hash adds three commands (run with `ddev drush …` from a DDEV host):

| Command | Aliases | What it does |
|---------|---------|--------------|
| `filehash:generate` | `fgen`, `filehash-generate` | Back‑fill hashes for **existing** files that don't have them yet — run this after enabling an algorithm, or after installing on a site that already has files. |
| `filehash:clean` | `filehash-clean` | Drop the `file_managed` columns for algorithms you have **disabled**. Run it after un‑ticking an algorithm. |
| `filehash:report` | — | Print a table of duplicate files (files sharing a hash). Options: `--limit` (default 1000), `--algorithm` (defaults to the last enabled one), `--format` (`table`/`json`/`csv`). |

```bash
drush filehash:generate                       # backfill missing hashes
drush filehash:clean                          # drop columns for disabled algorithms
drush filehash:report --algorithm=sha256 --limit=50
```

The Generate and Clean up actions are also available as batch operations on the
**Generate** and **Clean up** tabs of the settings page.

## Using the hashes

Once an algorithm is enabled, its hash is available in several places:

- **Tokens** — e.g. `[file:filehash-sha256]` for the full hash, plus `-pair-1` / `-pair-2`
  variants (the first/second pair of hex characters, handy for sharded directory paths).
- **Field formatters** — attach to the hash base fields: plain text, a `filehash_table`
  (a table of files with their hashes), or `filehash_identicon` (an avatar drawn from the
  hash, which uses the optional `yzalis/identicon` library).
- **Views** — a "Has duplicate `<algo>` hash" filter lets you build a view of files that
  share a hash with another file.
