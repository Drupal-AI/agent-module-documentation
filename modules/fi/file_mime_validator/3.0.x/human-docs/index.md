# File Mime Validator — manual setup guide

**File Mime Validator** (`file_mime_validator`) checks a file upload's **real**
MIME type instead of trusting its extension. Drupal's file field validates the
extension, but the extension is chosen by whoever uploads the file — so a PHP or
HTML payload named `photo.jpg` sails straight through an allowed-extensions check.
This module adds the missing step: it inspects the file's actual content type and
compares it against what the extension claims, rejecting the file (and logging the
attempt) when they don't match.

It works server-side on any upload-type file field used on any entity, and the
extension-to-MIME mappings it enforces are configurable, so the list can be kept
current as new types come along. Think of it as **defence in depth behind**
Drupal's extension allow-list, not a replacement for it — you should still keep the
allow-list narrow, because an accurate MIME check on a type you never should have
accepted doesn't help you.

It has **no module dependencies** and targets Drupal 10 and 11.

> **Heads-up about the settings form.** The configuration route is gated behind a
> permission named `administer`, which Drupal core does not actually define. As a
> result the settings form is unreachable for every account except user 1 (which
> bypasses permission checks). The **validation itself still runs normally** — only
> the settings *screen* is affected. Until the module ships a fix, configure it as
> user 1, or set the configuration with Drush (`drush cset`). See
> [Configuration](configuration/index.md) for details.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the MIME mappings, how to reach (or
   work around) the settings form, and how it fits with core's allow-list.

## Where it lives in the admin menu

The settings form is at **Configuration → System → File Mime Validator**
(`/admin/config/system/file-mime-validator/file-types-mime-config`) — but note the
reachability caveat above and in [Configuration](configuration/index.md).
