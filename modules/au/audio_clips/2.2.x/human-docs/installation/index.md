# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- No third-party Composer libraries and no other contrib module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/audio_clips -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/audio_clips -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en audio_clips -y
```

After enabling, grant the **Administer audio clip types** permission
(`administer audio clip types`) to the roles that should manage clip types, then
define the clip types your site needs. See [How to use it](../index.md#how-to-use-it).
