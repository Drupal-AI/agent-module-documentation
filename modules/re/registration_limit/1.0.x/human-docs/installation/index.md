# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- No third‑party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/registration_limit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/registration_limit -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en registration_limit -y
```

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Registration Limit User API** | `registration_limit_user_api` | Integrates the IP-based blocking with the [User API](https://www.drupal.org/project/user_api) module, so registrations made through that module's API are also checked. Enable it only if you use User API. |

Enable it the same way if you need it:

```bash
drush en registration_limit_user_api -y
```

## Verify it worked

After enabling, review the settings form to set your time window and whitelist
(see [Configuration](../configuration/index.md)). The module begins recording
login IPs immediately; to confirm blocking, log in with an account, then attempt
to register a new account from the same IP within the configured window — the
registration should be refused unless that IP is whitelisted.
