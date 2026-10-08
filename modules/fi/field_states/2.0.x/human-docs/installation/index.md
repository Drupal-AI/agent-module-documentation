# Installation

## Requirements

- **Drupal 11 or 12** (`core_version_requirement: ^11 || ^12`) — this release is
  Drupal 11+ only.
- Core's **Views** (`views`) and **Options** (`options`) modules, which Drupal
  enables automatically as dependencies.

The state‑machine visualization uses the mermaid.js library, which ships with the
module. There are no other third‑party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_states -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_states -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_states -y
```

## Verify it worked

Add or edit an options field on a content type. Its **field settings** should now
include a place to define state transitions, and you should be able to reach the
per‑field state‑machine screen at `/field-states/state-machine/{field}`. See "How
to use it" in the [overview](../index.md) for the full workflow.
