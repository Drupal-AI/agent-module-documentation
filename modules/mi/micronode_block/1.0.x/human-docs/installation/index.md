# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **Micronode** module (`micronode`) — required.
- **Entity Browser** (`entity_browser`) — required; the plug-and-play authoring UX
  leans on it (together with **Inline Entity Form**).
- Core **Views** (`views`) — required.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/micronode_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update and install the
dependencies (Micronode, Entity Browser, and the Inline Entity Form it relies on) as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/micronode_block -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en micronode_block -y
```

This enables Micronode, Entity Browser, and Views as dependencies if they are not
already on. Make sure **Inline Entity Form** is also present, as the authoring
experience depends on it.

## Verify it worked

In **Layout Builder** (or **Structure → Block layout**), add a block and confirm the
**Components** category lists a block for each micronode type. Place one, create or
select a micronode, and confirm it renders. See the [overview](../index.md) for the
full authoring flow.
