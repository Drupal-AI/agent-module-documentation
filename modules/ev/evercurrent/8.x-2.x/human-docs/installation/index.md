# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Update** module (`update`), which supplies the update/version data. Drupal
  enables it automatically as a dependency.
- Outbound HTTPS access from your web server to the Evercurrent service, and an account
  at Evercurrent with an **API key** for the site (see
  [Configuration](../configuration/index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/evercurrent -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/evercurrent -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en evercurrent -y
```

Install it on your **production** site — Evercurrent expects one API key per
environment, so avoid enabling reporting on development or staging copies (see the
[Configuration](../configuration/index.md) page for how to keep those from reporting).

## Verify it worked

Log in as an administrator and open the module's settings form (via its *Configure*
link on **Extend**). If the form loads and asks for your API key, the module is
installed. Continue to [Configuration](../configuration/index.md) to enter your key.
