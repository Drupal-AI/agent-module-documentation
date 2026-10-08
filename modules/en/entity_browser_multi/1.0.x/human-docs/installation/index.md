# Installation

## Requirements

- **Drupal 11.4** (`core_version_requirement: ^11.4`).
- **PHP 8.3 or newer**.
- Core's **Field** (`field`) module.
- The **Entity Browser** module, version **2** (`entity_browser:entity_browser`,
  `^2`) — Drupal enables it as a dependency, and you need at least one Entity Browser
  configured to attach as a launcher.

No other required contrib modules, libraries, or external APIs. Optionally, the
**Gin** admin theme provides spacing tokens for the widget's add-bar layout, and the
Entity Browser example / media browsers give you ready-made browsers to attach.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_browser_multi -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including pulling in the required Entity Browser module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_browser_multi -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

This enables Entity Browser Multi Widget along with the Entity Browser dependency:

```bash
drush en entity_browser_multi -y
```

## Verify it worked

Make sure at least one Entity Browser exists (**Structure → Entity browsers**), then
go to a content type's **Manage form display** (**Structure → Content types → (type)
→ Manage form display**). On an entity-reference field, the widget dropdown should now
offer **Entity browser (multi)**. Selecting it and opening the widget settings reveals
the **Entity browser launchers** table where you enable and order your browsers — see
the [overview](../index.md) for the full walkthrough.

> **Note:** this project is not (yet) covered by Drupal's security advisory policy, so
> use it with that in mind until it opts into the security team process.
