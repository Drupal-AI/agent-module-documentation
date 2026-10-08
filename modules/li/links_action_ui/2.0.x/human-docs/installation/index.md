# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).

There are no contrib dependencies and no third-party PHP library requirements.

> **Security-advisory note:** this module is **not covered** by Drupal's
> security advisory policy at the documented version. Review it before relying on
> it in production, and grant its management permission only to trusted users
> (action links point at routes and appear in the admin UI).

## Install with Composer

From the project root:

```bash
composer require drupal/links_action_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/links_action_ui -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en links_action_ui -y
```

## Grant the permission

Go to **People → Permissions** and grant the module's action-links management
permission to the roles that should be able to create and manage local actions
(typically administrators or trusted site builders).

## Verify it worked

Go to **Configuration → System → Local actions**
(`/admin/config/system/local-actions`). You should see the management screen
where you can add a new local action. Create one and confirm the button appears
on the page(s) you assigned it to — see
[Configuration](../configuration/index.md).
