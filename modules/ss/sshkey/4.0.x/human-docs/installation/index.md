# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Core's **Field** module (`field`) — part of Drupal core, enabled automatically
  as a dependency.
- The `phpseclib/phpseclib` library (version `^3.0`), used for structural key
  validation and fingerprinting. Composer pulls it in automatically when you
  require the module.

## Install with Composer

From the project root:

```bash
composer require drupal/sshkey -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sshkey -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sshkey -y
```

## Verify it worked

Go to **Structure**, open **Manage fields** for any entity bundle (a content type
or the User account), and start adding a field. **SSH Key** should appear in the
list of field types. If it does, the module and the phpseclib library are
installed correctly — see the *How to use it* section of the
[main guide](../index.md) to add and configure a field.
