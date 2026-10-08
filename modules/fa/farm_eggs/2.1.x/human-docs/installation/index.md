# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`), running a **farmOS 2**
  installation — Farm Eggs is only usable inside farmOS.
- The farmOS modules **Farm Harvest** (`farm_harvest`) and **Farm Quick**
  (`farm_quick`) enabled — these are the dependencies. Farm Quick provides the Quick
  Forms UI the egg form appears in.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root of your farmOS site:

```bash
composer require drupal/farm_eggs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/farm_eggs -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en farm_eggs -y
```

Drupal enables `farm_harvest` and `farm_quick` as dependencies if they are not already
on.

## Verify it worked

Open the **Quick Forms** area of your farmOS site (provided by `farm_quick`). The
**Eggs** quick form should be listed. Submitting it should create a farmOS harvest log,
which you can confirm in your logs list.
