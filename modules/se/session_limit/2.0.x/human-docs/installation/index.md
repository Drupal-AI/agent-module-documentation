# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no module dependencies, no third‑party Composer libraries, and no special
PHP extensions — Session Limit works with core alone. (The optional feature that
ignores masqueraded sessions only applies if you also run the **Masquerade**
module.)

## Install with Composer

From the project root:

```bash
composer require drupal/session_limit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/session_limit -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en session_limit -y
```

There are no sub‑modules. As soon as it is enabled, the module enforces its default
of **one active session per user** — so review the [Configuration](../configuration/index.md)
before turning it on in production, especially if some roles need more than one
session.
