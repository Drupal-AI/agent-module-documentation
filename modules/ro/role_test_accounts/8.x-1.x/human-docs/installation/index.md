# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **User** module (`user`), part of a standard Drupal install.
- No third-party Composer or PHP libraries.
- A **non-production** environment — this is a development/QA tool and must not run
  on a live site.

## Install with Composer

From the project root:

```bash
composer require drupal/role_test_accounts -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/role_test_accounts -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

On a local or staging environment only:

```bash
drush en role_test_accounts -y
```

Do not enable this on production — see the warning on the [overview page](../index.md).

## Verify it worked

Open the Role Test Accounts settings form (`role_test_accounts.settings`), generate
the accounts, then check **People** (`/admin/people`) and confirm a test account now
exists for each role. When you are done testing, remove the accounts (and disable the
module) so no extra credentialed users are left behind.
