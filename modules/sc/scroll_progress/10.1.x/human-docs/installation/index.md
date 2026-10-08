# Installation

## Requirements

Scroll Progress is lightweight:

- **Drupal 9, 10 or 11** (`core_version_requirement: ^9||^10||^11`).
- No other module dependencies, and no extra PHP or third-party library
  requirements.

Note that the 10.1.x branch is a **development branch** and the project is in
maintenance-fixes mode — weigh that for production use.

## Install with Composer

From the project root:

```bash
composer require drupal/scroll_progress -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/scroll_progress -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en scroll_progress -y
```

## Verify it worked

Open the Scroll Progress settings form (its **Configure** link on the **Extend**
page), pick an indicator theme, save, then load a page and scroll — the progress
indicator should update as you go. See [Configuration](../configuration/index.md)
for the available themes and the colour option.
