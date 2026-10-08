# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No modules are strictly required, but the module is **most useful alongside the
  Workflows / Content Moderation** system, since that's where richer moderation
  states come from. It also supports core's basic Published/Unpublished states on
  its own.

There are no third‑party Composer or PHP library requirements. Note this module
has *not-covered* security advisory coverage.

## Install with Composer

From the project root:

```bash
composer require drupal/published_state_indicator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/published_state_indicator -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en published_state_indicator -y
```

## Verify it worked

Go to the **Manage display** page for a bundle that has an entity reference (list)
field (**Structure → *(entity type)* → *(bundle)* → Manage display**). The field's
**Format** dropdown should now include **Label & Published state**. You can also
visit **Configuration → User interface → Published State Indicator** to confirm
the styling settings page is available. See the
[overview](../index.md) for how to apply and style the labels.
