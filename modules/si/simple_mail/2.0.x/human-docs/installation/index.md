# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- A working outbound mail setup on the server (the default backend extends core's
  PHP mailer), or another configured mail transport.

There are no contrib dependencies and no third‑party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_mail -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/simple_mail -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_mail -y
```

There are no submodules. The helper functions `simple_mail_send()` and
`simple_mail_queue()` are available immediately; visit the settings form to toggle
the queue or set an email override — see [Configuration](../configuration/index.md).
