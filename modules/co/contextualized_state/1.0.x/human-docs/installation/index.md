# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- No module dependencies beyond core.

There are no third‑party Composer or PHP library requirements. Note this module's
security advisory coverage is *not covered*, so review it before using it on a
production site.

## Install with Composer

From the project root:

```bash
composer require drupal/contextualized_state -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/contextualized_state -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en contextualized_state -y
```

## Submodules

- **Contextualized State Examples** (`contextualized_state_examples`) — a worked
  example that ships a "Soccer" context and provider plus a dispatch example form.
  Enable it while learning, then disable it in production:

  ```bash
  drush en contextualized_state_examples -y
  ```

## Verify it worked

The main module has no visible UI, so the clearest check is to enable the examples
submodule and open its dispatch example form, then confirm the context value you
set is read back. For your own code, confirm the
`contextualized_state.context_manager.service` service is available in the
container.
