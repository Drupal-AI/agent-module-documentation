# Installation

## Requirements

Group LLMs.txt bridges two modules, so both must be present:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- The **Group** module (`group`).
- The **LLMs.txt** module (`llms_txt`) — the module whose `llms_txt_section`
  entities this integrates into groups.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/group_llms_txt -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/group_llms_txt -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en group_llms_txt -y
```

Both Group and LLMs.txt are enabled as dependencies if they are not already on.

## Submodules

Group LLMs.txt ships no submodules.

## Verify it worked

On a group type's **Content** tab, confirm the llms.txt section group content
plugin is available to install. Once installed, open a group and confirm you can
add and manage its own llms.txt sections as group content.
