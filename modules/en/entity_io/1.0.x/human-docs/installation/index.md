# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- These core modules, which Entity IO depends on and Drupal enables automatically:
  **Media** (`media`), **User** (`user`), **Node** (`node`), **Taxonomy**
  (`taxonomy`), **Block** (`block`) and **Comment** (`comment`).

There are no third‑party PHP or JavaScript library requirements. Some submodules
have their own needs (for example, the Webhooks submodule's email delivery uses an
SMTP module) — see below.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_io -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_io -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_io -y
```

## Submodules

Entity IO ships several optional submodules for larger and more automated
workflows. Enable only the ones you need:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Entity IO Queue** | `entity_io_queue` | Queued export/import for large‑scale operations, plus an authenticated endpoint to add import tasks programmatically (Basic Auth) so external systems can push import jobs into the queue. |
| **Entity IO Webhooks** | `entity_io_webhooks` | Automation on create/update/delete/moderation events — POST the exported JSON to an external endpoint, email it as an attachment (needs an SMTP module), or upload it via FTP. |
| **Entity IO Push** | `entity_io_push` | A "Push to Server" tab on entity pages to push content and its related entities to another configured Drupal site, for multi‑environment sync. |
| **Entity IO Purge** | `entity_io_purge` | Purge‑related functionality for exported data. |

For example:

```bash
drush en entity_io_queue -y
```

> **Before you enable these:** the Queue submodule exposes an authenticated import
> endpoint, and the Push/Webhooks submodules send content to other systems. Enable
> them only when you need them, keep the credentials they use safe, and point them at
> destinations you trust.

## Verify it worked

Open a supported entity (for example a node) as an administrator and look for the
Entity IO **export tab**. Being able to export an entity to JSON confirms the module
is active. Continue to [Configuration](../configuration/index.md) for the full
workflow.
