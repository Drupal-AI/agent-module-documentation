# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The base **DCAT** module (`dcat`) — this is a required dependency and provides the
  entities that DCAT-AP adds fields to. Composer pulls it in (with its own
  dependencies) via the command below.

There are no third‑party PHP or library requirements beyond what DCAT itself needs.

## Install with Composer

From the project root:

```bash
composer require drupal/dcat_ap -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the DCAT dependency
(and everything DCAT requires) and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dcat_ap -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dcat_ap -y
```

Enable DCAT first (or let Drupal enable it as a dependency). On install, DCAT-AP
synchronises its new and altered field definitions into the database, so the
profile's fields become available immediately on the DCAT entity forms.

## Verify it worked

Create or edit a **Dataset** in the DCAT area. You should see the DCAT-AP fields
(version information, source, provenance, sample distribution, and so on), and the
**description** and **publisher** fields should now be marked **required**.
