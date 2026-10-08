# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11`; the module
  declares support up to Drupal 12).
- Core's **Block** module (`block`) and **Field** module (`field`), both part of a
  standard Drupal install.
- A **Marketo** subscription with at least one form built in Marketo, plus your
  Marketo instance details (see [Configuration](../configuration/index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/marketo_forms -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/marketo_forms -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en marketo_forms -y
```

## Verify it worked

At **Extend** (`/admin/modules`) confirm **Marketo JS Forms Integration** is
checked. Next, connect the module to your Marketo instance and place your first
form — see [Configuration](../configuration/index.md).
