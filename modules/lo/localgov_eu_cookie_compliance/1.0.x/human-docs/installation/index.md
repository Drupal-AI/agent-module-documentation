# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **EU Cookie Compliance** module (`eu_cookie_compliance`) — this is a hard
  dependency and provides the actual consent handling. Composer pulls it in for you.

This module is part of the **LocalGov Drupal** distribution, but it has no other
council-specific requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_eu_cookie_compliance -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies —
including EU Cookie Compliance — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localgov_eu_cookie_compliance -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en localgov_eu_cookie_compliance -y
```

Enabling this module also enables `eu_cookie_compliance` if it is not already on.

## Verify it worked

Go to **Structure → Block layout** and confirm the **EU Cookie settings block** is
available to place (on a default LocalGov Scarfolk site it is placed for you). Then
follow the steps in the [main guide](../index.md#how-to-use-it) to create your cookie
page, place and restrict the block, and configure EU Cookie Compliance. Loading a
front-end page should show the cookie pop-up, and your settings page should display
the category-by-category consent form.
