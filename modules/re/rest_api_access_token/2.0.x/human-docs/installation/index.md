# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No contrib module dependencies and no third-party Composer libraries.
- You will normally use it alongside core's **REST** and/or **JSON:API** modules —
  it authenticates requests to those APIs, but does not require them to be enabled
  to install.

## Install with Composer

From the project root:

```bash
composer require drupal/rest_api_access_token -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rest_api_access_token -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rest_api_access_token -y
```

There are no submodules.

## Grant the admin permission

The module defines one permission, **Administer rest api access token**
(`administer rest api access token`), which controls access to the settings form.
Grant it only to trusted administrators at **People → Permissions**
(`/admin/people/permissions`), since it governs how API authentication behaves
site-wide.

## First configuration is required

Note that the module ships **no default configuration**, so signature verification
and caching are off and the token lifetime is infinite until you save the settings
form at least once. Head to
[Configuration](../configuration/index.md) to choose login-by-name/email and set a
finite token lifetime before going live.

## Verify it worked

Visit **Configuration → System → REST API Access Token**
(`/admin/config/system/rest_api_access_token`) to confirm the settings form loads.
Then test the login endpoint, for example:

```bash
curl -X POST https://your-site/api/v1/auth/token \
  -H 'Content-Type: application/json' \
  -d '{"login":"your-username","password":"your-password"}'
```

A `200` response with `{ token, secret, userId }` confirms it is working. Use the
returned `token` in the `X-AUTH-TOKEN` header on further requests.
