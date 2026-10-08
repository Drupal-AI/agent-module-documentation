# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **User** module (always present).
- The contributed **Config Update** module (`config_update`) — Profile Updates
  uses it to compute the diff between shipped and active configuration. Composer
  pulls it in automatically with the command below.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/profile_updates -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in `config_update`
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/profile_updates -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en profile_updates -y
```

Drupal enables `config_update` at the same time if it isn't already on.

## Verify it worked

Log in as an administrator and visit **Configuration → Development → Profile
updates** (`/admin/config/development/profile-updates`). You should see the
review list. If your install profile (or an enabled module) ships
`update_tasks/*.yml` files, any pending updates appear here; if none are shipped,
the list is simply empty until one is. See the
[main guide](../index.md#how-to-use-it) for the apply/skip/restore workflow.
