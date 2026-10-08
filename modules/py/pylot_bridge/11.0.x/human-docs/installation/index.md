# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core **Node** (`node`) and the **[Components](https://www.drupal.org/project/components)**
  module (`components`) — pulled in as dependencies.
- Access to a **Pylot / Bridge CMS** backend and its credentials.

> **Security coverage:** this project is **not** covered by Drupal's security
> advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/pylot_bridge -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
and brings in the Components module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pylot_bridge -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pylot_bridge -y
```

## Store the Pylot backend credentials securely

The Pylot backend credentials are sensitive. Never hard-code or commit them —
supply them through the environment. With DDEV:

```bash
ddev dotenv set .ddev/.env --pylot-api-key=<value>
ddev restart
```

(`--pylot-api-key` becomes the environment variable `PYLOT_API_KEY` inside the
container; keep `.ddev/.env` out of version control.) Read the value in Drupal via
a Key entity where supported, or `getenv('PYLOT_API_KEY')` from `settings.php`.

## Verify it worked

1. Confirm the module is enabled: `drush pm:list --status=enabled | grep pylot_bridge`.
