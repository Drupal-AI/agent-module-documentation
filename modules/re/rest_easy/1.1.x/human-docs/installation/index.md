# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- No other module dependencies — REST Easy builds on Drupal core only.
- There are no third-party Composer or PHP library requirements.

Note that at the time of writing this is an alpha release
(`1.1.5-alpha1`); treat it accordingly on a production site and test your endpoints
carefully.

## Install with Composer

From the project root:

```bash
composer require drupal/rest_easy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rest_easy -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rest_easy -y
```

Enabling REST Easy on its own does nothing visible — it is a framework. The
endpoints appear only once you (or a module you install) define API, Endpoint and
Parameter plugins as described in the [main guide](../index.md), and enable the
module that contains them.

## Optional: OpenAPI documentation

REST Easy can generate OpenAPI documentation for the endpoints you build. If you
enable its OpenAPI integration submodule, your API's documentation shows up under
**Configuration → Web services → OpenAPI** (`/admin/config/services/openapi`), a
page provided by the OpenAPI module. Install and enable that integration only if you
want the generated docs.

## Verify it worked

`drush pm:list --status=enabled | grep rest_easy` should show the module enabled.
Beyond that, there is nothing to see until you build an endpoint: create a small
test API with one Endpoint plugin, enable its module, clear caches
(`drush cr`), and request its path. A working endpoint returns your `call()`
method's JSON; remember to add and test the endpoint's access logic before relying
on it.
