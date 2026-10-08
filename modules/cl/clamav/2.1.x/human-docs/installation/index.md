# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11.0`).
- A working **ClamAV service** that Drupal can reach — either a ClamAV daemon
  (`clamd`) listening on a TCP port or a Unix socket, or the `clamscan` executable
  installed on the same server as Drupal. This is separate software you install and
  run yourself (for example via your operating system's package manager or your
  hosting platform); the Drupal module only talks to it.

There are no third-party Composer libraries and no other Drupal module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/clamav -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/clamav -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en clamav -y
```

The module has no submodules. Once enabled, head to
[Configuration](../configuration/index.md) to point Drupal at your ClamAV service,
then check **Reports → Status report** to confirm the connection.
