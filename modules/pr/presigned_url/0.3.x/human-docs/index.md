# Presigned URL — manual setup guide

**Presigned URL** (`presigned_url`) creates and validates **AWS-style presigned
URLs** for files: signed, time-limited links that grant temporary access to a
resource without requiring the visitor to have a session or account. Anyone
holding a valid, unexpired link can fetch the file; once the link expires, or if it
is tampered with, it stops working.

It works by attaching a cryptographic signature to a URL along with an expiry
timestamp. The signature is an **HMAC-SHA256** hash computed over the request's
host, URI, date, expiry, and algorithm, keyed with a **private signing key** that
only your site knows. When the URL is requested, the module recomputes the
signature and compares it — a match (and an expiry still in the future) means the
link is valid. This is a sound, standard presigning design, and it means the whole
scheme rests on one thing: the **private key must stay secret**. Anyone who obtains
it can mint valid links to any file.

The module exposes a Drush command, **`presigned-url:sign`**, to generate signed
URLs with an expiry. It depends on core's File module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **This module is early-stage** (version 0.3.x, described upstream as a
> work-in-progress). Review it and test the signing/validation flow before relying
> on it to protect sensitive files in production.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — providing and protecting the signing
   key, the expiry, and generating URLs with Drush.

## Where it lives

Presigned URL is driven from configuration and the command line rather than a
click-through settings page. You provide it a private signing key (kept as a
secret, not in exported config), and mint links with the `presigned-url:sign`
Drush command — see [Configuration](configuration/index.md).
