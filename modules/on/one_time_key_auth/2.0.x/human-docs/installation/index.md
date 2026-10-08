# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No other modules, and no third‑party Composer or PHP libraries.

The module creates its own database table (`one_time_key_auth`) to store issued
keys and their expiry; this is set up automatically when you enable it.

## Install with Composer

From the project root:

```bash
composer require drupal/one_time_key_auth -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/one_time_key_auth -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en one_time_key_auth -y
```

Enabling the module activates the global authentication provider immediately, so
from this point any request carrying a valid `?otka=` key is authenticated. The
module stays dormant, however, until your own code calls its service to generate
a key — see [How to use it](../index.md#how-to-use-it).

## Verify it worked

Confirm the module is enabled on the **Extend** page. To test end to end,
generate a key for a test user from your code (or a quick `drush php:eval`),
then request a page with `?otka=<key>` appended over HTTPS and confirm the
response reflects that user. Requesting the same key a second time should no
longer authenticate — proof that single‑use enforcement is working.
