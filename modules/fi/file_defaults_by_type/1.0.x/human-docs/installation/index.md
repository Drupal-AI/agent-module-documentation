# Installation

## Requirements

File defaults by type needs:

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **File** module (`file`).
- The contributed **Multivalue Form Element** module
  (`multivalue_form_element`) — this provides the repeatable widget used to
  define the list of types, and Composer pulls it in for you.

## Install with Composer

From the project root:

```bash
composer require drupal/file_defaults_by_type -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the
Multivalue Form Element dependency and update any shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/file_defaults_by_type -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_defaults_by_type -y
```

Drupal enables the File and Multivalue Form Element dependencies at the same
time.

## Verify it worked

Edit any **File** field (**Structure → Content types → *(type)* → Manage
fields**). You should now be able to define named types with default files in the
field's settings, and the add-content form should offer those types in a
dropdown.
