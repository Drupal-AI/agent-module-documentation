# Installation

## Requirements

Reroute Email needs:

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- No other contrib modules — it declares no dependencies.

This is a **release candidate** (2.3.0‑rc2). There are no third‑party Composer or
PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/reroute_email -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/reroute_email -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en reroute_email -y
```

Rerouting is **off by default** — enabling the module alone does not intercept any
mail. You turn it on in [Configuration](../configuration/index.md).

## Submodules — enable only if you need it

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Reroute Email Symfony Mailer** | `reroute_email_symfony_mailer` | A rerouting handler for the Symfony Mailer transport, so mail sent through Symfony Mailer is also rerouted. Enable it only if your site uses Symfony Mailer. |

```bash
drush en reroute_email_symfony_mailer -y
```

## Verify it worked

Go to **Configuration → Development → Reroute Email**
(`/admin/config/development/reroute_email`). You should see the settings form with
rerouting disabled. Continue to [Configuration](../configuration/index.md) to
enable and target it.
