# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- PHP's **`exec()`** function must be enabled (not listed in `disable_functions`).
- The **`git`** binary must be installed and executable from PHP (on the server's
  PATH).

If either the `git` binary or `exec()` is unavailable, the module reports an error
on install and on the status report page — that is expected, and the fix is to
make `git`/`exec()` available in your PHP environment.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/git_deploy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/git_deploy -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix. DDEV's web container
> already includes `git`.

## Enable the module

```bash
drush en git_deploy -y
```

Enabling the module is the entire configuration — there is nothing else to set.

## Verify it worked

1. Go to **Reports → Status report** (`/admin/reports/status`) and confirm there
   is no Git Deploy requirement error.
2. Go to **Reports → Available updates** (`/admin/reports/updates`) and confirm
   your Git‑checked‑out projects now display real version numbers instead of
   unsupported‑version warnings.
