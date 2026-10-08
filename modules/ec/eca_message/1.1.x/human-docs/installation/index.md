# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- The **ECA** module (`eca`) — the base Event‑Condition‑Action engine.
- The **Message** module (`message`), which provides the Message entity this
  module creates.

Drupal will enable the ECA dependency automatically. Install Message yourself if
it isn't already present. There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/eca_message -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. This will also pull in the Message module if it isn't
already required.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/eca_message -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eca_message -y
```

This also enables `eca` and `message` if they are not already on.

## Verify it worked

Open the ECA model editor (**Configuration → Workflow → ECA**), create or edit a
model, and confirm the Message‑creation action appears in the list of available
actions. If it does, the integration is active.
