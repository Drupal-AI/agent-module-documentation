# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Options**, **Text**, **Field**, and **User** modules — all standard and
  enabled automatically as dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/og -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/og -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en og -y
```

## Submodule — og_ui (recommended)

Organic Groups is mostly an API. The **og_ui** submodule (`og_ui`) provides the
admin interface — the group settings form, the group‑level permissions and roles
screens, and the membership management pages. Unless you intend to configure
everything in code, enable it:

```bash
drush en og_ui -y
```

## After enabling

Enabling OG does not turn any of your existing content types into groups by itself.
You need to mark a bundle as a group and set up group content — see
[Configuration](../configuration/index.md).
