# Installation

## Requirements

- **farmOS 4** (`farmos/farmos: ^4`) on **Drupal 11**
  (`core_version_requirement: ^11`) — Farm Eggs is only usable inside farmOS.
- The farmOS modules **Farm Animal** (`farm_animal`), **Farm Harvest**
  (`farm_harvest`), **Farm Quantity Standard** (`farm_quantity_standard`), and **Farm
  Quick** (`farm_quick`) enabled — these are the dependencies. Farm Quick provides the
  Quick Forms UI the egg form appears in.
- Using the form requires the farmOS **`create harvest log`** permission.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root of your farmOS site:

```bash
composer require drupal/farm_eggs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. On a farmOS 4 site this resolves the `3.0.x` branch.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/farm_eggs -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en farm_eggs -y
```

Drupal enables `farm_animal`, `farm_harvest`, `farm_quantity_standard`, and
`farm_quick` as dependencies if they are not already on.

## Grant the permission

Make sure the roles that will record egg harvests have the **`create harvest log`**
permission (**People → Permissions**), since the quick form requires it.

## Verify it worked

Visit **`/quick/eggs`** (or find the **Eggs** form under farmOS's Quick Forms). Then
edit an animal or group asset and confirm a **Produces eggs** checkbox now appears —
tick it, submit the egg form, and check that a harvest log was created in your logs
list.
