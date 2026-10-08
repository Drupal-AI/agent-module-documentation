# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

That is the whole list — the module has no module dependencies and no third‑party
Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/multivalue_form_element -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/multivalue_form_element -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en multivalue_form_element -y
```

There is nothing to configure. Once enabled, the `multivalue` render element is available
to any form — use it from your custom module's `buildForm()` as shown in the
[overview guide](../index.md#how-to-use-it).

## Verify it worked

Add a `#type => 'multivalue'` element to a custom form (or a quick test form) and load
that form: you should see the repeatable rows and, for unlimited cardinality, the **"Add
another item"** button. If the element type is not recognised, confirm the module is
enabled with `drush pm:list --status=enabled | grep multivalue_form_element`.
