# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4||^11`).
- The **ECA** module (`eca`) — the base Event‑Condition‑Action engine.
- The **Views Data Export** module (`views_data_export`), which provides the
  export functionality this module drives. Install it if it isn't already present.

Drupal will enable the ECA dependency automatically. There are no third‑party PHP
library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/eca_views_data_export -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/eca_views_data_export -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eca_views_data_export -y
```

This also enables `eca` if it is not already on. Make sure Views Data Export is
installed too.

## Verify it worked

Open the ECA model editor (**Configuration → Workflow → ECA**), create or edit a
model, and confirm this module's export‑related plugin(s) appear among the
available options. If they do, the integration is active.
