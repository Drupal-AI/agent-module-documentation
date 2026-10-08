# Installation

## Requirements

Styles API needs:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).

It has no other module dependencies and no third-party Composer or PHP library
requirements — it is a standalone developer framework.

## Install with Composer

From the project root:

```bash
composer require drupal/styles_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/styles_api -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en styles_api -y
```

Enabling it does nothing visible on its own — Styles API is an API other modules and
themes build on. Once it is enabled, any provider can register styles (via a
`<provider>.themes.yml` file or an annotated `@Style` plugin) and consuming code can
list and render them. See [How to use it](../index.md#how-to-use-it) in the overview.
