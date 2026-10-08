# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Field** module (`field`) — enabled by default on a standard site.
- **Drush**, since the module's entire interface is Drush commands.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/content_entity_sync -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_entity_sync -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_entity_sync -y
```

## Set the content directory (required)

Before using the module you must tell it where to read and write the exported YAML
files. Add a `$settings['content_sync_directory']` line to your site's
`settings.php` (or a dedicated settings include):

```php
// Directory for exported/imported content entity YAML files.
// A relative path is resolved from the Drupal web root; here it points at a
// "content/sync" directory alongside your Drupal installation.
$settings['content_sync_directory'] = '../content/sync';
```

Make sure the directory exists and is **writable** by the web server / Drupal user,
so exports can write their YAML files there. Imports read from the same location by
default.

## Verify it worked

Confirm the Drush commands are available:

```bash
drush list | grep content-entity-sync
```

You should see `content-entity-sync:export` (aliases `conex` / `cox`) and
`content-entity-sync:import` (aliases `conim` / `coi`). Run a small export, for
example `drush content-entity-sync:export node --bundle=article`, and check that YAML
files appear in your configured content directory.
