# Installation

## Requirements

Symfony Mailer MS Graph needs:

- **Drupal 10.1, 11 or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- The **Symfony Mailer** module (`symfony_mailer`) — the base mail system this
  transport plugs into. Importantly, use the module branch that matches your
  Symfony Mailer version: this **1.x** branch is for **Symfony Mailer 1.x**;
  Symfony Mailer 2.x needs the module's 2.x branch, otherwise the transports
  will not appear.
- The **Key** module (`key`) — used to store the OAuth2 client secret securely.

A Microsoft Entra (Azure AD) app registration is also required on the Microsoft
side — see [Configuration](../configuration/index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/symfony_mailer_ms_graph -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Symfony Mailer,
Key and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/symfony_mailer_ms_graph -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en symfony_mailer_ms_graph -y
```

Drupal will enable `symfony_mailer` and `key` automatically as dependencies.
Enabling the module also creates the two Microsoft Graph transports ready for
you to configure.

## Verify it worked

Go to **Configuration → System → Mailer transport**
(`/admin/config/system/mailer`). You should see two new transports —
**Microsoft Graph (Application)** and **Microsoft Graph (Delegated)** — listed
alongside any existing ones. Neither will send mail yet; head to
[Configuration](../configuration/index.md) to fill in the credentials.
