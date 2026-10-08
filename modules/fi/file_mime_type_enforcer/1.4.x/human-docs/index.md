# File MIME Type Enforcer — manual setup guide

**File MIME Type Enforcer** (`file_mime_type_enforcer`) hardens file uploads by
checking that a file's **extension matches its real content**. On upload it
compares two things: the MIME type Drupal infers from the file's **extension**
(via `ExtensionMimeTypeGuesser`) and the MIME type Symfony's **fileinfo** detects
from the file's actual **content**. If they don't match — and the mismatch isn't
one you have explicitly allowed — the upload is rejected.

This closes a common attack path. A great many malicious uploads work by
disguising a file: a `photo.png` that is really HTML, an SVG carrying script, or an
executable renamed to look harmless. An extension check alone cannot catch that;
requiring the content to match the claimed extension does. Blocking this class of
upload protects against stored XSS through HTML/SVG payloads and against disguised
executables.

Because some perfectly legitimate files have a detected type that differs from
their extension, the module lets you define **allowed mappings** per extension in
a simple JSON configuration. It can run in a **strict** mode (reject mismatches)
or a **permissive** mode (log only), and it ships a **Drush command** that audits
files already on the system, flagging discrepancies in the logs and, if you like,
on screen. It adds no access-control behaviour of its own, and it complements —
rather than replaces — Drupal's own upload restrictions.

It depends on core's **File** and **System** modules, needs the PHP **fileinfo**
extension, and targets Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   confirm the fileinfo extension, and enable it.
2. [Configuration](configuration/index.md) — the allowed MIME mappings, strict vs
   permissive mode, and the audit command.

## Where it lives in the admin menu

- **Settings** — **Configuration → Media → File MIME Type Enforcer**
  (`/admin/config/media/file-mime-type-enforcer`).
