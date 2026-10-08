# DropzoneJS — manual setup guide

**DropzoneJS** (`dropzonejs`) brings modern drag‑and‑drop file uploading to
Drupal. Instead of the plain HTML "Choose file" input, editors get a drop area
where they can drag many files at once, see image thumbnails as previews, and have
each file upload asynchronously in the background — no full page submit. It wraps
the open‑source DropzoneJS JavaScript library and exposes it to Drupal as a
reusable `dropzonejs` form element.

Under the hood the element handles client‑side file selection, size and extension
limits, and optional in‑browser image resizing, then posts each file to Drupal
where a temporary upload is created and later validated into a real file entity.
The module also plugs into the **Media Library**, replacing the default add form
for image, video, audio, and generic file media sources so that uploads there use
Dropzone too. Every upload is gated behind a single permission, **`dropzone upload
files`** — grant it to the roles that should be allowed to upload.

DropzoneJS does **not** work on enable alone. It depends on core's **File** module
(enabled automatically) and, crucially, on the **DropzoneJS JavaScript library**
(`enyo/dropzone`, v5.7.2) being present in your site's `libraries/` directory. It
has almost no dedicated admin UI — a handful of global settings surface on core's
file‑system settings form, and the real power is in placing the form element or
using the Media Library integration. It ships one submodule, **DropzoneJS Entity
Browser widget** (`eb_widget`), which turns the uploader into an Entity Browser
widget.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module, place the DropzoneJS
   library, enable it, and grant the upload permission.
2. [Configuration](configuration/index.md) — the global settings, the upload
   permission, and how Dropzone surfaces in the Media Library.

## Where it lives in the admin menu

DropzoneJS has no admin settings page of its own. Its few global settings
(`dropzonejs.settings`) are exposed on core's **file‑system settings** form at
**Configuration → Media → File system** (`/admin/config/media/file-system`), and
the upload permission is managed on **People → Permissions**
(`/admin/people/permissions`). In day‑to‑day use it appears wherever a form uses
the `dropzonejs` element — most visibly in the **Media Library** add form, once the
module and library are in place.
