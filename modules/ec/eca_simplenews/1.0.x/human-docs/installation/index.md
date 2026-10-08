# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4||^11`).
- The **ECA** module (`eca`) — the base Event‑Condition‑Action engine.
- The **Simplenews** module (`simplenews`), which provides the newsletters and
  subscription operations.

Drupal will enable the ECA dependency automatically. Install Simplenews yourself
if it isn't already present. There are no third‑party PHP library requirements.

> **Note:** this release is an early **alpha** and the project is seeking a new
> maintainer. Test it carefully before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/eca_simplenews -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/eca_simplenews -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eca_simplenews -y
```

This also enables `eca` and `simplenews` if they are not already on. Make sure
you have at least one Simplenews newsletter defined to subscribe users to.

## Verify it worked

Open the ECA model editor (**Configuration → Workflow → ECA**), create or edit a
model, and confirm the **Subscribe to newsletter** and **Unsubscribe from
newsletter** actions — and the three subscription conditions — appear among the
available plugins. If they do, the integration is active.
