# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- **PHP 8.0** or newer.
- Two Composer libraries, pulled in automatically when you install with Composer:
  - `softcreatr/jsonpath` — lets log fields be selected by JSONPath expression.
  - `adhocore/json-fixer` — repairs malformed JSON before output.

> **Version note:** at the time of writing the release line is a beta
> (`1.3.0-beta2`). Test before relying on it in production.

## Install with Composer

Because of the two third-party libraries, installing **with Composer** (not a
manual download) is important so the dependencies are resolved. From the project
root:

```bash
composer require drupal/extended_logger -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/extended_logger -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en extended_logger -y
```

The module starts working immediately, writing to a `drupal.log` file by default
until you change the target on the settings page.

## Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Database storage** | `extended_logger_db` | Stores log records in the database. |
| **Fallback** | `extended_logger_fallback` | A secondary destination used when the primary one is unavailable, so logging doesn't fail silently. Enable it whenever your primary destination is remote (syslog, an aggregator). |

For example:

```bash
drush en extended_logger_fallback -y
```

## Verify it worked

Enable the module, trigger some site activity, and check your configured
destination — by default the `drupal.log` file. You should see JSON-formatted log
lines. Then visit **Configuration → Development → Extended Logger** to confirm the
settings form loads.

Next, see [Configuration](../configuration/index.md) to pick your output target and
the fields each entry carries.
