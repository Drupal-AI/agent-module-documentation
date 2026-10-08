# Existing Filename Sanitizer — manual setup guide

**Existing Filename Sanitizer** (`existing_filenames_sanitizer`) is a developer /
site‑maintenance tool that cleans up the names of files you've **already
uploaded**. Drupal core can sanitize filenames on upload (transliterating
accents, lowercasing, replacing spaces, and so on), but that setting only affects
new files. If you turn it on later — or inherit a site with a pile of legacy files
whose names contain spaces, non‑ASCII characters, or other awkward characters —
the old files keep their messy names. This module gives you a Drush command to
bring them into line in bulk.

It works on permanent file entities, and it's built to be run safely: there's a
**dry‑run mode** so you can preview exactly what would change before committing,
**conflict detection** so it won't overwrite one file with another, graceful
handling of temporary or missing files, and detailed progress logging as it goes.
The sanitization options — transliteration, lowercasing, whitespace handling —
are configurable so you can match core's behaviour or your own conventions.

This is a **data‑integrity operation**: it renames files on disk and updates the
references to them. Treat it with the same care as any bulk change — **back up
your files and database first**, run a dry run to review the plan, and verify
afterwards that links and images still resolve. As a side benefit, cleaner
filenames reduce the risk that special characters cause trouble in downstream
processing. The module has no access‑control role. It depends on core's **File**
and **System** modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** — the module is driven entirely from the
command line via Drush, described below.

## Where it lives in the admin menu

Existing Filename Sanitizer adds no admin page. It's run from the command line
with Drush.

## How to use it

1. **Back up first.** Renaming files is not easily undone, so take a backup of
   both your files directory and your database before you begin.
2. **Preview with a dry run.** Run the module's Drush command in dry‑run mode to
   see which files *would* be renamed and to what, without changing anything.
   Review that list.
3. **Run it for real.** Once you're happy with the preview, run the command again
   to apply the changes. It processes files in bulk, detects conflicts to avoid
   overwriting, skips temporary or missing files gracefully, and logs its
   progress.
4. **Verify.** Spot‑check pages and media that referenced the renamed files to
   confirm the links and images still resolve.

For the exact command name and its options (dry‑run flag, transliteration,
lowercasing, whitespace handling), run Drush's help for the module's command, e.g.
`drush list --filter=existing_filenames_sanitizer`, or see the project page.
