# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Field** module (`field`), which Drupal ships and enables by default — it
  is the only dependency, used for the entity‑reference fields that tie members to
  groups.

There are no third‑party Composer packages or PHP libraries to install. Be aware
this is an early **beta** release and is **not covered** by Drupal's security
advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_group -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_group -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_group -y
```

## Verify it worked

After enabling, look for the **Simple Groups** button in the admin toolbar. Click it
to begin creating group types and groups. If you have the right permissions and the
button is present, the module is installed correctly.
