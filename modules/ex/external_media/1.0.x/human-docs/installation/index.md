# Installation

## Requirements

- **Drupal 10.6, 11.3, or 12** (`core_version_requirement: ^10.6 || ^11.3 || ^12`)
  — this is a recent, forward-looking release, so an up-to-date site is required.
- Core's **File** (`file`) module, enabled automatically as a dependency.
- For each cloud provider you plan to use, that provider's own SDK/library must be
  available so its plugin class can load. A provider whose class is missing simply
  does not appear — no picker option and no permission for it. Install only the
  ones you need.

## Install with Composer

From the project root:

```bash
composer require drupal/external_media -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/external_media -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en external_media -y
```

## Verify it worked

Log in as an administrator and visit **Configuration → Media → External Media**
(`/admin/config/media/external-media`). The settings form should load with a
section for each provider whose supporting code is present. If a provider you
expected is absent, its SDK is probably not installed yet. Next, see
[Configuration](../configuration/index.md) to enter the provider credentials and
grant permissions.
