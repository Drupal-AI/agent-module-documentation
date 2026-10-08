# Installation

## Requirements

- **Drupal 10.6 or 11.3+** (`core_version_requirement: ^10.6 || ^11.3`).
- **PHP 8.3 or newer**.
- The **Compiler** module (`drupal/compiler` `^2.0`) — installed automatically as
  a dependency.
- **A compiler plugin** to actually transform your sources. For SCSS, that's
  **SCSS Compiler** (`drupal/compiler_scss`). Theme Compiler doesn't compile
  anything by itself — it needs a plugin whose id you reference in your YAML.

## Install with Composer

From the project root:

```bash
composer require drupal/theme_compiler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it will bring in `drupal/compiler`. To compile SCSS,
also require the SCSS plugin:

```bash
composer require drupal/compiler_scss -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/theme_compiler -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en theme_compiler compiler_scss -y
```

(Enabling either module also enables the base `compiler` framework.)

## Verify it worked

Add a `THEME.theme_compiler.yml` to a theme (see "How to use it" in the
[overview](../index.md)), rebuild the cache with `drush cr`, then check that the
compiled file appears under
`sites/default/files/compiled-assets/<theme>/` (i.e.
`public://compiled-assets/<theme>/`). If a source path is wrong or the named
plugin isn't installed, the module logs an error and shows a warning message
rather than breaking the page — so check **Reports → Recent log messages** if the
output file doesn't appear.
