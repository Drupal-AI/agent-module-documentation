# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other module dependencies and no third-party Composer or PHP libraries.
- The server environment must actually be able to run whatever build commands
  you configure.

## Install with Composer

From the project root:

```bash
composer require drupal/build_scripts -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Note this is a **beta** release (`2.0.0-beta2`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/build_scripts -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en build_scripts -y
```

## Next step

Grant the two permissions only to trusted operators, then define and run your
build programs — see [How to use it](../index.md#how-to-use-it). Because a
configured command runs on your server, treat **administer build_scripts
configuration** and **use build_scripts** as equivalent to shell access.
