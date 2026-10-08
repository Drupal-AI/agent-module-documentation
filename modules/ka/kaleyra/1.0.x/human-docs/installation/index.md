# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- A **Kaleyra account** with an **API key** and a registered **sender identifier**
  — you get these when you sign up for the Kaleyra Global Messaging API.

The module has no other Drupal module dependencies and no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/kaleyra -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/kaleyra -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en kaleyra -y
```

Or enable **Kaleyra** on the **Extend** page (`/admin/modules`).

## Verify it worked

Go to **`/admin/config/kaleyra`**. If the settings form loads, the module is
installed. Enter your credentials (see [Configuration](../configuration/index.md)),
then send a test message from code (for example via `drush php:eval`) and check that
it arrives — or check the `kaleyra` log channel at **Reports → Recent log messages**
if it doesn't.
