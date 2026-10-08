# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.3 or later** — this module requires PHP 8.3+.
- **SQLite support in PHP** — PHP must be compiled with SQLite support (it is
  enabled by default in most distributions).
- A configured, **writable private file system** — a private file path must be set
  in `settings.php`, since the SQLite index files are stored there.
- Core's **SQLite** (`sqlite`) and **Search API** (`search_api`) modules.

There are no third-party Composer packages beyond these.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_sqlite -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_sqlite -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Configure a private file path (if you haven't already)

The backend writes its index databases to the private file system. Make sure
`settings.php` defines a writable private path, for example:

```php
$settings['file_private_path'] = '../private';
```

By default the module stores its databases under `private://search_api_sqlite/`.

## Enable the module

```bash
drush en search_api_sqlite -y
```

## Verify it worked

Go to **Configuration → Search and metadata → Search API**
(`/admin/config/search/search-api`) and add a server. **SQLite FTS5** should appear
in the list of available backends. Selecting it and saving a server with a valid
private file path means the module is installed and ready — continue with
[Configuration](../configuration/index.md).
