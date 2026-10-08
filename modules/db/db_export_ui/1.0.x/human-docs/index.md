# Database Export UI — manual setup guide

**Database Export UI** (`db_export_ui`) is a lightweight admin interface for
exporting a MySQL/MariaDB database dump from within Drupal, with basic user-data
sanitization. It is aimed at developers and site maintainers who want a simple,
single-click export they can read and customise — not a full-featured backup
system.

From one admin page it generates a compressed `.sql.gz` SQL dump using
`mysqldump`, and it can optionally sanitize user data before writing the dump, so
you can produce a shareable copy for a development or staging environment. It is
built on Drupal services and dependency injection and is deliberately small, so it
is easy to extend for project-specific workflows.

It is intentionally minimal. It **only supports MySQL/MariaDB**, it does **not**
restore, it does **not** schedule backups, and it does **not** write to remote
destinations. Its sanitization is basic and may need customising for your project.
For most production sites the
[Backup and Migrate](https://www.drupal.org/project/backup_migrate) module — with
scheduled backups, multiple destinations, restore, and selective exports — is the
better choice; Database Export UI is a lightweight alternative for simple cases and
local/dev use.

> **Handle exports as sensitive data.** A database dump contains the site's
> data and should be treated as confidential. Access to the export page is gated
> by a dedicated **`administer db exports`** permission — grant it only to trusted
> administrators — and store or move the generated dump files to a secure location,
> deleting them once you are done with them.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — grant the permission and use the
   export page.

## Where it lives in the admin menu

The export page sits at **Configuration → Development → Database Export**
(`/admin/config/development/db-export`). See
[Configuration](configuration/index.md).
