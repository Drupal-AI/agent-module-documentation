# Maintenance Extended — manual setup guide

**Maintenance Extended** (`maintenance_extended`) is a small, focused module that
makes Drupal core's maintenance-mode page a little friendlier to customise. Out
of the box, core fixes the maintenance page's title in code and only lets you
edit the message as a plain textarea. This module lifts both limits.

Specifically, it adds two things to the standard maintenance settings form:

- A **Title** field, so you can change the heading of the "site under
  maintenance" page (which core otherwise hard-codes).
- A rich-text **Message** field — the message now uses a formatted text field, so
  you can style it with a WYSIWYG editor such as CKEditor instead of being stuck
  with plain text.

That's the whole scope: it's a display/branding aid for the maintenance page. It
does **not** change who is allowed to bypass maintenance mode — that is still
governed by Drupal core's *access site in maintenance mode* permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — the Title and rich-text Message
   fields it adds to the core maintenance settings.

## Where it lives in the admin menu

The module doesn't add a page of its own — it augments core's maintenance
settings at **Configuration → Development → Maintenance mode**
(`/admin/config/development/maintenance`).
