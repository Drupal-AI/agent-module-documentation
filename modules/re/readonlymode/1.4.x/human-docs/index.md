# Read Only Mode — manual setup guide

**Read Only Mode** (`readonlymode`) is a gentler alternative to Drupal's
Maintenance Mode. Instead of taking the whole site offline, it lets visitors keep
**reading** the site normally while blocking almost all **form submissions** — so
content can't be added or changed. It's ideal for freezing a site during a code or
database deployment, a content migration, a backup, or an editorial content-lock
window, all without showing anyone a "site under maintenance" wall.

When you switch it on, the module removes the fields from (or redirects away from)
any form that isn't on its allow-list, and rejects blocked submissions with a
configurable error message while showing a friendly warning on affected pages. A
sensible allow-list ships out of the box — things like login, password reset, the
search box, exposed Views filters, and the maintenance-settings form itself keep
working — and you can extend it with your own form IDs (supporting `*` wildcards,
so `webform*` keeps every webform submittable, for example).

Two permissions shape the experience: **Access forms** lets trusted users (usually
administrators) bypass the lock and keep editing during a freeze, and **Access
messages** controls who sees the notices. The module also ships a **Read Only
Mode** block so you can surface the maintenance notice in a region. Everything is
stored as ordinary configuration, so the lock can be toggled and deployed like any
other setting. Read Only Mode has no third-party dependencies or submodules and no
Drush commands.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the config keys and
the exact locking mechanism — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — turn read-only on/off, allow specific
   forms, set the messages and redirect, the two permissions, and the block.

## Where it lives in the admin menu

Read Only Mode adds its controls to the **core Maintenance mode** settings form at
**Configuration → Development → Maintenance mode**
(`/admin/config/development/maintenance`) — look for the "Read Only Mode" section.
Its two permissions are set on the usual **People → Permissions** page.

## How to use it

Open the Maintenance mode form, expand the **Read Only Mode** section, tick to
enable it, adjust the messages and allowed-forms list if needed, and save. The site
stays fully readable, but non-allowed forms stop accepting submissions until you
turn it back off. Give administrators the *Access forms* permission first so they
can keep working during the freeze. See [Configuration](configuration/index.md) for
the details.
