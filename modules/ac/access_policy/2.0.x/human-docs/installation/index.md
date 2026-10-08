# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- No third-party Composer or PHP library requirements.

The release is **2.0.0-rc1** (a release candidate) — test it before relying on it
in production.

## Install with Composer

From the project root:

```bash
composer require drupal/access_policy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/access_policy -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module together with its administrative interface:

```bash
drush en access_policy access_policy_ui -y
```

| Module | Machine name | What it provides |
|--------|--------------|------------------|
| **Access Policy** | `access_policy` | The access engine — rules, policies and enforcement. |
| **Access Policy UI** | `access_policy_ui` | The admin screens for building and managing policies. You will almost certainly want this. |

Once enabled, define your rules and policies and grant the permissions — see
[Configuration](../configuration/index.md).
