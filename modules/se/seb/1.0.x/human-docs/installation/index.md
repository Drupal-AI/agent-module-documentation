# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **Block** system (always present) — the module works entirely through
  Block Layout.

There are no module dependencies, no submodules, and no third-party PHP or
library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/seb -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/seb -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en seb -y
```

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and click **Place
block** in any region. In the block picker you should now see **Scheduled Entity
block** options — one per content entity type. Placing one and setting a schedule
is covered in the [main guide](../index.md).

> **Note on release coverage:** this module is not covered by Drupal's security
> advisory policy. That does not mean it is insecure — visibility is delegated to
> each target entity's own view access — but it is worth knowing when deciding
> whether to run it on a high-stakes site.
