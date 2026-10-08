# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **[Config Patch](https://www.drupal.org/project/config_patch)** module
  (`config_patch`) — this is a hard dependency and provides the patch‑generation framework
  that this plugin outputs to. Install and enable it first (or let Composer/Drush pull it
  in).
- A **GitLab** instance (self‑hosted or gitlab.com) and a **project access token** with the
  `api` and `write_repository` scopes for the target project — see
  [Configuration](../configuration/index.md).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/config_patch_gitlab_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Config Patch dependency
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_patch_gitlab_api -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_patch_gitlab_api -y
```

Drupal will enable **Config Patch** at the same time if it is not already on.

## Verify it worked

Log in as a user with the **Administer config patch GitLab API** permission and open the
credentials form (`config_patch_gitlab_api.credentials`). If it loads, the plugin is
installed. Next, work through [Configuration](../configuration/index.md) to connect it to
your GitLab project — and remember the advice there to test against a scratch repository
first, since this is an alpha release that pushes to your repo.
