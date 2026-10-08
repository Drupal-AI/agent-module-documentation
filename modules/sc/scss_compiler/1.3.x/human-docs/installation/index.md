# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The **scssphp/scssphp** PHP library (`^1.0.0`) — this is the compiler itself.
  Composer installs it automatically when you require the module, which is why you
  should always install via Composer rather than downloading the module by hand.

No other contrib modules are required.

## Install with Composer

From the project root:

```bash
composer require drupal/scss_compiler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the required `scssphp/scssphp` library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/scss_compiler -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en scss_compiler -y
```

Once enabled, its options appear on the core **Performance** page
(`/admin/config/development/performance`) — see
[Configuration](../configuration/index.md). To compile `.less` files as well as
`.scss`, map the `less` extension to the Less backend there.
