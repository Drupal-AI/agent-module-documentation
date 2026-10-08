# Installation

## Requirements

- **Drupal 10.3 or newer, or Drupal 11** (`core_version_requirement:
  ^10.3 || ^11`).
- **PHP 8.1 or newer** (`php >=8.1`).
- The **Compiler** module (`drupal/compiler` `^1.0@alpha`) — the plugin framework
  it builds on. Composer installs it automatically.
- The **`sabre/uri`** library (`^2.2`), used for URI handling. Composer installs
  it automatically.
- **A compiler plugin** for whatever you want to compile. Theme Compiler itself
  ships no compilers — for SCSS you'll also want
  [SCSS Compiler](../../../compiler_scss/1.0.x/human-docs/index.md)
  (`compiler_scss`), which registers the `scss` compiler.

Because of the `sabre/uri` library, install this module **with Composer** rather
than by downloading a zip.

## Install with Composer

From the project root:

```bash
composer require drupal/theme_compiler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Compiler
module and the `sabre/uri` library and reconcile any shared dependencies.

To also get the SCSS compiler in one go:

```bash
composer require drupal/theme_compiler drupal/compiler_scss -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/theme_compiler -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en theme_compiler -y
```

Enabling Theme Compiler also enables the base **Compiler** module if it isn't on
already. If you're compiling SCSS, enable the SCSS compiler too:

```bash
drush en compiler_scss -y
```

## Verify it worked

There is no admin page. To confirm the module is picking up a theme's
`THEME.theme_compiler.yml`, add such a file to an enabled theme, run `drush cr`,
then request one of the target URLs (for example `/themes/custom/my_theme/css/style.css`).
Before the first request the file may return a cacheable 404 until it's
generated; once compiled, the CSS is served and stored under
`public://theme-compiler-assets/`.
