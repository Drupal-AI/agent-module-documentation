# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A **Scaleflex Filerobot account** and its API credentials — the module connects to
  the hosted DAM, so you need an account before it is useful.
- Core's **Media** system, since inserted assets become Drupal files/media.

There are no additional third‑party PHP library requirements.

## Install with Composer

> **Watch the package name.** The module's machine name is `filerobot`, but the
> Composer package is **`drupal/filerobot_by_scaleflex`** — use the package name
> with Composer and the machine name with Drush.

From the project root:

```bash
composer require drupal/filerobot_by_scaleflex -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/filerobot_by_scaleflex -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en filerobot -y
```

## Grant permissions

The module provides its own permissions, and asset insertion is gated by the core
**Administer media** permission. Review these at **People → Permissions**
(`/admin/people/permissions`) and grant them only to trusted content
administrators.

## Verify it worked

Once enabled, connect the module to your Filerobot account
([Configuration](../configuration/index.md)). Then, as a user with **Administer
media**, open the media/content editing UI and confirm the Filerobot asset picker is
available and can list assets from your account.
