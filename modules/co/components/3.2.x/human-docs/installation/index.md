# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- **PHP 8.1** or newer.

There are no other modules to enable and no third‑party Composer libraries —
Components depends only on Drupal core.

## Install with Composer

From the project root:

```bash
composer require drupal/components -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/components -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en components -y
```

That's all it takes. There is no configuration form — everything is declared in
your theme's or module's `.info.yml`. See
[How to use it](../index.md#how-to-use-it) on the overview page for registering a
namespace and using the Twig helpers.

## Verify it worked

Add a `components: namespaces:` map to a theme's `.info.yml` pointing at a folder
of Twig files, rebuild caches (`drush cr`), then reference one of those templates
as `@yournamespace/file.twig` from a template. If it renders, the namespace is
registered.
