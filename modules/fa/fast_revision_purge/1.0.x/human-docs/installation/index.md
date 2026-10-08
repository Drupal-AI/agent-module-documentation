# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Node** module (`node`) — the only hard dependency, enabled by default on
  most sites.
- No external PHP libraries.
- Designed for **MySQL / MariaDB**: size estimates and some maintenance SQL read
  `information_schema`.

Optionally, when the **Paragraphs** and/or **Layout Builder** modules are enabled,
the module offers extra purges for paragraph revisions and Layout Builder field
revisions; those options are disabled in the UI when the respective module is not
installed. **Admin Toolbar** makes it quicker to reach the configuration page — all
optional.

## Install with Composer

From the project root:

```bash
composer require drupal/fast_revision_purge
```

## Enable the module

```bash
drush en fast_revision_purge -y
```

Enabling the module creates its working tables and a single `fastrev_stats` row used
to record run totals and timestamps.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fast_revision_purge`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Verify it worked

Go to **Configuration → Development → Fast Revision Purge**. You should see the
purge configuration screen. Before doing anything else, run a **dry run** (in the
UI, or with `drush fastrev:report`) to confirm the tool can read your revisions and
to preview counts — no revisions are deleted by a dry run. Only after reviewing those
numbers, and taking a backup, should you run a real purge.
