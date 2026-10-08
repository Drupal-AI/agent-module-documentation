# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Configuration Manager** module (`config`) — the only dependency, enabled
  automatically.
- No third‑party Composer or PHP library requirements.

> **Development only.** Install this on local and development environments, not on
> production. Its auto-import feature overwrites active configuration from files on
> every request.

## Install with Composer

Because it is a development tool, require it as a dev dependency from the project
root:

```bash
composer require --dev drupal/config_devel -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require --dev drupal/config_devel -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_devel -y
```

## Verify it worked

Go to **Configuration → Development → Configuration development**
(`/admin/config/development/config_devel`); you should see a settings form with
**Auto import** and **Auto export** text areas. See
[Configuration](../configuration/index.md) to wire up your first file, or run
`drush config:devel-export --help` to confirm the Drush commands are available.
