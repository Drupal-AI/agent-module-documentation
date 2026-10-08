# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Options** module (`options`) — the only dependency, enabled automatically
  as a dependency. The module reuses the Options widgets and formatters, so there is
  no custom widget to install.

There are no third‑party Composer or PHP library requirements. Entity Reference
Revisions is optional: if it is present, the formatter automatically supports
revision‑aware references (such as Paragraphs).

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_display -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_reference_display -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_display -y
```

The module has no settings page and ships no submodules. Once enabled, the
**Display mode** field type and the **Selected display mode** formatter are available
on your bundles — see [How to use it](../index.md#how-to-use-it) on the overview page.
