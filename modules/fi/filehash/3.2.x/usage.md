<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
File Hash generates and stores cryptographic hashes (checksums) for every file uploaded to the site, so files can be uniquely identified, duplicates detected, and copies verified against the original.

---

Once you enable one or more of its 18 supported algorithms (MD5, SHA-1, the SHA-2 and SHA-3 families, and the Sodium-based BLAKE2b family) on the settings form, File Hash adds a base field — and a corresponding column on the `file_managed` table — to the core `file` entity for each enabled algorithm, computed automatically at file create/presave. Enabling or disabling an algorithm (or the "original hash" option) is picked up by a config event subscriber that installs the new field storage definitions immediately; disabled columns are dropped later by the "Clean up" batch (`drush filehash:clean`). Hashes for pre-existing files are backfilled with the "Generate" batch (`drush filehash:generate`). Beyond hashing, the module can enforce de-duplication: a per-file-field third-party setting (Off / Enabled / Strict) adds a `FileHashDedupe` upload validator that rejects an upload whose hash already exists, and a `filehash_has_duplicate` Views filter and `drush filehash:report` surface existing duplicates. Each enabled algorithm also exposes file tokens (`[file:filehash-sha256]` and two-character `-pair-1`/`-pair-2` variants), an `original` hash variant (kept stable while "always rehash" keeps the live hash in sync with processed files), and three field formatters including an `Identicon` avatar generated from the hash. Configuration lives entirely in `filehash.settings`; the module defines no permissions of its own (the admin pages require `administer site configuration`).

---

- Store a SHA-256 hash of every uploaded file for integrity verification.
- Detect and block duplicate file uploads across the whole site.
- Prevent a user from re-uploading a file that already exists as a permanent file (dedupe "Enabled").
- Also block simultaneous duplicate uploads including temporary files (dedupe "Strict").
- Backfill hashes for files that existed before the module was enabled via `drush filehash:generate`.
- Remove obsolete hash columns after disabling an algorithm with `drush filehash:clean`.
- List all duplicate files on the site with `drush filehash:report`.
- Expose a file's hash in a token, e.g. `[file:filehash-sha256]`, for use in filenames or emails.
- Generate a unique Identicon avatar image from a file's hash using the `filehash_identicon` formatter.
- Show a table of files with their hashes using the `filehash_table` formatter.
- Verify a downloaded copy against the site's stored hash to confirm it was not corrupted.
- Uniquely identify files regardless of filename by their content hash.
- Enable multiple algorithms at once (e.g. MD5 for legacy compatibility plus SHA-512 for strength).
- Use BLAKE2b hashes when the Sodium PHP extension is available for fast modern hashing.
- Keep hashes in sync with files modified by other modules by enabling "Always rehash file when saving".
- Preserve the hash of the originally uploaded file with the "original" hash option while still rehashing derivatives.
- Include original hashes in the duplicate check so processed derivatives are matched against source uploads.
- Restrict hashing to specific MIME types via the `mime_types` setting to skip irrelevant files.
- Automatically generate any missing hashes when files are loaded by enabling `autohash`.
- Build a View of files filtered to only those that have a duplicate hash (`filehash_has_duplicate`).
- Suppress log warnings for nonexistent or unreadable files with `suppress_warnings`.
- Add a content-addressable identifier to files for external archival or audit systems.
- Detect tampering by comparing a recomputed hash to the stored one.
- Provide per-file-field dedupe policy so only certain upload fields reject duplicates.
