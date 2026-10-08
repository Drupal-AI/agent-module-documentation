# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`) — this module addresses a change
  introduced in Drupal 11.2.
- Core's **Field** module (`field`), which ships with Drupal core and is normally
  already enabled.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/reenable_number_float -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/reenable_number_float -W`, `ddev
> drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en reenable_number_float -y
```

The **Number (float)** and **List (float)** field types become available
immediately — no configuration required.

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage fields → Add field**.
**Number (float)** and **List (float)** should appear as choices again. If you
disable the module later, these types vanish from the chooser, but any float
fields you already created remain untouched.
