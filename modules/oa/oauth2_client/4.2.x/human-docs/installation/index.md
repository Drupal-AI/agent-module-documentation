# Installation

## Requirements

- **Drupal 11.4, or 12** (`core_version_requirement: ^11.4 || ^12`).
- **PHP 8.3 or newer** (`php: >=8.3`).
- The **`league/oauth2-client`** PHP library (`^2.6`), which does the actual
  OAuth2 work. Composer installs it for you.
- Optionally, the **Key** module (`drupal/key`) — strongly recommended, so you
  can store client credentials in a Key entity (backed by an environment
  variable) rather than in Drupal's State store.

## Install with Composer

From the project root:

```bash
composer require drupal/oauth2_client -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the
`league/oauth2-client` library at a compatible version. If you plan to store
credentials in a Key (recommended), add the Key module too:

```bash
composer require drupal/oauth2_client drupal/key -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/oauth2_client -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en oauth2_client -y
```

If you are using the Key module for credentials, enable it as well:

```bash
drush en key -y
```

## Submodule — example plugins

The module ships one optional submodule, **OAuth2 Client Example Plugins**
(`oauth2_client_example_plugins`), which provides four ready‑to‑read example
client plugins (one per grant type). Enable it on a development site if you want
working code to copy from:

```bash
drush en oauth2_client_example_plugins -y
```

You would not normally leave the example plugins enabled on production.

## Verify it worked

Log in as an administrator and go to **Configuration → System → OAuth2 Client**
(`/admin/config/system/oauth2-client`). You should see the (initially empty)
OAuth2 clients list, with a button to add one. See
[Configuration](../configuration/index.md) for the next steps.
