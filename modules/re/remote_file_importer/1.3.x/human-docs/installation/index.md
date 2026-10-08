# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- A data-source plugin to actually connect somewhere: the bundled FTP submodule
  (`remote_file_importer_ftp`) for FTP/FTPS, or the separate
  [Remote File Importer — SFTP](https://www.drupal.org/project/remote_file_importer_sftp)
  module for SFTP.
- Network access from your Drupal server out to the remote host/port.
- No third‑party PHP libraries beyond what Composer resolves.

## Install with Composer

From the project root:

```bash
composer require drupal/remote_file_importer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/remote_file_importer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en remote_file_importer -y
```

## Submodules and companion modules

| Module | Machine name | What it adds |
|--------|--------------|--------------|
| **Remote File Importer FTP** | `remote_file_importer_ftp` | The bundled FTP/FTPS data source. Enable it to import from FTP servers: `drush en remote_file_importer_ftp -y`. |
| **Remote File Importer — SFTP** | `remote_file_importer_sftp` | A **separate project** (install it with Composer) that adds an SFTP data source. See its own guide. |

Enable the FTP submodule if you need FTP:

```bash
drush en remote_file_importer_ftp -y
```

## Verify it worked

After enabling the module and a data-source plugin, open the Remote File Importer
admin screens and confirm you can add a data source (see
[Configuration](../configuration/index.md)). Configure a source and run a manual
import (from the UI or with `drush remote-file-importer`-style commands provided by
the module) — imported files should appear in your Drupal file storage under the
destination you set.
