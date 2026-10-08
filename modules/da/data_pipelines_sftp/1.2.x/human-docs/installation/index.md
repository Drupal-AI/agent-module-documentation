# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1||^11`).
- **[Data Pipelines](https://www.drupal.org/project/data_pipelines)**
  (`data_pipelines`) — this is a source connector for it.
- **[Key](https://www.drupal.org/project/key)** (`key`) — required so the SFTP
  username/password can be stored as a Key entity rather than in plain config.
- A reachable **SFTP server** and an account (username/password) to log in with.

## Install with Composer

From the project root:

```bash
composer require drupal/data_pipelines_sftp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the Data Pipelines and Key modules if they
are not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/data_pipelines_sftp -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en data_pipelines_sftp -y
```

Data Pipelines and Key are enabled automatically as dependencies if they were not
already on.

## Verify it worked

Go to **Content → Datasets** (`/admin/content/datasets`) and configure a dataset's
source connection — SFTP should now be available as a source type, with a field to
select a credential Key. Creating that Key and completing the connection is covered
in [Configuration](../configuration/index.md).
