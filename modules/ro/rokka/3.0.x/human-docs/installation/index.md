# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A **Rokka.io account** with an organization and API key — sign up at rokka.io.
- Composer, since the module ships its Rokka PHP SDK dependency via Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/rokka -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Rokka client
library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rokka -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rokka -y
```

## Verify it worked

Log in as an administrator and open the Rokka settings form under
**Configuration** (the `rokka.admin_settings` route). If it loads, the module is
installed — continue to [Configuration](../configuration/index.md) to enter your
credentials and sync image styles. Nothing is stored in Rokka until you have done
that.
