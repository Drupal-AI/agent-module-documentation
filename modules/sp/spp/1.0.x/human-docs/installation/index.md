# Installation

## Requirements

- **Drupal 10.6 or Drupal 11.3 and later** (`core_version_requirement: ^10||^11`,
  with the module's own note that it supports Drupal 10.6 and 11.3+).
- Core **System** and **Filter** modules — both part of a standard Drupal install.
- No third‑party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/spp -W
```

The Composer package is `drupal/spp`, but the module's machine name is
`single_page_protection` — that is the name you enable below. The `-W`
(`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/spp -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en single_page_protection -y
```

## Verify it worked

Head to the module's settings (see [Configuration](../configuration/index.md)),
add a path to protect and give it a password, then visit that path in a private
browser window — you should be redirected to a password form before the page
renders.
