# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Flag** module (`flag`) — Flag Assign User builds directly on it, and it is
  installed as a dependency.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/flag_assign_user -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Flag module
and any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/flag_assign_user -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flag_assign_user -y
```

This also enables the Flag module if it isn't already on.

## Grant the permission

Assigning flags on behalf of other users is a privileged action. At
**People → Permissions** (`/admin/people/permissions`), grant the Flag Assign
User permission only to a trusted administrator role. Do not give it to ordinary
authenticated users — it lets the holder change other people's flag state.

## Verify it worked

Confirm you have at least one flag defined at **Structure → Flags**
(`/admin/structure/flags`). Then, as a user with the permission, use the assign
form to set that flag on some content for another user and check that the flag now
appears against that user's account.
