# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **User** system (always present) — this module extends the base user
  entity.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/decoupled_auth -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/decoupled_auth -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en decoupled_auth -y
```

## Submodules

Decoupled User Authentication ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Decoupled Auth CRM** | `decoupled_auth_crm` | CRM‑oriented helpers built on top of the login‑less user capability, for using Drupal to store and manage contacts. Enable it only if you are building a CRM‑style workflow. |

Enable it when you need it:

```bash
drush en decoupled_auth_crm -y
```

## Verify it worked

After enabling, the module's capability is active site‑wide: user records can now
exist in a decoupled (login‑less) state. Confirm the module appears as enabled at
**Extend** (`/admin/modules`). Because decoupled users are managed through code and
integrating modules (Simplenews, Commerce, Profile, and so on), the clearest way to
verify your setup is to run through the specific workflow you installed it for and
confirm that the login‑less records behave as expected — in particular, that a
decoupled user cannot log in.
