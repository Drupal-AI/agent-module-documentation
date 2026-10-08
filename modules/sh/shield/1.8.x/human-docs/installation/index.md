# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- Core's **Path alias** module (`path_alias`) — the one dependency, enabled on
  virtually every Drupal site already.
- No third‑party Composer libraries.

**Optional:** the [Key](https://www.drupal.org/project/key) module
(`drupal/key`). Shield can pull its credentials from a Key entity (the `key` and
`multikey` credential providers) so the password stays out of exported
configuration. Recommended for anything beyond a throwaway credential.

## Install with Composer

From the project root:

```bash
composer require drupal/shield -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. To grab the optional Key module at the same time:

```bash
composer require drupal/shield drupal/key -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/shield -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en shield -y
```

And, if you'll store credentials in a Key entity, enable Key too:

```bash
drush en key -y
```

Enabling the module does **not** turn the shield on by default — you must enable
it and set credentials on the settings form. See
[Configuration](../configuration/index.md).

## Submodules

Shield ships no submodules.
