# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Image** module (`image`) — enabled automatically as a dependency.
- The **Key** module (`drupal/key`, version 1.15 or newer) — holds the Azure
  account key. Enabled automatically as a dependency.
- The **Azure Storage Blob PHP SDK** (`microsoft/azure-storage-blob`, 1.5 or
  newer) — pulled in by Composer.
- PHP's `allow_url_fopen` must be **enabled**. (32‑bit PHP works but is limited
  to 2 GB files — the status report will warn you.)
- An Azure storage account and a **public** blob container (access level
  *Container* or *Blob* for public assets).

## Install with Composer

From the project root:

```bash
composer require drupal/az_blob_fs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Key module
and the `microsoft/azure-storage-blob` SDK along with any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/az_blob_fs -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en az_blob_fs -y
```

This also enables the `key` and `image` dependencies if they aren't already on.

## Verify the environment

After enabling, visit **Reports → Status report**
(`/admin/reports/status`). The module runs a readiness check that reports:

- whether the `microsoft/azure-storage-blob` SDK is present,
- whether `allow_url_fopen` is enabled,
- whether the account name and key are configured (it links to the settings form
  if not),
- a warning if you're on 32‑bit PHP.

Resolve any errors before you rely on Azure for file storage. Next, head to
[Configuration](../configuration/index.md) to store your account key and enter
your connection details.
