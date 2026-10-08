# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- A **Cludo account** providing a (public) customer ID and engine ID for your search
  engine — sign up at [cludo.com](https://www.cludo.com/).

There are no other Drupal module dependencies and no third‑party PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/cludo_search -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cludo_search -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cludo_search -y
```

## Verify it worked

After enabling, open the Cludo Search settings page and confirm you can enter your
account details (see [Configuration](../configuration/index.md)). Search won't
return anything until your Cludo customer and engine IDs are entered and Cludo has
crawled your site.
