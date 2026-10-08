# Installation

## Requirements

- **Drupal 10.3 or newer, or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Configuration Manager** (`config`) module — enabled automatically as a dependency.
- An **installation profile** in your codebase to export into — Config Profile is only useful
  when you are maintaining a profile or distribution.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/config_profile -W
```

The module's own documentation also suggests pinning the 2.x line explicitly, e.g.
`composer require drupal/config_profile:^2.0`. The `-W`
(`--with-all-dependencies`) flag lets Composer update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_profile -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_profile -y
```

Because export will start writing into your profile once this is configured, enable it only
on the environment where you actually maintain the profile — not on ordinary production sites.

## Verify it worked

Go to **Administration → Configuration → Development → Synchronize** and confirm a
**Profile** tab is now present. If it is, the module is installed — continue to
[Configuration](../configuration/index.md) to pick the target profile before you run your
next export.
