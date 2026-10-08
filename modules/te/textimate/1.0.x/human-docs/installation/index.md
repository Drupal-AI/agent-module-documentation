# Installation

## Requirements

Textimate needs:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8||^9||^10||^11`).
- The **Splitting** module (`splitting:splitting`) — this is the library that
  splits text into words and characters, and Textimate depends on it. Composer
  pulls it in for you when you require Textimate with the `-W` flag below.

There are no additional PHP or library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/textimate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — here it also ensures the Splitting dependency is brought
in.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/textimate -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en textimate -y
```

Enabling Textimate also enables Splitting if it is not already on.

## Verify it worked

Log in as an administrator and go to **Structure → Textimate**
(`/admin/structure/textimate`). If the effects management screen loads, the module
is installed and ready for you to add your first animation. See
[Configuration](../configuration/index.md) for what you'll find there.
