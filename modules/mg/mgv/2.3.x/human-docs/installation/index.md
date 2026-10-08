# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Drupal core only — there are no contrib or PHP library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/mgv -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/mgv -W`, `ddev drush …`. Inside the container (`ddev ssh`)
> run them without the prefix.

## Enable the module

```bash
drush en mgv -y
```

There is no settings form and no submodules. The `global_variables` object is available in
every Twig template as soon as the module is enabled — see
[How to use it](../index.md#how-to-use-it).

> **Note:** If you are upgrading from an older version, the legacy `@Mgv` annotation for
> custom variable plugins is **deprecated in 2.3.0** (removed in 3.0). Use the
> `#[Variable('id')]` PHP attribute for any custom global‑variable plugins.
