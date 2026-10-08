# Installation

## Requirements

- **Drupal 11.3 or later** (`core_version_requirement: ^11.3`).
- No other module, Composer, or PHP library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/date_point -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/date_point -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en date_point -y
```

## Submodules

Date Point ships two optional submodules, both intended for **testing and
development only**:

| Submodule | Machine name | What it does |
|-----------|--------------|--------------|
| **Date Point Time Machine** | `date_point_time_machine` | Lets you shift the notion of "now" so you can test time‑dependent behaviour. |
| **Clock Mock** | `dp_clock_mock` | Mocks the clock for tests, so code that reads the current time gets a controlled value. |

> **Do not enable these on production.** They exist to make "now" controllable for
> automated tests and local development; on a live site they would distort every
> time‑dependent calculation.

Enable one (in a dev or test environment) with, for example:

```bash
drush en date_point_time_machine -y
```

## Verify it worked

After enabling, go to any bundle's **Manage fields**, click **Add field**, and
confirm **Date Point** appears as a field type. Add it, set the precision, and save
— see ["How to use it"](../index.md#how-to-use-it) for the full flow.
