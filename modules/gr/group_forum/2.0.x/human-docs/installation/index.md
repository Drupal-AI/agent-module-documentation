# Installation

## Requirements

Group Forum needs both core Forum and the Group module:

- **Drupal 9.5 or 10** (`core_version_requirement: ^9.5 || ^10`).
- Core's **Forum** module (`forum`).
- The **Group** module (`group`).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/group_forum -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/group_forum -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en group_forum -y
```

Enabling Group Forum pulls in core **Forum** and the **Group** module as
dependencies if they are not already on.

## Submodules

Group Forum ships no submodules.

## Verify it worked

Go to a group type's **Content** tab (**Groups → Group types → *(your group
type)* → Content**) and confirm the **Group forum** plugin is available to
install. Once installed and permissions are set, create a forum inside a group and
confirm that non-members cannot see it while members can — that difference is the
sign that access enforcement is working. See the main
[guide](../index.md) for the step-by-step setup.
