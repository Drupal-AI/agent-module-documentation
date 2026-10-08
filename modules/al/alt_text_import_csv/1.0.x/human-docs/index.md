# Alt Text Import CSV — manual setup guide

**Alt Text Import CSV** (`alt_text_import_csv`) lets you **bulk-update the
alternative text of image/media items from a CSV file**. You prepare a spreadsheet
that maps media items to their new alt-text values, upload it, and the module
applies the changes across your site — ideal for accessibility remediation at
scale, when you have a lot of images to fix at once.

It is a content/accessibility tool for editors and administrators, gated by the
module's own permission. A couple of practical points: the uploaded CSV is
**untrusted input** — the values you import become field content (and follow
Drupal's normal field sanitisation when displayed) — and the import edits media
across the whole site, so run it as a **trusted operator** and double-check your
spreadsheet before uploading. The module has no role in access control beyond its
permission.

It depends on core **Media** and **Path**, plus the **Entity Usage** and
**Multivalue Form Element** contrib modules, and supports Drupal 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and grant the permission.

## How to use it

1. Grant the module's alt-text-import permission to the trusted roles that should
   run imports (**People → Permissions**), then log in as such a user.
2. Prepare a CSV that maps each media item to its new alternative text.
3. Open the module's import page, **upload the CSV**, and run the import.
4. The listed media items have their alt text updated from the file.

Because the import writes to media across the site, review your CSV carefully
first and treat the operation as a trusted, deliberate action.
