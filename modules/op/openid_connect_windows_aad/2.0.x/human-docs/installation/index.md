# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 8.0 or newer**.
- The **OpenID Connect** module (`drupal/openid_connect`, `^3.0.0-alpha7`) — the framework
  this plugin extends.
- The **Key** module (`drupal/key`, `^1.0`) — used to store the client secret securely.
- The **lcobucci/jwt** library (`^4.3 || ^5.3`) — used to decode tokens (needed especially
  for Azure AD B2C).

All of these are pulled in automatically by Composer.

> **Heads up:** the installed 2.0 release is a **beta** (`2.0.0-beta10`). Test it on a
> non‑production environment first.

You will also need, on the Microsoft side, an **Entra ID (Azure AD) app registration** with a
Client ID, a client secret, and the redirect URI that OpenID Connect expects — plus the
tenant‑specific authorization and token endpoint URLs.

## Install with Composer

From the project root:

```bash
composer require drupal/openid_connect_windows_aad -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in OpenID Connect, Key, and the
JWT library and update any shared dependencies as needed. Install through Composer (not the
ZIP) so the `lcobucci/jwt` library is present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your host
> machine — `ddev composer require drupal/openid_connect_windows_aad -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en openid_connect_windows_aad -y
```

This enables `openid_connect` and `key` as dependencies if they aren't already on. There are
no submodules.

## After enabling

Nothing changes until you create an OpenID Connect client of type **Windows Azure AD** and
point it at your Entra tenant. Continue to [Configuration](../configuration/index.md).
