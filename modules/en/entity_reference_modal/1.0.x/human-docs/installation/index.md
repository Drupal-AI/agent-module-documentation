# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Field** module (`field`), part of a standard Drupal install and enabled
  automatically as a dependency.

There are no third‑party Composer or PHP library requirements. Note that the modal
is styled for a **Bootstrap 5** theme; if your admin theme is not Bootstrap 5 you
can enable the widget's "Load Bootstrap" option (loads Bootstrap 5 from a CDN) or
provide your own CSS.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_modal -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_reference_modal -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_modal -y
```

## Verify it worked

Go to **Structure → Content types → *(any type with a reference field)* → Manage
form display**. Open the **Widget** dropdown for that field — you should now see
**Autocomplete (add new with Modal)** as an option. Selecting it, configuring its
settings, and saving confirms the module is working.
