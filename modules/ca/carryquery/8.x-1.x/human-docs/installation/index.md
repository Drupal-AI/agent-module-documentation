# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **Filter** module (`filter`).
- The **Token** module (`token`).
- The **Token Filter** module (`token_filter`) — used so tokens render (and are
  sanitized) inside filtered text formats.

There are no additional PHP or third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/carryquery -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Token and Token Filter are pulled in as dependencies if they
are not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/carryquery -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en carryquery -y
```

This also enables the `filter`, `token`, and `token_filter` dependencies if they are
not already on.

## Verify it worked

Go to `admin/config/carryquery`, add a query-parameter key to carry, and save. Then
place one of the module's link tokens (for example `[link:route:system.admin]`) in a
piece of content rendered through a text format that has the Token Filter enabled, and
confirm the generated link carries your parameter forward.
