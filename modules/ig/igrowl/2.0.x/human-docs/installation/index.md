# Installation

iGrowl needs two third-party JavaScript libraries placed in your site's
`/libraries` directory in addition to the module itself.

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- The **iGrowl** JavaScript library.
- The **animate.css** library (iGrowl uses it for the notification animations).

## Install with Composer

From the project root:

```bash
composer require drupal/igrowl -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/igrowl -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Add the JavaScript libraries

The module code does not include the libraries themselves — download and unzip
them into your site's **`/libraries`** folder (in the Drupal root, **not** inside
`/core`):

1. Download the **animate.css** zip and unzip it to `/libraries/animate`.
2. Download the **iGrowl** zip and unzip it to `/libraries/igrowl`.

## Enable the module

```bash
drush en igrowl -y
```

Then clear the cache:

```bash
drush cr
```

## Verify it worked

Go to **Reports → Status report** (`/admin/reports/status`). It should indicate
that both the iGrowl and animate.css libraries were detected successfully. If
either is missing, re-check the paths under `/libraries`. Once both are present,
attach the libraries and dispatch a `GrowlCommand` as shown in the
["How to use it"](../index.md#how-to-use-it) section to confirm notifications
appear.
