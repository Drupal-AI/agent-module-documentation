# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.3 or higher.**
- The contrib **OpenID Connect** module, **^3.0** (`drupal/openid_connect`) — this
  is a client plugin for it.
- **firebase/php-jwt ^7.0** — the JWT library used for signature validation;
  installed automatically when you use Composer.
- A **client ID and secret** from your OpenID Connect provider, and the provider's
  signing keys (PEM or JWKS) if you enable signature validation.

Installing with `-W` pulls OpenID Connect and firebase/php-jwt in automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/openid_client_advanced -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the OpenID
Connect module, the JWT library, and any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/openid_client_advanced -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en openid_client_advanced -y
```

Enable OpenID Connect too if Drush doesn't pull it in automatically:

```bash
drush en openid_connect -y
```

Clear caches if prompted (`drush cr`).

## Verify it worked

After enabling, go to [Configuration](../configuration/index.md), add a client in
OpenID Connect and choose the **OAuth 2.0 Advanced** plugin. Being able to select
that plugin confirms the module is active. Then configure and test a login.
