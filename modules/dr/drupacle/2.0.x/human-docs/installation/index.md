# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- The **OCI8** Oracle driver installed and enabled in PHP on your server — this is
  what lets PHP (and therefore Drupal) talk to Oracle. Install it before creating
  any connection.
- Network access from your Drupal server to the Oracle database(s) you intend to
  connect to.

There are no additional Composer package dependencies declared by the module
itself.

## Install the OCI8 driver

Drupacle uses PHP's OCI8 functions, so the OCI8 extension (and the Oracle Instant
Client it depends on) must be present in your PHP environment. Install and enable
it on the server first; without it, connections will not work.

> **Using DDEV?** OCI8 is not part of the default DDEV web image. You will need to
> add the Oracle Instant Client and the `oci8` PHP extension to the web container
> (for example via a `.ddev/web-build` Dockerfile) and `ddev restart` before
> Drupacle can connect.

## Install with Composer

From the project root:

```bash
composer require drupal/drupacle -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/drupacle -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drupacle -y
```

## Verify it worked

Confirm the OCI8 extension is loaded (for example `php -m | grep oci8`, or inside
DDEV `ddev exec 'php -m | grep oci8'`). Then visit
**/admin/drupacle/connections** and create your first connection — see
[Configuration](../configuration/index.md).
