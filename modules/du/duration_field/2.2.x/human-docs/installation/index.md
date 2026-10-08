# Installation

## Requirements

Duration Field is self-contained. It needs:

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- Core's Field system (part of standard Drupal). There are no other module
  dependencies.
- No third-party Composer packages, PHP extensions, or JavaScript libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/duration_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/duration_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en duration_field -y
```

Enabling it makes the **Duration** field type, its widget, and its three
formatters available. There is no settings page and no configuration step — the
field is ready to add to any bundle immediately.

## Verify it worked

Go to any content type's **Manage fields** screen (for example **Structure →
Content types → Article → Manage fields → Add field**) and confirm that
**Duration** appears in the list of field types you can add. From there you set
the field's granularity and pick a widget and formatter — see the
[how-to-use section on the overview page](../index.md#how-to-use-it).

## Before uninstalling

Duration Field provides a Drush command to remove its fields cleanly before you
uninstall the module:

```bash
drush duration_field:prepare_uninstall
```
