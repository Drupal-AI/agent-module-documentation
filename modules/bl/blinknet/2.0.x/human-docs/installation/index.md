# Installation

## Requirements

- **Drupal 9.3 or 10** (`core_version_requirement: ^9.3 || ^10`).
- A **Blink.net account**, so you have the account details to enter on the settings
  form.

There are no additional Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/blinknet -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/blinknet -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en blinknet -y
```

After enabling, enter your Blink.net account details and place the blocks — continue
to [Configuration](../configuration/index.md).
