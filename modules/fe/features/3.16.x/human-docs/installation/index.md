# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Configuration** module (`config`) — enabled on most sites already.
- The **Config Update** module (`drupal/config_update` `^2`) — a hard
  dependency, used by Features to diff and revert configuration. Composer pulls
  it in for you.
- **Drush**, since the export/import/diff cycle is driven from the command line.

## Install with Composer

From the project root:

```bash
composer require drupal/features -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Config Update and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/features -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en features -y
```

If you want the browser‑based management screens, enable the Features UI
submodule as well (see below).

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Features UI** | `features_ui` | The admin screens at `/admin/config/development/features` for reviewing, editing, and exporting feature packages in the browser. The base module works from Drush alone; enable this only if you want a UI. |

```bash
drush en features_ui -y
```

The submodule requires the base Features module, which is already present once
you've installed it above.
