# Installation

## Requirements

- **Drupal 10.3 or newer, or Drupal 11** (`core_version_requirement:
  ^10.3 || ^11`).
- **PHP 8.1 or newer** (`php >=8.1`).

There are no other contrib modules, no third-party Composer libraries and no
submodules. Compiler depends on Drupal core only.

## Install with Composer

From the project root:

```bash
composer require drupal/compiler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/compiler -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en compiler -y
```

In most cases you won't enable Compiler by hand at all — when you install a
module that needs it (such as **SCSS Compiler** or **Theme Compiler**), Drupal
and Composer bring Compiler in automatically as a dependency.

## Verify it worked

There is no page to visit and nothing to configure. Compiler is working as soon
as it's enabled — the `plugin.manager.compiler` service becomes available for
other modules and custom code to use. To confirm it's on, check the module list:

```bash
drush pm:list --status=enabled | grep compiler
```
