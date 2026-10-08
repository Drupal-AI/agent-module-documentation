<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
File Temporary Validator adds an upload validator that rejects a file when a temporary file of the same filename already exists, so editors avoid the "filename_1" rename.

---

Every Drupal upload first lands as a *temporary* file entity (status not permanent); core promotes it to permanent when the host entity is saved, and cron deletes the unused ones. If an editor has two browser tabs open on the same content and uploads the same file twice — or abandons a form and retries — the first upload is still sitting in the temporary table, so core renames the second copy `filename_1`, `filename_2`, and so on. Those appended suffixes are the problem this module targets.

It works by **filename comparison, not content hashing**. Enable the validator per file field (a checkbox added to the field's *Manage fields* edit form). When enabled, an upload validator runs on that widget: it queries the `file` entity storage for any file with the same filename whose status is not permanent (i.e. a leftover temporary file), excluding the file being uploaded. If a match is found the upload is blocked with an error message, and — for users who hold the *access files overview* permission — the message links to the Files admin view filtered to that filename so they can find and delete the stuck temporary file. The check is a single indexed entity query on filename; there is no hashing, no byte comparison, and no work proportional to file size.

Scope is narrow and deliberate: it only guards *temporary* files (not permanent, already-attached ones), only on file/managed-file widgets where a site builder has ticked the box, and it never deletes anything itself — it only reports and points the user at the delete UI. There is no settings page, no permission of its own, and no cron behaviour; the one moving part is the per-field third-party setting.

Release is **1.0.0-beta4**.

---

- Stop editors from producing `filename_1` / `filename_2` renamed uploads.
- Detect a leftover temporary file with the same name before a new upload.
- Guard a specific file field against duplicate-filename uploads.
- Guard a specific image field against duplicate-filename uploads.
- Enable duplicate-filename validation per field rather than site-wide.
- Handle the two-tabs-open re-upload scenario cleanly.
- Handle an abandoned-and-retried upload form.
- Give editors a direct link to the stuck temporary file to delete it.
- Reduce confusion from files silently gaining numeric suffixes.
- Keep filenames stable so downstream references stay predictable.
- Complement file-replacement modules (Media Entity File Replace, File Field Replace) that still leave suffixed temp files.
- Add the validator to a managed_file widget on a custom form-driven field.
- Support the managed_file_plus widget as well as core managed_file.
- Surface temporary-file build-up that cron has not yet cleared.
- Encourage editors to clear stuck temporary files instead of working around them.
- Apply validation without writing any custom code.
- Turn the check off again by unticking a single checkbox.
- Evaluate a beta module against your file-upload workflow before production.
- Document the module's filename-only matching behaviour for the team.
- Review its assumptions after a Drupal core upgrade (it swaps validator mechanism at core 10.2).
