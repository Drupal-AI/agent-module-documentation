# LMS File Upload — manual setup guide

**LMS File Upload** (`lms_file_upload`) adds a **file-upload activity type** to the
Drupal [LMS](https://www.drupal.org/project/lms) module. It provides an
ActivityAnswer plugin, which means a learner can answer a course activity by
uploading a file — an essay, a spreadsheet, a design, a scan — rather than typing
a text answer or choosing from options.

Crucially, uploaded submissions go to Drupal's **private file system**, not the
public one, so learners' files are not served directly to anyone with the URL.
Private-scheme files are access-checked on download, which is the right default for
coursework.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and make sure the private file system is configured.

LMS File Upload has no settings form of its own — you configure it per activity
within a course (see "How to use it"). It adds no access-control role beyond the
LMS course/activity access and core's file access.

## Getting it right (a short checklist)

- **Configure the private file system.** Because submissions use the private
  scheme, Drupal's private files path must be set up (in `settings.php`), or
  uploads will have nowhere to go. See Installation.
- **Restrict download access.** Confirm that only the appropriate people — the
  learner who submitted and their instructor — can download a submission.
- **Keep allowed file extensions restricted.** As with any user upload, limit the
  allowed file types (core's upload validation handles this) so learners cannot
  upload dangerous file types.

## How to use it

1. Ensure the private file system is configured and LMS is set up.
2. In a course, create or add a **file-upload** activity (the type this module
   provides).
3. Set the activity's allowed file extensions and any size limits.
4. Learners then answer that activity by uploading a file, which is stored
   privately and made available to the learner and instructor for review.
