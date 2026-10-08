# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The contributed **Paragraphs** module (`paragraphs:paragraphs`).
- Core's **Node** module (`node`).
- The **drupalorg** module (`drupalorg:drupalorg`).
- The surrounding **www.drupal.org site configuration** — this module assumes
  certain content types, fields, and views already exist and does not create a
  general environment on its own.

There are no third‑party Composer or PHP library requirements of the module
itself.

## Install with Composer

From the project root:

```bash
composer require drupal/contribution_records -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Paragraphs and any
shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/contribution_records -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en contribution_records -y
```

## Verify it worked

Because the module depends on drupal.org‑specific site configuration, the best
check is that it enables cleanly alongside Paragraphs, Node, and drupalorg, and
that the **administer contribution records** permission appears at
**People → Permissions**. Grant that permission and confirm you can manage
contribution records within the expected content structures.
