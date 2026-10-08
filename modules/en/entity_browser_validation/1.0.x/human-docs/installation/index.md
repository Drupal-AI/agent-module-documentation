# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Entity Browser** module (`entity_browser`) enabled — this is the only
  dependency, and it is what provides the widget this module enhances.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_browser_validation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If Entity Browser is not already present, Composer will
pull it in.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_browser_validation -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_browser_validation -y
```

That's the entire setup. There is no configuration form and no permission to grant.

## Verify it worked

Open a content form that uses an Entity Browser entity-reference widget for a
required field, leave that field empty, and try to save. The form should refuse to
save and the Entity Browser widget should now be highlighted in red, matching how
core flags other failed fields.
