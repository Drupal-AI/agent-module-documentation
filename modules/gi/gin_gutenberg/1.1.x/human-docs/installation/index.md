# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- The **Gutenberg** module (`drupal/gutenberg`) — a hard dependency; Composer
  pulls it in for you.
- The **Gin** theme (`drupal/gin`), or core's **Claro** theme, set as your admin
  theme. Gin Gutenberg only activates when the active theme is Gin‑ or
  Claro‑based. Claro ships with core; Gin is a separate contrib theme you install
  if you want the full Gin experience.

There are no third‑party Composer or PHP library requirements from this module
itself.

## Install with Composer

From the project root:

```bash
composer require drupal/gin_gutenberg -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Gutenberg
module and update any shared dependencies as needed.

If you want the Gin theme too (recommended, since that is the whole point):

```bash
composer require drupal/gin -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gin_gutenberg -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gin_gutenberg -y
```

Drupal enables the **Gutenberg** module at the same time as a dependency.

## Finish the setup

Enabling the module is not enough on its own — the integration only activates once
Gutenberg is turned on for a content type and Gin/Claro is your admin theme.
Follow the [How to use it](../index.md#how-to-use-it) checklist to complete the
setup.
