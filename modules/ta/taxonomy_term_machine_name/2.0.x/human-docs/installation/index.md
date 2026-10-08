# Installation

## Requirements

- **Drupal 9.2 or 10** (`core_version_requirement: ^9.2 || ^10`).
- **PHP 8.0** or newer.
- Core's **Field** (`field`) and **Taxonomy** (`taxonomy`) modules — both ship
  with Drupal and are enabled automatically as dependencies.

There are no third‑party Composer or library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_term_machine_name -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/taxonomy_term_machine_name -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_term_machine_name -y
```

## Verify it worked

Go to **Structure → Taxonomy**, edit any vocabulary, and open its **Manage
fields** tab. When you add a field you should now see the machine‑name field type
available in the list.

## Removing the module later

Before you uninstall, remove the stored field data cleanly. Visit
`/admin/modules/uninstall/field/taxonomy_term_machine_name` (you need the
**Administer modules** permission) and follow the prompt to tear down the field
storage, then uninstall the module on the usual **Extend → Uninstall** page.
