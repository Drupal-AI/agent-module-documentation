# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4 || ^11`).
- No module dependencies beyond Drupal core, and no third-party Composer or PHP
  libraries declared.
- A reachable **Supervisor** process-control instance whose connection details and
  credentials you can supply.

## Install with Composer

From the project root:

```bash
composer require drupal/supervisor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/supervisor -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en supervisor -y
```

## After enabling

Supervisor needs the connection details and credentials for your Supervisor
instance before it can control anything. Configure those as an administrator, and
keep the credentials in an environment variable rather than hard-coding or
committing them. Then grant the module's permission to the operators who should be
able to manage the background workers.

> **Note:** This release is a release candidate (2.0.0-rc4). Review it before
> relying on it in production.
