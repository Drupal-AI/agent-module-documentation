# Installation

## Requirements

Workflow Modeler targets a modern stack:

- **Drupal 11.3 or 12** (`core_version_requirement: ^11.3 || ^12.0`).
- **PHP 8.3 or newer** (`php: >=8.3`).
- The **Modeler API** module (`drupal/modeler_api` `^1.1`), which Composer pulls in
  automatically.
- At least one **model owner** module that registers with Modeler API to give you
  something to edit — most commonly **ECA** (`drupal/eca`) and its UI submodule.

There are no additional third‑party PHP libraries. The React editor ships
pre‑built in the module's `dist/` directory, so you do **not** need Node.js or a
build step for normal use (that's only needed if you want to rebuild the optional
standalone viewer).

## Install with Composer

From the project root:

```bash
composer require drupal/modeler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — here it also brings in `drupal/modeler_api`.

If you don't already have a model owner, add one too, for example ECA:

```bash
composer require drupal/eca -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/modeler -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en modeler -y
```

Drupal enables the required **Modeler API** module at the same time. Then enable
your model owner and its UI, for example:

```bash
drush en eca eca_ui -y
```

There is no configuration form to visit. Open the model owner's admin UI (for ECA,
**Configuration → Workflow → ECA**) and add or edit a model to start using the
visual canvas — see the [overview](../index.md#how-to-use-it). Remember to grant
the Modeler API capabilities on the model owner's permission set.
