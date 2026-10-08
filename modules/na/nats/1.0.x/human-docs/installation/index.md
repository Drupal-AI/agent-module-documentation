# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **`basis-company/nats.php`** PHP library — this is pulled in automatically by
  Composer when you require the module.
- A reachable **NATS server** (its URL and, if used, credentials — configured in
  `settings.php`, see [Configuration](../configuration/index.md)).
- Network access from your Drupal server to the NATS server.

## Install with Composer

Always install this module with Composer so the `basis-company/nats.php` library
is fetched too. From the project root:

```bash
composer require drupal/nats -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update the NATS library
and any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/nats -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en nats -y
```

## Verify it worked

The module has no UI to click, so verification happens through configuration and
code. After adding at least one named client configuration to `settings.php` (see
[Configuration](../configuration/index.md)), request that client from the service
in custom code (or a quick Drush PHP snippet) and confirm it connects to your NATS
server without error.
