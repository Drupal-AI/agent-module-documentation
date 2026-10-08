# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Field** module (`field`), which is part of the standard install and is enabled
  automatically as a dependency.

There are no third‑party Composer libraries or special PHP requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/computed_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your host
> machine — `ddev composer require drupal/computed_field -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en computed_field -y
```

On its own, the base module gives you the plugin system and the bundled
`reverse_entity_reference` plugin. Any computed field plugin that attaches itself
automatically (written in code) will start appearing on its target bundles immediately.

## Optional submodule — Computed Field UI

If you want site builders to add computed fields by clicking rather than in code, enable the
bundled **Computed Field UI** submodule. It adds an **Add computed field** action to the
Field UI:

```bash
drush en computed_field_ui -y
```

This submodule requires the base Computed Field module, which is already present once you
have installed it above. It also relies on core's **Field UI** module being enabled (it
ships with standard Drupal).

## After enabling

Grant the **Administer computed_field entities** permission at **People → Permissions**
(`/admin/people/permissions`) to any non‑admin role that should be allowed to create or edit
computed fields. Then head to a bundle's **Manage fields** screen to add one — see
[How to use it](../index.md#how-to-use-it).
