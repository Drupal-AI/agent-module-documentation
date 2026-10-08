# Installation

## Requirements

Add Content by Bundle is a lightweight Views add‑on. It needs:

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- Core's **Views** module (`views`) enabled — this is the only dependency, and
  Drupal enables it automatically if it is not already on.

There are no third‑party Composer or PHP library requirements. The Group and Form
Mode Control modules are optional integrations that unlock extra options in the
area handler if you happen to have them installed — neither is required.

## Install with Composer

From the project root:

```bash
composer require drupal/add_content_by_bundle -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/add_content_by_bundle -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en add_content_by_bundle -y
```

That is all it takes. There is no configuration form to visit — the module simply
makes a new **Add Content by Bundle link** area available inside the Views UI. Edit
any view, add it to the header or footer, and configure it there. See the
[overview](../index.md#how-to-use-it) for the step‑by‑step.
