# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- Drupal core only — there are no module dependencies and no PHP library
  requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/disable_browser_back_button -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/disable_browser_back_button -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en disable_browser_back_button -y
```

After enabling, tell the module which pages to act on — see
[Configuration](../configuration/index.md).

## Verify it worked

Visit one of the pages you configured, then press your browser's Back button. You
should stay on the current page instead of navigating away. On pages you did not
configure, the Back button should behave normally.
