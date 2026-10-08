# File Uploader — manual setup guide

**File Uploader** (`file_uploader`) is a **JavaScript upload framework** for Drupal
— not a finished widget you drop onto a field, but a foundation other modules build
richer upload experiences on. It supplies three things: a **render/form element**
that integrates with Drupal's managed-file element, an **uploader plugin type** so
different front-end libraries can be plugged in, and an **XHR upload endpoint** at
`/file-uploader/upload` for uploading files in the background instead of via a full
form submit.

Why a framework? Drupal's stock managed-file element does a full page submit per
upload, which is fine for a single attachment but poor for a drag-and-drop area
handling twenty files with per-file progress. Building that well means an XHR
endpoint plus the validation and access checks that keep it safe — work that is easy
to get wrong and gets re-written on every project. File Uploader does that groundwork
once. Its endpoint is a good example of doing it right: it carries **both** a real
custom access check **and** a CSRF token, rather than a flat permission.

Because it is a framework, **enabling it alone doesn't give editors a new upload
experience** — you pair it with an *integration module* that provides an actual
widget. The main one is
[**File Uploader by Uppy**](https://www.drupal.org/project/file_uploader_uppy)
(`file_uploader_uppy`), which adds drag-and-drop, progress, previews and resumable
uploads. You can also build your own integration by extending the framework's
widget base and implementing an uploader plugin.

One thing the framework does **not** do is decide what is safe to accept — that is
still the field's job. Where uploads come from untrusted users, pair it with
validators such as **File MIME Validator** and **SVG Upload Sanitizer**. The module
has core-only dependencies and supports **Drupal 9, 10, and 11**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and add an integration module so you get an actual upload widget.

There is **no configuration page** for the framework itself. Configuration happens
in whichever integration module you install (for example, the Uppy widget is set up
on a field's *Manage form display*).

## Where it lives in the admin menu

File Uploader adds no admin settings page. It provides an element and an endpoint
for other modules; you interact with it indirectly, through an integration module's
field widget.

## How to use it

1. Install and enable File Uploader (see [Installation](installation/index.md)).
2. Install an **integration module** — most commonly **File Uploader by Uppy** —
   *or* build a custom integration by extending the framework's widget base and
   implementing an uploader plugin (see the module's `file_uploader.api.php` for the
   contract).
3. Configure the integration's widget on your file field (for Uppy, on the entity's
   **Manage form display**).
