# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- The **ECA** module (`eca`) — the base Event‑Condition‑Action engine.
- The **ECA Endpoint** submodule/module (`eca_endpoint`).
- The **Maestro** workflow module, which you interact with through this bridge.

Drupal will enable the ECA dependencies automatically. Install Maestro yourself
if it isn't already present. There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/eca_maestro -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/eca_maestro -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eca_maestro -y
```

This also enables `eca` and `eca_endpoint` if they are not already on. Make sure
Maestro is installed too.

## Verify it worked

Open the ECA model editor (**Configuration → Workflow → ECA**), create or edit a
model, and confirm the Maestro‑related actions and conditions appear in the list
of available plugins. If they do, the integration is active.
