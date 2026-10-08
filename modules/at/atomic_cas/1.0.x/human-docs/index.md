# Atomic Content-Addressable Storage — manual setup guide

**Atomic Content-Addressable Storage** (`atomic_cas`) is a file‑storage backend
that stores files by their **content hash**. Because identical bytes always hash
the same, the same file is only ever stored once — so uploading the same document,
image, or attachment many times costs one copy on disk (deduplication). Image‑style
derivatives are likewise stored once at a shared, hash‑based location.

It exposes two stream wrappers, `cas-public://` and `cas-private://`, that preserve
full Drupal file‑entity semantics, so files stored this way behave like any other
managed file. Files are served through a controller route
(`/files/cas/{fid}/{short_hash}/{filename}`), and it can hand off delivery to the
web server via X‑Accel‑Redirect / X‑Sendfile with ETag / If‑None‑Match caching.

Private files stay properly protected: the serve controller invokes core's
`hook_file_download()` for `cas-private://` URIs — mirroring core's own
FileDownloadController — and **denies access when no module grants it**, so the
anonymous serve route does not leak private content. Administration is gated by the
`administer atomic cas` permission. The module depends on core **File** and runs on
Drupal 10.2+ and 11. This release is at beta stage.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Atomic CAS is infrastructure rather than a click‑through feature. Its
administration is gated by the **Administer atomic CAS** permission, which you
grant at **People → Permissions** to trusted administrators. Day to day, you point
file/image fields at the CAS stream wrappers rather than visiting a settings page.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. For fields or code that should use deduplicated storage, use the
   `cas-public://` scheme for publicly downloadable files and `cas-private://` for
   access‑controlled ones — they behave like core's `public://` / `private://`
   schemes but deduplicate by content hash.
3. Private files are gated through core's `hook_file_download()` machinery, so a
   `cas-private://` file is only served to a user some module actually grants
   access to. Grant the **Administer atomic CAS** permission only to trusted roles.
