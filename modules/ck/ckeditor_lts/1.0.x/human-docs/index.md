# CKEditor 4 - LTS — manual setup guide

**CKEditor 4 - LTS** (`ckeditor_lts`) restores **CKEditor 4** as a contributed
module after Drupal core removed it in favour of CKEditor 5. Its machine name is
actually `ckeditor` — it deliberately replaces the removed core module of that
name — so it slots into the place the old editor occupied.

The problem it addresses is migration timing. CKEditor 5 is a different editor
with a different plugin architecture, and moving a site that relies on custom
CKEditor 4 plugins and configuration is real work that cannot always be done on
core's schedule. This module keeps CKEditor 4 available so a site can stay on
Drupal 10 or 11 while that migration is planned and carried out.

**Please read this before adopting it — the important part is a security one.**
CKEditor 4 reached **end of life in June 2023**. The open‑source CKEditor 4 line
receives no more free security patches; ongoing fixes are available only through
CKSource's paid **Extended Support Model (ESM)**, which is why this build
*requires a commercial license key to initialize the editor*. A WYSIWYG editor
sits directly in the path of untrusted content — exactly where cross‑site
scripting lives — so running an editor whose client‑side security is frozen is a
real consideration. Treat this module as a **migration bridge, not a
destination**: it exists to buy time to move to CKEditor 5, not to stay on
CKEditor 4 indefinitely. Your real protection in the meantime remains Drupal's
server‑side **text‑format filtering**; do not rely on the frozen editor for
safety, and audit your content filters while you are on it.

Use it if a CKEditor 5 migration genuinely cannot be done yet, hold (or acquire)
the CKSource ESM license, plan the migration, and understand the posture in the
meantime.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, understand the
   core‑module swap, enable it, and enter your ESM license key.

This module has no ordinary settings page of its own beyond entering the license
key and using CKEditor 4's own text‑format configuration; the setup steps are
covered in Installation.

## Where it lives in the admin menu

Because CKEditor 4 - LTS takes over the `ckeditor` editor, you configure it the
same way you always configured CKEditor 4 — through **Configuration → Content
authoring → Text formats and editors** (`/admin/config/content/formats`), where
each text format that uses CKEditor 4 has its toolbar and settings. The one extra
requirement is supplying your **ESM license key**, without which the editor will
not initialize; see [Installation](installation/index.md).
