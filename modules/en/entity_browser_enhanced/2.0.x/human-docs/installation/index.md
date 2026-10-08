# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Entity Browser** module (`drupal/entity_browser`, `~2.0`) — this module
  enhances it, so it must be installed and enabled. Composer pulls it in
  automatically.

There are no other third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_browser_enhanced -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the Entity Browser dependency.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_browser_enhanced -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_browser_enhanced -y
```

This also enables the Entity Browser dependency if it is not already on. There is
no configuration form and no permission to grant — the module adds a **Select
enhancer** dropdown to Entity Browser's widget configuration form as soon as it
is enabled.

## Verify it worked

You need at least one entity browser with a **View** widget to see the feature.
Go to **Configuration → Content authoring → Entity browsers**
(`/admin/config/content/entity_browser`), edit a browser and open its **Widgets**
step. Each View widget row should now show a **Select enhancer** dropdown. See
the [overview](../index.md#how-to-use-it) for how to assign an enhancer.
