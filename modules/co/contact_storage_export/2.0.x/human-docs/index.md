# Contact Storage Export — manual setup guide

**Contact Storage Export** (`contact_storage_export`) adds a one-click **Export**
option to every contact form so the submissions you've stored (via the Contact
Storage module) can be downloaded as a CSV file. It's the straightforward way to get
contact-form leads, feedback, or signup data out of Drupal and into a spreadsheet,
CRM, or mail-merge tool — without building a separate View for each form.

Each contact form gains an **"Export submissions"** operation on the contact-forms
admin list. Running it opens a short form where you choose exactly which columns to
include, the date format for created/date fields, the download filename, and — handy
for periodic exports — whether to export **only new messages since the last export**.
The export understands your field types and formats them sensibly: link fields become
absolute URLs, entity references become their labels, date/created/date-range fields
use your chosen format, multi-value fields (like checkboxes) come through correctly
in a single row, and base data (submitter, date submitted, the logged-in user) is
included alongside your custom fields. Large result sets are handled in batches to
avoid timeouts, and the finished file is streamed to you as a download (kept in a
private file where a private filesystem is configured).

There is **no settings page** and no persisted configuration — every export picks its
options fresh — so setup is just installing the module and granting the permission.
It defines a single permission, **Export contact form messages**, and depends on
core **Contact**, plus the **Contact Storage** and **CSV Serialization** contrib
modules (which store the submissions and encode the CSV). It ships no submodules.

This guide is written for a **human** using the module through the admin UI. If you
want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module
   and its dependencies, and grant the permission.

## Where it lives in the admin menu

- The **Export submissions** operation appears on each contact form's row at
  **Structure → Contact forms** (`/admin/structure/contact`).
- The export form itself is at `/admin/structure/contact/manage/export`.

Both require the **Export contact form messages** permission.

## How to use it

1. Enable the module (and make sure Contact Storage is capturing submissions).
2. Grant **Export contact form messages** to the roles that should be able to
   download data — the module is designed so you can give this to non-administrator
   editors.
3. Go to **Structure → Contact forms**, and on the form you want, choose **Export
   submissions**.
4. On the export form, optionally tick **Only export new messages since the last
   export**, then open **Advanced** to choose the **columns** to include (the `uuid`
   field is always excluded; all others are selected by default), the **file name**
   (must end in `.csv`), and the **created date format**.
5. Submit. The export runs as a batch (25 messages per step) and then hands you the
   CSV download.

**"Since last export" watermark:** the highest exported message id is remembered per
form (in Drupal's key/value store), so a subsequent "since last export" run only
includes newer submissions. Re-exporting everything resets that watermark.

**Access and storage notes:** the export honours entity access on the messages, so
users only export what they're allowed to see. Files are written to a private
directory when one is configured (otherwise a temporary directory) and are cleaned up
automatically after download.
