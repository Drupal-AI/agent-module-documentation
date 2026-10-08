# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Drupal core's **Block** module (`block`) enabled — this is the only dependency,
  and Drupal enables it automatically when you turn on Analog Digital Clock Block.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/adc_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/adc_block -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en adc_block -y
```

Once enabled, there is nothing else to configure globally. Head to **Structure →
Block layout** to place a clock — see [How to use it](../index.md#how-to-use-it).
