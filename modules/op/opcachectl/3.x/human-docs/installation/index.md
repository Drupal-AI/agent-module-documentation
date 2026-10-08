# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- PHP with **OPcache** available — this is standard on virtually every modern PHP
  install, and it's the cache this module reads and clears.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/opcachectl -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/opcachectl -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en opcachectl -y
```

That's all it takes — there is no required configuration.

## Verify it worked

Log in as an administrator and open the OPcache status page the module provides.
You should see OPcache statistics (memory use, cached scripts) and a control to
clear the opcode cache. Trigger a clear once to confirm it works, then reserve it
for deploy‑time use.

Before you rely on it in production, confirm the status page and clear action are
restricted to administrators — repeated clearing by an unprivileged user could
degrade performance.
