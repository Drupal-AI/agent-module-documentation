# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9.0 || ^10.0 || ^11.0`).

There are no third-party Composer or PHP library requirements. The module ships
its own CSS library (`api_wrapper/api_wrapper.styles`) for styling the generated
documentation page — nothing you need to install separately.

## Install with Composer

From the project root:

```bash
composer require drupal/api_wrapper -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/api_wrapper -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en api_wrapper -y
```

There is no configuration form; you drive the module entirely with the
`#[ApiWrap]`/`#[Endpoint]` attributes in your own service classes.
