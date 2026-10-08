# Installation

## Requirements

Static Generator needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Node** (`node`), **Content Moderation** (`content_moderation`),
  **Workflows** (`workflows`), and **Field UI** (`field_ui`) modules. Drupal
  enables these automatically as dependencies when you turn Static Generator on.
- On the deployment side, a working `rsync` (and shell access) on the Drupal
  server, since asset deployment shells out to `rsync`.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/static_generator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/static_generator -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en static_generator -y
```

## Verify it worked

After enabling, visit **Configuration → Static Generator**
(`/admin/config/static_generator`) as an administrator. You should see the
settings form. Nothing is generated until you configure the module and run a
generation command (for example `drush sg`) — see
[Configuration](../configuration/index.md).
