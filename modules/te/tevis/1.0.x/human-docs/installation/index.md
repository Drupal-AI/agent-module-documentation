# Installation

## Requirements

- **Drupal 10, 11 or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- The **`krzn/tevis-sdk`** client library, which provides the reservation API
  client. Composer downloads it for you automatically when you require the
  module — you do not need to fetch it by hand.
- Access to a VOIS|TEVIS instance: you will need its API endpoint URL and an API
  key to configure a server.
- No other contrib Drupal modules are required.

## Install with Composer

From the project root:

```bash
composer require drupal/tevis -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the `krzn/tevis-sdk` library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/tevis -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tevis -y
```

## Verify it worked

Log in as an administrator and go to
**Configuration → Web services → TEVIS** (`/admin/config/services/tevis`). If the
TEVIS server list opens, the module and its library are installed correctly. The
next step is to add a server — see [Configuration](../configuration/index.md).
