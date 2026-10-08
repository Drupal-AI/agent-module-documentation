# Installation

## Requirements

- **Drupal 9.1, 10, 11, or 12** (`core_version_requirement: ^9.1 || ^10 || ^11 || ^12`).
- Core's **Block** (`block`) and **Field** (`field`) modules, which Drupal enables
  automatically as dependencies.
- An **Adnuntius.com account** with the ad units you want to display.

There are no third-party Composer or PHP library requirements. Note the current
release is a beta.

## Install with Composer

From the project root:

```bash
composer require drupal/adnuntius -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/adnuntius -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en adnuntius -y
```

Next, configure your Adnuntius account and place the ad blocks — see
[Configuration](../configuration/index.md).
