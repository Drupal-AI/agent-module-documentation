# Installation

## Requirements

File Inspector needs:

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **Views** module (`views`), which Drupal enables automatically as a
  dependency.
- Core's **Media** module — optional, required only if you want to import
  unmanaged files into the Media library.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/file_inspector -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/file_inspector -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_inspector -y
```

If you plan to import unmanaged files into the Media library, make sure core's
Media module is also enabled:

```bash
drush en media -y
```

## Verify it worked

Visit **Reports → File Inspector** (`/admin/reports/file-inspector`). You should
see the report screen, ready to run a scan. Before running it in earnest, review
the scan settings and grant the permissions described in
[Configuration](../configuration/index.md).
