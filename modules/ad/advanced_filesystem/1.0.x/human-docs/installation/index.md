# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- No Drupal module dependencies are declared, but individual features have their
  own external requirements — for example a **ClamAV** service for antivirus
  scanning, cloud storage accounts (S3, GCS, R2, FTP) for backup, and API access
  for the AI features. Provision those only for the features you plan to use.

## Install with Composer

From the project root:

```bash
composer require drupal/advanced_filesystem -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/advanced_filesystem -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en advanced_filesystem -y
```

## After enabling

Grant `administer advanced filesystem` on **People → Permissions** to the
administrators who will manage the suite. Then enable and configure features one
at a time — see [Configuration](../configuration/index.md). Given how much this
module can touch (external storage, antivirus, AI, signed URLs), roll it out
deliberately rather than switching everything on at once, and test file
operations such as migration in **dry-run** mode first.
