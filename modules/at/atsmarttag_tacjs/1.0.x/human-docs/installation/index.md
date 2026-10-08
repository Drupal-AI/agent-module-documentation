# Installation

## Requirements

AT Internet SmartTag for TacJS needs:

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- The **TacJS** module (`tacjs`) — the tag‑and‑consent manager.
- The **AT Internet SmartTag** module (`atsmarttag`) — provides the tracker itself.

Composer resolves both dependencies for you.

## Install with Composer

From the project root:

```bash
composer require drupal/atsmarttag_tacjs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in TacJS and AT
Internet SmartTag.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/atsmarttag_tacjs -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en atsmarttag_tacjs -y
```

TacJS and AT Internet SmartTag are enabled automatically as dependencies. There is
no configuration for this module itself — configure the tracker in **AT Internet
SmartTag** and the consent banner in **TacJS**. See the
[overview guide](../index.md#how-to-use-it).
