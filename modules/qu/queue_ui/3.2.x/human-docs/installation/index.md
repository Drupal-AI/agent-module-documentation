# Installation

## Requirements

Queue UI is self‑contained. It needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11.0`).
- No other contrib modules — Queue UI declares no module dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/queue_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/queue_ui -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en queue_ui -y
```

Grant the **admin queue_ui** permission to any role that should manage queues.
There is no required configuration.

## Submodules

Queue UI ships **no submodules**. An optional, separately installed companion
module, **`queue_order`**, adds a drag‑and‑drop weight column to the overview if
you want to reorder queue processing.

## Verify it worked

Go to **Configuration → System → Queue manager**
(`/admin/config/system/queue-ui`). You should see a table listing every
registered queue worker with its item count.
