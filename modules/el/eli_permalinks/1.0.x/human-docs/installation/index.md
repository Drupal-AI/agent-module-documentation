# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Drupal core's **File** (`file`) and **Options** (`options`) modules — both ship
  with core and are enabled automatically as dependencies.

No contributed modules are required.

> **Note:** This project's security advisory coverage is marked *not covered* by
> the Drupal Security Team. Weigh that before relying on it for a
> compliance‑critical site.

## Install with Composer

From the project root:

```bash
composer require drupal/eli_permalinks -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/eli_permalinks -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eli_permalinks -y
drush cr
```

## Grant the permission

Give the roles that should manage permalinks the **Administer ELI permalinks**
permission at **People → Permissions**
(`/admin/people/permissions`). This permission gates creating, editing, and
deleting permalinks.

## Verify it worked

Log in as a user with the permission and go to **Content → ELI Permalinks**. You
should see the permalink list with a button to add a new one. Create a test
permalink pointing at a URL, enable it, and visit its `/eli/…` path — you should
be redirected to your destination.
