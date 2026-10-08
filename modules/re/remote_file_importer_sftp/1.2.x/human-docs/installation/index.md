# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **[Remote File Importer](https://www.drupal.org/project/remote_file_importer)**
  base module (`remote_file_importer`) — this module is a plugin for it. Composer
  pulls it in automatically with the `-W` flag.
- Network access from your Drupal server out to the SFTP host/port (usually 22).
- An SFTP account (username and password) on the remote server.

## Install with Composer

From the project root:

```bash
composer require drupal/remote_file_importer_sftp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Remote File
Importer base module and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/remote_file_importer_sftp -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable both the base module and this plugin (enabling this one will enable the
base module as a dependency):

```bash
drush en remote_file_importer_sftp -y
```

## Verify it worked

Open Remote File Importer's admin screens and confirm that **SFTP** is now
available as a data-source type. Create an SFTP data source (see
[Configuration](../configuration/index.md)), then run a manual import against a
test directory — the files should download into your configured Drupal
destination.
