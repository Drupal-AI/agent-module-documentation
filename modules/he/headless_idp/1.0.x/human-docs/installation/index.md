# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- **Simple OAuth** (`simple_oauth`) and **External Authentication**
  (`externalauth`) — both hard dependencies. Composer pulls them in with the
  command below.
- An account with one of the supported external identity providers — **AWS
  Cognito**, **Okta**, **Microsoft Entra ID**, or **Entra External ID (CIAM)** —
  configured so your front end can sign users in and receive a JWT.

> **Beta release.** This is a `1.0.0-beta4` release under active development.
> It is covered by Drupal's security advisory policy, but test thoroughly before
> production use.

## Install with Composer

From the project root:

```bash
composer require drupal/headless_idp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including Simple OAuth and External Authentication.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/headless_idp -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en headless_idp -y
```

This also enables Simple OAuth and External Authentication if they weren't
already on.

## Verify it worked

Once enabled, the JSON auth API endpoints (such as `/auth/login` and `/session`)
are available and the module provides its own permissions and Drush commands. Use
the Drush command that inspects configured providers to confirm the module is
running, then continue to [Configuration](../configuration/index.md) to connect a
provider. Migrating from `openid_connect`? The module ships a Drush command for
that too.
