# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- Core's **Field** module (`field`), which is part of a standard Drupal install.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/lock_field_values -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/lock_field_values -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lock_field_values -y
```

## Set it up

After enabling, there are two quick steps (covered on the
[overview page](../index.md)):

1. Edit the field settings for each field you want to be lockable and check
   **"Administrator can lock values."**
2. Grant the **"Lock and unlock fields"** permission to the appropriate roles on
   **People → Permissions**.

## Verify it worked

Edit a field where you enabled "Administrator can lock values," then edit a piece
of content that uses it. A user with the "Lock and unlock fields" permission should
be able to lock the value; a user without it should find the locked field's value
can no longer be changed.
