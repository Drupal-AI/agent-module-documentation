# File Temporary Validator — manual setup guide

**File Temporary Validator** (`file_temporary_validator`) helps content editors
avoid the annoyance of duplicate filenames. When someone uploads a file whose name
already exists in Drupal's temporary directory, the module detects it and alerts
the editor — and, if the user has permission, offers a link to delete the existing
temporary file so the upload can proceed cleanly.

The problem it solves is a familiar one. Drupal creates a temporary file entity for
every upload and clears the unused ones on cron. When an editor has several browser
tabs open on partially finished content and re-uploads a file that is still sitting
in the temporary folder, Drupal appends a number to keep names unique — you end up
with `report_1.pdf`, `report_2.pdf`, and so on. This module heads that off at
upload time. It works even alongside file-replacement modules (Media Entity File
Replace, File Field Replace, and similar), which don't cover this particular case.

The check is enabled **per file field**, so you turn it on only where you want it.
Two things are worth knowing before you enable it widely: duplicate detection means
computing a hash over file content, which is real work during an upload the user is
waiting on — so weigh the cost on sites that accept large videos or documents. And
because it only deduplicates *temporary* files, it steers clear of the trickier
ownership and access questions that come with deduplicating permanently stored
files. This release is a **beta** (`1.0.0-beta4`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no separate configuration page** for this module. You switch the
validation on per field, described in "How to use it" below.

## Where it lives in the admin menu

File Temporary Validator adds no central settings page. You enable it on
individual file fields from **Structure → Content types (or other bundles) →
*(bundle)* → Manage form display** (or the file field's own settings), depending on
where the field's widget options are exposed.

## How to use it

1. Decide which file fields should get duplicate-filename validation — typically the
   fields your editors upload to most often.
2. On the bundle that owns the field, open its field/widget settings and turn on the
   File Temporary Validator option for that file field.
3. Save. From then on, when an editor uploads a file whose name is already present
   in the temporary directory, they'll see an alert (and a delete link, if they have
   permission to remove the existing temporary file).
