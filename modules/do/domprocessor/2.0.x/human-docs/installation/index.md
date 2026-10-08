# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).

There are no module dependencies beyond core, and no third‑party Composer or PHP
library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/domprocessor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/domprocessor -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en domprocessor -y
```

## Verify it worked

Because this is a developer API with no UI, "working" simply means it is enabled
and available to dependent modules. Confirm it appears as enabled on the
**Extend** page (or via `drush pml --status=enabled | grep domprocessor`). Any
module that registers DOM processors against it can now do so.
