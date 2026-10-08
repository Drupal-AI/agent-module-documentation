# Installation

## Requirements

- **Drupal 9.2+, 10.1+, or 11** (`core_version_requirement: ^9.2 || ^10.1 || ^11`).
- **PHP 7.4 or newer** (`php: >=7.4`).
- Core's **Options** module (`options`) — the one dependency, which Drupal
  enables automatically when you turn on State Machine.

**Optional:** if you have the [Diff](https://www.drupal.org/project/diff) module
installed, State Machine adds a diff field builder so state changes show up when
comparing entity revisions. This is only a dev suggestion, not a requirement.

There are no third‑party Composer libraries required.

## Install with Composer

From the project root:

```bash
composer require drupal/state_machine -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/state_machine -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en state_machine -y
```

Drupal enables core's **Options** module automatically as a dependency. There is
no settings form to fill in — from here the work is defining workflows in code
(see the [`agent/`](../agent/start.md) docs).

## Submodules

State Machine ships no submodules.
