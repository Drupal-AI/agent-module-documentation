# File Upload Options — manual setup guide

**File Upload Options** (`file_upload_options`) gives you control over what happens
when an uploaded file or image has the **same name as an existing file** — a case
core Drupal handles inconsistently. Configured **per field** and grouped by entity
type, it lets you decide the behavior (for example, re-using an existing file entity
with the same URI instead of creating a brand-new one and appending a number).

A key design choice: the module works with **all** file fields without replacing
your existing widgets or field types. It does its work by altering the underlying
file handling rather than the upload UI, so you don't have to swap widgets to get
the behavior. It also extends to file uploads made over **REST**, applying the same
same-name handling and file-reuse options there.

Because upload behavior is a security-relevant area, keep this framing in mind while
you configure it: **a file's allowed extensions are the primary control on what a
site accepts**, and Drupal enforces the *extension* list (not the file's claimed
MIME type). Any change that widens what may be uploaded is adjusting a security
boundary, not just a convenience — so treat per-field or per-role relaxations with
the same care as a permission grant. The module's own settings sit behind an
`administer file upload options` permission, correctly marked as a restricted-access
permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the administration permission.
2. [Configuration](configuration/index.md) — the settings form, where you set
   same-name handling per field and register code-defined fields.

## Where it lives in the admin menu

Once enabled, the settings live at **Configuration → Media → File Upload Options**
(`/admin/config/media/file-upload-options`). Only users with the **Administer file
upload options** permission can reach it.
