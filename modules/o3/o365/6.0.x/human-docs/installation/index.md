# Installation

## Requirements

- **Drupal 10.2 or newer, or Drupal 11** (`core_version_requirement: ^10.2 || ^11`).
- The **OAuth2 Client** module (`oauth2_client`) — provides the OAuth flow.
- The **External Authentication** module (`externalauth`) — maps Microsoft
  identities onto Drupal accounts.
- A **Microsoft 365 / Entra ID** tenant where you can register an application
  (app registration) and obtain a client ID and client secret.

Composer pulls in the two contributed module dependencies automatically.

> **Note on maturity:** the packaged release is `6.0.0-beta6`. Test it thoroughly
> before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/o365 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies — including OAuth2 Client and External Authentication — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/o365 -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it together with its dependencies:

```bash
drush en oauth2_client externalauth o365 -y
```

## Run database updates

The module ships post-update steps, so run database updates after installing or
upgrading:

```bash
drush updatedb -y
```

## Next steps

You now need a Microsoft app registration and a connector before sign-in will
work — and you should grant the module's permissions to the right roles. See
[Configuration](../configuration/index.md).

There are no submodules.
