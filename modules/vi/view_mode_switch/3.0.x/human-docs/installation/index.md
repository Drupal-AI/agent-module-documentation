# Installation

## Requirements

- **Drupal 11.3 or newer** (`core_version_requirement: ^11.3`).
- Core's **Field** module (`field`) — enabled by default in a standard Drupal
  install, and pulled in as a dependency.

There are no third-party Composer or PHP library requirements.

Optional integrations, each enabled only if you already use that module:

- **Diff** (`drupal/diff`) — shows view-mode-switch field changes in revision
  comparisons.
- **Paragraphs** (`drupal/paragraphs`) — lets a paragraph switch its own view
  mode.

## Install with Composer

From the project root:

```bash
composer require drupal/view_mode_switch -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/view_mode_switch -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en view_mode_switch -y
```

There are no submodules. Once enabled, the **View Mode Switch** field type is
available to add to any bundle — see the
[main guide](../index.md#how-to-use-it) for how to add and configure the field.

## Verify it worked

Go to a content type's *Manage fields* screen and click **Add field**; the **View
Mode Switch** field type should appear in the list.
