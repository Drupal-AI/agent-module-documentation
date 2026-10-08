# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4 || ^11`).
- The **ECA** module (`eca`), version **2.x or 3.x**.
- The **State Machine** module (`state_machine`).

Drupal will enable the dependencies automatically. There are no third‑party PHP
library requirements. Remember that State Machine needs at least one configured
workflow to provide any functionality — see the example submodule below if you
don't have one yet.

## Install with Composer

From the project root:

```bash
composer require drupal/eca_state_machine -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/eca_state_machine -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eca_state_machine -y
```

This also enables `eca` and `state_machine` if they are not already on.

## Submodules

- **ECA State Machine Example** (`eca_state_machine_example`) — adds a ready‑made
  State Machine workflow you can use to try the integration. Handy for testing;
  **not intended for production**. Enable it with:

  ```bash
  drush en eca_state_machine_example -y
  ```

## Verify it worked

Open the ECA model editor (**Configuration → Workflow → ECA**), create or edit a
model, and confirm the transition **events**, the state/transition
**conditions**, and the **trigger a transition** action appear among the
available plugins. If they do, the integration is active.
