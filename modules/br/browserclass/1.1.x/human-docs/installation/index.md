# Installation

## Requirements

Browser Class is lightweight and self‑contained. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).

There are no contrib dependencies and no third‑party Composer or PHP libraries. The
body‑class script uses core's jQuery, which the module attaches for you.

## Install with Composer

From the project root:

```bash
composer require drupal/browserclass -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/browserclass -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en browserclass -y
```

That is all it takes — there are no submodules and no configuration. The browser,
platform, and device classes appear on `<body>` immediately, and the tokens become
available for use.
