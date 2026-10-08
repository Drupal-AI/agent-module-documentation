# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- The **SAML Authentication** module (`samlauth`), configured against your
  identity provider.
- The **Group** module. The module's release branches follow the Group module's
  major version — this **3.x** branch is built for **Group 3**. Match the branch
  to your installed Group major version (2.x ↔ Group 2, 3.x ↔ Group 3, and so
  on).

There are no additional PHP or third‑party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/samlauth_group -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in `samlauth` (and,
if permitted, Group) and update shared dependencies as needed. Make sure the
Group major version Composer resolves matches this module's branch.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/samlauth_group -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en samlauth_group -y
```

## Verify it worked

After enabling, go to the **SAML Authentication** configuration page and confirm a
**Group / Membership** tab is present. That tab is where you set your mappings —
see [Configuration](../configuration/index.md).
