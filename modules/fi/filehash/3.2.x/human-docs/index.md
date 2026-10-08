# File Hash — manual setup guide

**File Hash** (`filehash`) computes and stores a cryptographic **hash** (checksum) for
every file uploaded to your site. A hash is a short fingerprint of a file's contents, so
storing one lets you uniquely identify files regardless of their name, detect duplicates,
and verify later that a copy hasn't been corrupted or tampered with.

You pick which algorithm(s) to use from a list of 18 — MD5, SHA‑1, the SHA‑2 and SHA‑3
families, and the modern Sodium‑based BLAKE2b family. When you enable an algorithm, File
Hash adds a real column to the `file_managed` table and fills it in automatically as
files are created. Existing files can be back‑filled with a Drush command. Beyond plain
hashing, the module can **block duplicate uploads** (globally, or per file field, with an
"Enabled" or "Strict" policy), surface duplicates through a Drush report and a Views
filter, expose each file's hash as a **token**, and even render an **Identicon** avatar
generated from the hash.

File Hash depends only on core's **File** module and defines no permissions of its own —
its admin pages use the standard *Administer site configuration* permission. It works on
Drupal 10.2+ and 11. All of its behaviour is controlled from one settings form, so this
guide walks through that plus the Drush commands.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module, and
   the optional Identicon library.
2. [Configuration](configuration/index.md) — enable algorithms, set the de‑duplication
   policy, the other options, and the Drush commands (generate / clean / report).

## Where it lives in the admin menu

The settings form is at **Configuration → Media → File Hash**
(`/admin/config/media/filehash`), with sibling **Generate** and **Clean up** tabs. All
of these require the *Administer site configuration* permission.

## How to use it

1. Enable the module.
2. Open the settings form and tick at least one algorithm (e.g. SHA‑256). This is what
   creates the hash column and starts hashing new uploads.
3. If you already have files, run `drush filehash:generate` to back‑fill their hashes.
4. Optionally turn on de‑duplication, tokens, or the Identicon formatter.

See [Configuration](configuration/index.md) for the full walkthrough.
