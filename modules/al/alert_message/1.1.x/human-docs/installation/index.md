# Installation

## Requirements

- **Drupal 11.1 or later** (`core_version_requirement: ^11.1`). This is a tight
  requirement — the module does **not** run on Drupal 10 or on 11.0.
- The contrib **Entity API** module (`entity`) — install it with Composer
  (`-W` handles this for you).
- Core's **Text** (`text`), **Datetime** (`datetime`) and **Block** (`block`)
  modules. Drupal enables these automatically as dependencies.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/alert_message -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the contrib
Entity API module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/alert_message -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en alert_message -y
```

Once enabled, create your first alert and place the alert block in a region —
see [How to use it](../index.md#how-to-use-it) in the overview.
