# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- No module dependencies — it is a pure config‑plus‑controller module.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/securitytxt -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/securitytxt -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en securitytxt -y
```

Security.txt ships no submodules. Enabling it does **not** yet serve a file — the file
stays hidden (returning 404) until you fill in the settings, tick **Enabled**, and grant
the **View securitytxt** permission. Continue to
[Configuration](../configuration/index.md) for those steps.
