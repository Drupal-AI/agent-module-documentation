# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2||^11`).
- The core multilingual modules, all of which ship with Drupal and are enabled
  automatically as dependencies:
  - **Language** (`language`)
  - **Content Translation** (`content_translation`)
  - **Node** (`node`)

For the module to do anything useful, your site should already be configured for
multiple languages and have content translated into them — that is the material
it optimizes.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/aeo_multilingual -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/aeo_multilingual -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en aeo_multilingual -y
```

Enabling it also turns on the core Language, Content Translation, and Node modules
if they are not already active.

## After enabling

Review the permissions the module adds under **People → Permissions**
(`/admin/people/permissions`) and grant them to the roles that should manage its
behaviour.
