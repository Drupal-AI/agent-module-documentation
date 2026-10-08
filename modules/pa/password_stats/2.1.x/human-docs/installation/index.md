# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1||^11`). Drupal 10.1 is
  the point at which core adopted PHP's native password hashing, which is what this
  module reports on.
- No other modules are required, and there are no third‑party Composer or PHP
  library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/password_stats -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/password_stats -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en password_stats -y
```

There is no configuration step — the module adds a line to the Status report and a
pair of Drush commands as soon as it is enabled.

## Verify it worked

Go to **Administration → Reports → Status report** and look under the **Password
Compatibility** heading — you should see the total hash count and the number of
active users still on pre‑10.1 hashes. You can also run
`drush password_stats:total` and `drush password_stats:legacy` to confirm the
commands respond.
