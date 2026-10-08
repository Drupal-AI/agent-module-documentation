# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Configuration Split 2.x** (`config_split`) enabled — this module extends it and
  cannot work without it.

There are no third‑party PHP library requirements. Optionally, the **Chosen** or
**Select2 All** modules improve the multiselect widgets on Config Split's edit form
(these are supported by Configuration Split itself). This is the 1.0.1 release.

## Install with Composer

From the project root:

```bash
composer require drupal/config_split_selective_patch -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Configuration Split
if it is not already present and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_split_selective_patch -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Configuration Split must already be enabled first. Then:

```bash
drush en config_split_selective_patch -y
```

## Verify it worked

Go to **Configuration → Development → Configuration Split**
(`/admin/config/development/configuration/config-split`) and edit a split. Under
**Advanced**, enable **Do not patch dependents** — the new **Partial Split (Patch)**
fieldset should appear. If it does, the module is active.
