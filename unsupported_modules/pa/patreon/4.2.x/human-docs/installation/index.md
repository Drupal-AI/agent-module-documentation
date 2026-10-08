# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Composer is required** — not optional. The module depends on Patreon's
  official PHP API library, which is only installed via Composer. Do not try to
  install this module by downloading a tarball.
- A **Patreon OAuth client** (client ID and secret), which you create by
  registering an application at
  <https://www.patreon.com/portal/registration/register-clients>. You'll need this
  before the module can do anything — see [Configuration](../configuration/index.md).

There are no other contrib module dependencies for the base module.

## Install with Composer

From the project root:

```bash
composer require drupal/patreon -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Patreon PHP
library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/patreon -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en patreon -y
```

## Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Patreon User** | `patreon_user` | Lets patrons log in to Drupal with their Patreon account (creating a matching Drupal account) and assigns roles from their patron/pledge data. Adds a public login callback at `/patreon_user/oauth`. |
| **Patreon Extras** | `patreon_extras` | Adds tokens and helper functionality for surfacing Patreon data around the site. |

Enable a submodule when you need it, for example:

```bash
drush en patreon_user -y
```

## Register the callback URLs

Whichever pieces you enable, you must register the module's OAuth callback URLs as
**allowed redirect destinations** in your Patreon client application:

- `https://your-site.example/patreon/oauth` (base module, admin authorisation)
- `https://your-site.example/patreon_user/oauth` (only if using Patreon User)

## Verify it worked

Go to **Configuration → Web services → Patreon → Settings**
(`/admin/config/services/patreon/settings`). If the settings form loads, the module
is installed correctly. From there, continue to
[Configuration](../configuration/index.md) to enter your client credentials and
authorise the site.
