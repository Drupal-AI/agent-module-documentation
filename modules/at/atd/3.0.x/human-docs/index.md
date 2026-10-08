# ATD (Assisted Translation) — manual setup guide

**ATD (Assisted Translation)** (`atd`) is a helper for translation workflows. It
provides tooling that assists with translating interface (and content) strings,
built on top of Drupal core's **Locale** system rather than replacing it. Strings
still follow core's normal locale handling — ATD adds assistance around that.

It is a lightweight multilingual / developer helper: it depends only on core's
**Locale** module, sits in the Multilingual package, and has no content or access
role of its own. This version (3.0.x) targets Drupal 11.1+.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

ATD works alongside core's translation tooling, so you use it where you already
manage translations — **Configuration → Regional and language → User interface
translation** (`/admin/config/regional/translate`) and the wider **Regional and
language** section. It does not add a separate top‑level admin area.

## How to use it

1. Make sure your site has languages configured and core's Locale module enabled.
2. Install and enable ATD (see [Installation](installation/index.md)).
3. Work through your translations as usual under **Regional and language**; ATD
   assists that workflow. Because the module's own documentation is minimal, treat
   the sibling [`agent/`](../agent/start.md) docs and the project page as the
   source of truth for the exact assistance it provides in the release you install.
