# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core **Views** (`views`) — a dependency, enabled automatically with the module;
  it powers the request/response debug‑log listing.
- An **Epsilon Harmony account** with API access, so you have the credentials to
  connect with.
- No third‑party Composer or PHP library requirements are declared.

## Install with Composer

From the project root:

```bash
composer require drupal/epsilon_harmony -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/epsilon_harmony -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en epsilon_harmony -y
```

## Verify it worked

After enabling, go to [Configuration](../configuration/index.md) and enter your
Epsilon Harmony API credentials. Then make a test call (for example creating a test
profile record from your integration code) and check the Views‑based
request/response log to confirm the request reached Epsilon and returned as
expected.
