# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- **PHP 8.1 or newer**.
- The **[Mailsystem](https://www.drupal.org/project/mailsystem)** module
  (`drupal/mailsystem ^4.1`) — a hard dependency, used to make Azure Mailer the
  active mail backend.
- The **`mobomo/guzzle-azure-hmac-auth`** Composer library, which signs each
  request with Azure's HMAC scheme. This is pulled in automatically by Composer.
- An **Azure Communication Services** resource with Email enabled, giving you an
  endpoint host and an access key.

> **Heads‑up on the signing library:** the module requires
> `mobomo/guzzle-azure-hmac-auth` at `dev-main` (an unpinned development
> constraint). For a production build it is worth reviewing and pinning that
> dependency to a specific commit.

## Install with Composer

From the project root:

```bash
composer require drupal/azure_mailer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Mailsystem and the
HMAC signing library and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/azure_mailer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en azure_mailer -y
```

Enabling Azure Mailer also enables Mailsystem if it is not already on. There are
no submodules.

## Next step

Nothing is sent through Azure until you set the endpoint and secret and select the
mailer in Mailsystem — see [Configuration](../configuration/index.md).
