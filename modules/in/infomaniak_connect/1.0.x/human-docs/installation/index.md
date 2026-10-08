# Installation

## Requirements

- **Drupal 10.1 or newer** (11 and 12 are supported;
  `core_version_requirement: ^10.1 || ^11`).
- The **OpenID Connect** module (`openid_connect`) — a hard dependency that
  provides the login flow this client plugs into. Composer pulls it in
  automatically.
- An **Infomaniak account** with access to the Infomaniak Manager, so you can
  create an OAuth application and obtain a Client ID and Client secret.

There are no additional third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/infomaniak_connect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies (including OpenID Connect) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/infomaniak_connect -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en infomaniak_connect -y
```

Enabling it also enables OpenID Connect if it is not already on.

## Verify it worked

Log in as an administrator and go to **Configuration → People → OpenID Connect**
(`/admin/config/people/openid-connect`). You should see **Infomaniak OAuth 2.0**
listed as an available, preconfigured client. Continue to
[Configuration](../configuration/index.md) to enter your credentials and switch on
the login button.
