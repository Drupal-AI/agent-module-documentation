# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Devel** module (`drupal/devel`, ^5.1) — a hard dependency; it provides the
  dumper (Kint by default) that pretty‑prints array/object messages.
- Core's **Serialization** module (`serialization`) — also a dependency, enabled
  automatically.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/devel_debug_log -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Devel and update
any shared dependencies as needed.

Since this is a development tool, many teams install it as a dev‑only dependency:

```bash
composer require --dev drupal/devel_debug_log -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/devel_debug_log -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en devel_debug_log -y
```

Drupal enables **Devel** and **Serialization** at the same time as dependencies.

## Grant access to the debug page

Give the trusted developer role the permission to view (and clear) the log:

```bash
drush role:perm:add developer 'access debug messages'
```

There is no configuration form. Start dropping `ddl()` calls into your code and
read the results at **Reports → Debug messages** — see
[How to use it](../index.md#how-to-use-it).

## Don't leave it on in production

This module renders stored debug markup on an admin page and is intended for
development and staging only. Disable or uninstall it on production sites.
