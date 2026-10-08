# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- [External Entities](https://www.drupal.org/project/external_entities)
  (`external_entities`) plus its SQL storage / cross-schema query submodules —
  notably **`xnttsql`** (Database cross-schema query API) with the **PostgreSQL
  driver** enabled, and External Entities Database storage.
- Access to a **Chado** database (a PostgreSQL database using the Chado schema).

> This is a **beta** release (`1.0.0-beta4`) and the project is **not** covered by
> Drupal's security advisory policy — evaluate accordingly before production use.

## Install with Composer

Install via Composer so the External Entities dependencies are resolved:

```bash
composer require drupal/chadol -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it pulls in External Entities.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/chadol -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en chadol -y
```

Drupal enables the External Entities dependencies at the same time. Make sure the
cross-schema query API's **PostgreSQL driver** is enabled, since Chado is a
PostgreSQL schema.

## Connect the Chado database

If your Chado schema lives in a database separate from Drupal's, add its
connection details to your site's `settings.php` as an additional database
connection. Keep the credentials in an environment variable and read them with
`getenv()` rather than hard-coding secrets:

```php
$databases['chado']['default'] = [
  'driver' => 'pgsql',
  'database' => getenv('CHADO_DB_NAME'),
  'username' => getenv('CHADO_DB_USER'),
  'password' => getenv('CHADO_DB_PASS'),
  'host' => getenv('CHADO_DB_HOST'),
  'port' => '5432',
];
```

(Adjust the connection key and values to your environment.)

## Verify it worked

Confirm the module and its External Entities dependencies are enabled under
**Extend** (`/admin/modules`). Then map some Chado content to Drupal entities
through the External Entities admin UI (see
[How to use it](../index.md#how-to-use-it) in the main guide) and browse the
resulting entities to confirm the Chado data reads through correctly.
