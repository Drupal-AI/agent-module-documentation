# File Upload Size Limit (JS) — manual setup guide

**File Upload Size Limit (JS)** (`file_upload_size_limit`) checks the size of a file
**in the browser, before the upload starts**. Instead of a visitor picking a large
file, waiting through the whole upload, and only then getting a server-side
rejection, the module uses JavaScript to catch the over-size file immediately and
warn (or block) them. It's a nicer, faster upload experience — especially on slow
connections where a wasted upload is genuinely painful.

Just enabling the module makes per-file size validation happen in the browser. It
can also cap the **total** size of a multi-file upload, which is handy where a short
connection timeout means you want to limit how much a visitor tries to send at once.
For that total-size cap it offers three choices: match the total to the individual
file limit, set a total via the module's own setting, or apply no total limit at all
(the default).

**Important — this is a usability aid, not a security control.** A client-side check
is trivially bypassed (a user can disable JavaScript or craft the request directly),
so you must **not** rely on it to enforce upload limits. The real, enforced limits
come from Drupal's field settings and your PHP configuration
(`upload_max_filesize` and `post_max_size`). Keep those set correctly server-side,
and treat this module purely as front-end feedback layered on top of them. Note also
that this is an **alpha** release (`1.0.0-alpha7`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form, in particular the
   options for limiting the total size of a multi-file upload.

## Where it lives in the admin menu

The module's settings form is provided under Configuration (route
`file_upload_size_limit.settings`). Per-file validation works as soon as the module
is enabled; the settings are only needed if you want to tune the multi-file total-
size behavior.
