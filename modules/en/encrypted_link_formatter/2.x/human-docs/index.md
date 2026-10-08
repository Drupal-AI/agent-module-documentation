# Encrypted link formatter — manual setup guide

**Encrypted link formatter** (`encrypted_link_formatter`) is a field formatter
for **private file and image fields** that obfuscates the download URL. Instead
of exposing the real `private://…` path in the link, it outputs an encoded (or
encrypted) URL, and it overrides Drupal's private-file download route to decode
that URL and stream the file. It has no module dependencies, but it only works
when your site's **private file system** is configured.

It offers two modes. **Base64** simply base64-encodes the path — the URL no
longer shows the real filename, but the encoding is trivially reversible by
anyone. **Base64 + AES-128-CBC** additionally encrypts the path with a key (the
"seed") you enter, using a site-wide initialization vector that the module can
rotate on cron (every 1 to 24 hours). Beyond the formatter, the module exposes a
small service so custom code can encrypt other strings the same way.

> **Important — this is obfuscation, not access control.** Encrypted link
> formatter tidies and hides download URLs; it does **not** decide who may
> download a file. Actual private-file access is still governed by Drupal's normal
> `hook_file_download` access checks. The base64 mode is reversible by anyone, and
> the AES mode ships with a weak default seed (`your_private_key_here`) that you
> must change. Treat this module as link tidying, and keep your real private-file
> access rules in place.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and confirm the private file system is set up).
2. [Configuration](configuration/index.md) — the *Crypt settings* form
   (encryption mode, seed/key, link lifetime) and applying the formatter to a
   field.

## Where it lives in the admin menu

The module's settings form is at **Configuration → System → Crypt settings**
(`/admin/config/system/crypt-settings`), available to users with the
**Administer site configuration** permission. The formatter itself is applied per
field under **Manage display** for any file/image field stored on the
`private://` scheme.
