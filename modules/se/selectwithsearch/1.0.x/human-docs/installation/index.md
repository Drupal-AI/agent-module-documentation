# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- No other modules are required, and there are no third‑party Composer or PHP
  library dependencies — the Select2 JavaScript/CSS the widget uses is bundled
  inside the module.

## Install with Composer

From the project root:

```bash
composer require drupal/selectwithsearch -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/selectwithsearch -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en selectwithsearch -y
```

## Verify it worked

Go to **Structure → Content types → [a content type] → Manage form display**,
pick a field that renders as a select list, and open its **Widget** drop‑down —
you should see **Select With Search** as a choice. Select it, save, then open a
content edit form for that type: the field should now be a searchable drop‑down
you can filter by typing.
