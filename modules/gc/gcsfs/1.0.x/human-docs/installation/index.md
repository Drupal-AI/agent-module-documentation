# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Core **File** and **Image** modules (enabled automatically as dependencies).
- A **Google Cloud Platform** account with a Storage bucket and a service account
  that can access it.

## Install with Composer

From the project root:

```bash
composer require drupal/gcsfs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gcsfs -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gcsfs -y
```

## Verify it worked

Log in as an administrator and open the module's settings form (the `gcsfs.config`
route). If it loads, continue to [Configuration](../configuration/index.md) to
enter your bucket and credentials. You can also confirm the module's Drush
commands are available by running `drush list`.
