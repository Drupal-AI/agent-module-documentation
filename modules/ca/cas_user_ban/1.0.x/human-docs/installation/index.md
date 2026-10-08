# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **CAS** module (`cas`) — required. CAS User Ban extends the CAS
  single-sign-on flow and cannot work without it.

There are no additional PHP or third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/cas_user_ban -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. The CAS module is pulled in as a dependency if it is not
already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cas_user_ban -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cas_user_ban -y
```

## Verify it worked

Go to **People** (`/admin/people`) and start deleting a test user. The deletion flow
should now offer an option to **ban** the account's CAS username. Choose it, complete
the deletion, and confirm that logging back in with that CAS identity no longer
recreates the account.
