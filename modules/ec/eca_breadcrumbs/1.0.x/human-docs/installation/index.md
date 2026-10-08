# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **ECA — Event‑Condition‑Action** (`eca`) — provides the visual model builder this
  module plugs into.
- **Token** (`token`) — provides the tokens you use in breadcrumb titles and URLs.
- Core **System**, which is always present.

Composer resolves these automatically when you install with the `-W` flag below.
There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/eca_breadcrumbs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/eca_breadcrumbs -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eca_breadcrumbs -y
```

No additional configuration is required after enabling — the module registers its
breadcrumb builder service and makes the ECA event and actions available automatically.

## Verify it worked

Go to **Administration → ECA → Models** (`/admin/eca`), add a model, and add an event
— you should see **Breadcrumb: Build breadcrumb** in the list, and **Breadcrumb: add
item** / **Breadcrumb: set items** among the available actions. That confirms the
integration is in place; build a model as described in the guide to customize your
breadcrumbs.
