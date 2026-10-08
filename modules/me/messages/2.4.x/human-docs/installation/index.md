# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2||^11`).
- A modern browser with CSS Grid support on the visitor side (for the card layout and
  animations).
- No other modules and no external PHP libraries are required.

This project is not covered by Drupal's security advisory policy, so review it before
relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/messages -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Note on the machine name:** the Composer package and module machine name are both
> `messages` (`drupal/messages`). Some of the project's own copy refers to an
> "enhanced status messages" name — the module you install and enable here is
> `messages`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/messages -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en messages -y
drush cr
```

Clearing the cache (`drush cr`) makes sure the new styling assets are picked up.

## Verify it worked

Trigger any status message — for example, save a piece of content or a configuration
form. Instead of Drupal's default notice you should see a styled message card. To
adjust the appearance and behavior, see [Configuration](../configuration/index.md).
