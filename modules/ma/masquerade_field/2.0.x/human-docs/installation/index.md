# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4 || ^11`).
- The **Masquerade** module (`masquerade`) — this is a hard dependency. Masquerade
  Field extends it and does not replace its permission model. Composer installs it
  for you with the `-W` flag below.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/masquerade_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Masquerade
dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/masquerade_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en masquerade_field -y
```

Enabling Masquerade Field also enables Masquerade if it is not already on.

## Verify it worked

Go to the User entity's **Manage fields** at
`admin/config/people/accounts/fields` — you should be able to add the masquerade
user reference field. Then review the new permissions (`edit masquerade field`,
`view own masquerade field`, `view any masquerade field`) at **People →
Permissions**. See "How to use it" in the [overview](../index.md) for the full
setup, and grant `edit masquerade field` only to fully trusted staff.
