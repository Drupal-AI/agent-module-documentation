# Flysystem — manual setup guide

**Flysystem** (`flysystem`) exposes third-party filesystem backends — local
directories, FTP, and (via contrib adapters) S3, SFTP, Google Cloud Storage,
Dropbox and more — to Drupal as ordinary **stream wrappers**. That means your
files can live on a remote store while your code, your fields, and your themes
keep using normal `scheme://path` URIs, exactly as they do with core's
`public://` and `private://`. It bridges the well-known PHP League **Flysystem**
library into Drupal, so you can swap where files are stored without changing any
code and reduce vendor lock-in.

Each backend is a **scheme** you declare in `settings.php` under
`$settings['flysystem']` — there is deliberately no admin form or exportable
Drupal config for the backends themselves, because the settings often contain
credentials that belong in `settings.php` (or environment variables), not in the
database. You give each scheme a name, a driver (the Flysystem adapter to use),
and a config array passed to that adapter. A scheme can be marked public (files
served at browser-accessible URLs, with image-style routes) or left non-public
(files proxied through Drupal's access control). Two built-in drivers ship —
`local` and `ftp` — and contrib modules add the cloud adapters.

The module does add two admin **forms**: a **Sync** form to copy every file from
one scheme to another in one go, and a **Field migration** form to move existing
file/image field uploads onto a Flysystem scheme. Both are gated by the single
*Administer flysystem* permission. Flysystem requires PHP 8.2+ and Drupal 11, and
pulls in several Composer libraries. Because backends are a plugin type,
developers can write a custom adapter to integrate any new store.

This guide is written for a **human** setting this up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, the library
   requirements, and enable it.
2. [Configuration](configuration/index.md) — declare a scheme in `settings.php`,
   the drivers and options, public vs non-public, and the Sync / Field-migration
   forms.

## Where it lives in the admin menu

There is no settings form for the backends — those live in `settings.php`. The
Sync form and Field migration form are under **Configuration → Media → File
system → Flysystem** (`/admin/config/media/file-system/flysystem`). Each scheme's
health is checked on the **Status report** (`/admin/reports/status`).

## How to use it

Install the module and any adapter module you need, declare one or more schemes in
`settings.php`, then rebuild caches so the stream wrappers and routes register.
You can then point Drupal's default upload destination (or specific fields) at a
scheme, and use the Sync / Field-migration forms to move existing files onto it.
See [Configuration](configuration/index.md).
