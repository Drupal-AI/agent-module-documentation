# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- No additional contrib modules or third‑party libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/first_time_login -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/first_time_login -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en first_time_login -y
```

When you enable the module, it sets the "profile last updated" timestamp for all
existing users to their **last access time**. This prevents every existing user from
being prompted on their next login — only accounts that log in after not updating
for longer than the threshold are prompted.

## Verify it worked

Create a test user with a temporary password (or use an existing account) and log in
as that user. You should be prompted to update the password. Note that the super
user (UID 1) is intentionally never prompted. To adjust how often users are
re-prompted, see [Configuration](../configuration/index.md).
