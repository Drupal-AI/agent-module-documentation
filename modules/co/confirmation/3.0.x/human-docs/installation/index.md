# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other modules, PHP extensions, or third‑party libraries are required — it
  depends only on core.

Remember this is a **developer framework**: enabling it gives you the confirmation
entity type and API, but no user‑facing feature until an integrating module (or
your own code) defines a confirmation bundle and its behaviour.

## Install with Composer

From the project root:

```bash
composer require drupal/confirmation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/confirmation -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en confirmation -y
```

To see the pattern in action, also enable the bundled example submodule:

```bash
drush en confirmation_example -y
```

## Verify it worked

After enabling, the confirmation entity type and its API are available to code. The
clearest way to confirm everything is wired up is to enable the
`confirmation_example` submodule and follow its flow, or run the module's tests.
There is no admin UI to visit.
