# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A working **cron** run — the cleanup happens during cron, so the module does
  nothing until cron runs.

There are no third‑party Composer or PHP library requirements, and no module
dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/clean_files_entity -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/clean_files_entity -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en clean_files_entity -y
```

## Configure it in settings.php

The module has no admin form — it reads its settings from `settings.php`. Add a
block like this, adjusting the folders and limit for your site:

```php
$config['clean_files_entity'] = [
  'folders' => [
    'public://node_images/',
  ],
  'max' => 100,
];
```

**Before you do this on a real site, take a backup and start with a small `max`
and a single, well-understood folder.** This module deletes files during cron, and
Drupal's usage tracking does not know about files referenced only from body HTML,
config, custom tables, or external links. See the
[overview](../index.md) for the full list of cautions.

## Verify it worked

Run cron once (`drush cron`) after configuring a narrow `folders` list and a small
`max`. Check which files were removed from that folder and confirm they were all
genuinely unreferenced before you widen the scope or raise the limit.
