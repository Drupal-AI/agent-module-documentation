# File History — manual setup guide

**File History** (`file_history`) provides a Form API element (`file_history`) and
a matching file-field **widget** that let you upload a new version of a file while
keeping a history of the versions uploaded before it. It is aimed at managing
successive versions of a file — for example a configuration or data file that gets
re-processed and re-uploaded periodically — where you want to keep the older
copies around and be able to switch back to one.

The useful safety behaviour is this: when you upload a replacement, the new file
is *loaded but not made active* until you explicitly select it. If the new data
turns out to be wrong, the previous file is still there on the field, and a single
click on the select/unselect buttons rolls back to it. Uploads still run through
the standard core file validators, so the usual size and extension checks apply.

Because it is mostly a building block for developers and site builders, File
History is used in two ways: drop the `file_history` **form element** into a
custom form (setting a mandatory `#upload_location`, plus optional flags like
`#no_upload`, `#no_use`, `#no_download`, `#legacy`, and `#create_missing`), or use
the provided **field widget** on an ordinary file field. Retained (non-public)
files are downloaded through a dedicated route, `/file_history/download/{file}`,
which is gated by the module's own permission. A test submodule
(`test_file_history`) ships example forms you can learn from.

It depends on core's **File** module and targets Drupal 10.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is no central settings form for this module — you configure the element or
widget where you use it, and grant its download permission, as described below.

## How to use it

- **As a field widget:** on a file field's *Manage form display*, choose the File
  History widget so editors get the upload-with-history behaviour.
- **As a form element:** in custom Form API code, add an element of
  `'#type' => 'file_history'`, set the required `#upload_location`, and use the
  optional flags to hide the upload, use, or download affordances as needed. The
  `test_file_history` submodule shows this in a working example form.

## Downloads and permissions

Retained managed files are served through `/file_history/download/{file}`, which
requires the module's **download** permission (labelled "download file histoy
files"). This permission lets its holder download files through that route, so
grant it only to trusted roles and keep it away from anonymous or general
authenticated users.
