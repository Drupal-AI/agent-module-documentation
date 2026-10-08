# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Drupal core only — there are no other module dependencies and no third-party
  library or special PHP requirements beyond what core needs.

Often you will not install Typed Data directly at all: modules that build on it,
most notably **Rules**, list it as a dependency and Composer pulls it in
automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/typed_data -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/typed_data -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en typed_data -y
```

There is nothing to configure after enabling — the services, plugin types, and
Drush commands become available immediately. See
[How to use it](../index.md#how-to-use-it) on the overview page, or the
[`agent/`](../agent/start.md) docs for the developer detail.
