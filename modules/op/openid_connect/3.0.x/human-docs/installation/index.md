# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- **PHP 8.1 or newer**, with the JSON extension (`ext-json`, standard in modern PHP).
- Core's **File** module (`file`), enabled automatically as a dependency.
- The contrib **External Authentication** module (`drupal/externalauth`, `^2.0`),
  which Composer installs for you. The module uses its authmap to link external
  identities to Drupal accounts.

> **Heads up:** the 3.0.x branch is an **alpha** release (`3.0.0-alpha8`). Review it
> and test your login flow thoroughly before using it on a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/openid_connect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it pulls in the `externalauth` module automatically.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/openid_connect -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en openid_connect -y
```

This enables the External Authentication and File modules as dependencies too.

## Grant permissions

The module defines several permissions, all flagged "restrict access":

- **Administer OpenID Connect clients** — full access to the client list, the
  add/edit/delete/enable/disable actions, and the global settings form. Give this
  only to trusted administrators.
- **Manage own OpenID Connect accounts** — lets a user connect their own account to
  a provider on the Connected Accounts form. Typically granted to authenticated
  users.
- **Disconnect OpenID connected accounts** — lets a user disconnect a linked
  provider.
- **OpenID Connect set own password** — lets a user who logs in via a provider set a
  local password (needed before they can log in locally or disconnect).

For example, to let logged-in users link their own accounts:

```bash
drush role:perm:add authenticated 'manage own openid connect accounts'
```

## Next step

Head to [Configuration](../configuration/index.md) to add your first identity
provider, register the redirect URI with it, and set the global login behavior.
