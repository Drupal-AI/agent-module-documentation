# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Feeds** module (`feeds`).
- The **Feeds Tamper** module (`feeds_tamper`) — used, for example, to add an
  Entity Finder tamper that resolves a group ID from your source.
- The **Group** module (`group`).
- The **Group Action** module (`group_action`) — the layer that actually performs
  the group‑content write.

There are no third‑party PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/feeds_group_action -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Feeds, Feeds
Tamper, Group, Group Action and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/feeds_group_action -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en feeds_group_action -y
```

Drupal enables the Feeds, Feeds Tamper, Group and Group Action dependencies
automatically.

## Verify it worked

Open a feed type at **Structure → Feed types → *(feed type)* → Mapping**, add a
mapping, and confirm that **Group Membership** appears in the list of available
targets. If it does, the module is ready to configure.
