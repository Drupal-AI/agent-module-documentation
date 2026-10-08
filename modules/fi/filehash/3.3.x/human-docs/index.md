# File Hash — manual setup guide

**File Hash** (`filehash`) generates and stores cryptographic hashes (checksums)
for every file uploaded to your site. A file's hash uniquely identifies it by its
contents, so you can detect duplicate files, verify a downloaded copy against the
original, and give files a content-addressable identifier for archival or audit
systems.

When you enable one or more of its 18 supported algorithms — MD5, SHA‑1, the SHA‑2
and SHA‑3 families, and the Sodium-based BLAKE2b family — File Hash adds a base
field (and a matching column on the `file_managed` table) to core's `file` entity
for each algorithm, and computes it automatically whenever a file is saved. Those
hashes are then available to themes, Views, tokens, and other modules.

Beyond hashing, it can enforce **de-duplication**: a per-file-field setting adds an
upload validator that rejects an upload whose hash already exists. It also provides
a Views filter for finding duplicates, three field formatters (including an
**Identicon** avatar generated from a file's hash), file **tokens** for use in
paths or emails, and Drush commands to backfill or clean up hashes.

The module does not hash anything until you enable at least one algorithm on its
settings form — out of the box all algorithms are off. It depends only on core's
**File** module and defines no permissions of its own (its admin pages use the core
*Administer site configuration* permission).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and (optionally) the Sodium/Identicon extras.
2. [Configuration](configuration/index.md) — choose algorithms, set up
   de-duplication, MIME filtering, and the other options, plus the Drush commands.

## Where it lives in the admin menu

File Hash's settings form is at **Configuration → Media → File Hash**
(`/admin/config/media/filehash`). De-duplication can additionally be set per file
field, on each file field's settings under **Structure → … → Manage fields**.
