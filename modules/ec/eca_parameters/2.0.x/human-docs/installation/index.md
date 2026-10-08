# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **ECA** module (`eca`), version **2.x**.
- The **Parameters** module (`parameters`).

Drupal will enable the dependencies automatically. There are no third‑party PHP
library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/eca_parameters -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/eca_parameters -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eca_parameters -y
```

This also enables `eca` and `parameters` if they are not already on.

## Submodules

- **ECA Parameters UI** (`eca_parameters_ui`) — adds the user interface for
  working with parameters. Enable it when you want that interface:

  ```bash
  drush en eca_parameters_ui -y
  ```

## Verify it worked

Open the ECA model editor (**Configuration → Workflow → ECA**), create or edit a
model, and confirm the parameter‑related events, conditions and actions appear in
the list of available plugins. If they do, the integration is active.
