# Protected Download — manual setup guide

**Protected Download** (`protected_download`) hands out **HMAC‑signed, time‑limited
download links** for files. Instead of pointing at a permanent public path, each link
carries the file's URI, an expiry date, and a signature (HMAC). The download route is
public, but the module recomputes and verifies the signature — in constant time — and
checks the expiry before serving a single byte, so tampering with the URL, forging a
link, or using an expired one is rejected.

Its headline advantage over Drupal core's private file system is that these downloads
are **cacheable**, including HTTP cache revalidation. That makes it possible to serve
restricted assets — images, documents, downloads for a mobile app — efficiently
through browser and intermediate caches while still limiting who can reach them and for
how long. The module also provides replacement tokens, which are handy for putting an
expiring link into an email (for example, a receipt for a purchased digital file).

Understand the security model before you use it: a valid, unexpired link is a
**capability** — anyone who holds it can download the file, whether or not they are
logged in. So deliver links over secure channels, keep expiry windows appropriately
short, and keep the site's HMAC key secret. The module does not do per‑user access
control; the link itself is the grant.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set up the protected file system,
   its cache lifetimes, and point your file fields at it.

## Where it lives in the admin menu

Protected Download does not add its own settings page. It plugs into core's file
system settings at **Configuration → Media → File system**
(`/admin/config/media/file-system`), where you configure the protected file path and
cache behaviour. See [Configuration](configuration/index.md).
