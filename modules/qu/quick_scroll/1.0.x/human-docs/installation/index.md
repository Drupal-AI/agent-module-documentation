# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).

There are no dependencies beyond Drupal core, and no PHP‑library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/quick_scroll -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/quick_scroll -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en quick_scroll -y
```

## Verify it worked

Open any page on the front end and scroll down — a scroll‑to‑top button should
appear. Click it to jump back to the top of the page. There is no configuration to
do.
