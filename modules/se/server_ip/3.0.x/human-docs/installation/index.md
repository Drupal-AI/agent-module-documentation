# Installation

## Requirements

- **Drupal 8 or newer** (`core_version_requirement: >=8`).
- No other module dependencies, and no third-party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/server_ip -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/server_ip -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en server_ip -y
```

By default only the administrator role can reach the module's pages.

## Verify it worked

Go to **Configuration → Server Settings → Server Details**. You should see the
server's IP address along with the default details (database host name, database
name, current theme, path to theme, and base URL). To add more `$_SERVER`
variables or open access to other roles, see
[Configuration](../configuration/index.md).
