# Installation

> **Before you install:** this project is **unsupported / obsolete**. The
> maintainers recommend using
> [Simple OAuth Password Grant](https://www.drupal.org/project/simple_oauth)
> instead. Use this only to keep an existing site running.

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Simple OAuth** (`simple_oauth`), version 6.x or later.
- **Field Login** (`field_login`), version 3.x or later.

Composer pulls the two module dependencies in for you when you require this
project.

## Install with Composer

From the project root:

```bash
composer require drupal/field_login_simple_oauth -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — here that includes Simple OAuth and Field Login.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_login_simple_oauth -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_login_simple_oauth -y
```

Enabling this module also enables **Simple OAuth** and **Field Login** if they are
not already on.

## Verify it worked

There is no settings page to check. Confirm the module is enabled at **Extend**
(`/admin/modules`), make sure **Field Login** has a login field configured and
**Simple OAuth** has its keys and a consumer set up, then request a password-grant
token using the configured field's value as the `username` — a correct password
should return a token, and a wrong one should not.
