# Installation

## Requirements

Atomic CAS needs:

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **File** module (`file`) — enabled automatically as a dependency.

There are no third‑party PHP library requirements. To take advantage of accelerated
delivery you can optionally configure your web server for X‑Accel‑Redirect (Nginx)
or X‑Sendfile (Apache), but this is not required.

## Install with Composer

From the project root:

```bash
composer require drupal/atomic_cas -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Note this is a **beta** release — test it before relying on
it in production.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/atomic_cas -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en atomic_cas -y
```

Core's File module is enabled automatically. After enabling, grant the **Administer
atomic CAS** permission to trusted roles and point file/image fields at the
`cas-public://` or `cas-private://` schemes — see the
[overview guide](../index.md#how-to-use-it).
