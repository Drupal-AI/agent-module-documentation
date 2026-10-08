# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The endpoints you want to protect — typically core's **JSON:API** and/or **REST
  (RESTful Web Services)** modules — enabled and serving data.

There are **no Composer library dependencies** and no other contributed modules
required.

## Install with Composer

From the project root:

```bash
composer require drupal/rest_api_authentication -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rest_api_authentication -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rest_api_authentication -y
```

Enabling the module registers the authentication provider but does **not** start
protecting anything yet — the master switch is off until you turn it on. Continue
with [Configuration](../configuration/index.md).

## Verify it worked

Visit **Configuration → People → REST & JSON API Authentication**
(`/admin/config/people/rest_api_authentication/auth_settings`). You should see the
miniOrange auth settings form. Nothing on your API is protected until you enable
authentication there.
