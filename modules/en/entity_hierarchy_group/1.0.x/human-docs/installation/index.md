# Installation

## Requirements

- **Drupal 10.5+ or 11.2+** (`core_version_requirement: ^10.5 || ^11.2`).
- The **Entity Hierarchy** module (`entity_hierarchy`) — specifically the
  Entity Reference Hierarchy 5.x line — must be installed.
- The **Group** module (`group`) — version 3.x — must be installed.

Both dependencies are required; Drupal will refuse to enable this module until
they are present. There are no third‑party PHP or JavaScript library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_hierarchy_group -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in or update the
Entity Hierarchy and Group dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_hierarchy_group -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_hierarchy_group -y
```

Drush will enable `entity_hierarchy` and `group` too if they are not already on.

## Verify it worked

Edit one of your Entity Reference Hierarchy fields and open its field settings.
You should now see the new group‑related options (restrict parent selection to
the current group, restrict selection outside group context, and one similar
hierarchy per group). If those options appear, the bridge is active.
