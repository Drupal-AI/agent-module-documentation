# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- Core's **Field UI** (`field_ui`) module.
- The contributed **Inline Entity Form** (`inline_entity_form`) module — required
  for the IEF "autocomplete create" enhancement. Install it alongside this module
  (the `-W` flag below lets Composer pull it in).

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_widgets -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update
dependencies such as Inline Entity Form.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_reference_widgets -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_widgets -y
```

Enable Field UI and Inline Entity Form too if they are not already on:

```bash
drush en field_ui inline_entity_form -y
```

## Verify it worked

There is no admin page to check. Instead, edit a taxonomy term reference field's
settings — the **Taxonomy Term selection – Hierarchical** reference method should
appear as a choice. On an IEF‑complex reference field's **Manage form display**
widget settings, you should see the **Enable Autocomplete Create Option**
checkbox. See the "How to use it" section of the [overview](../index.md) for the
full per‑field setup.
