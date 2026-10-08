# Installation

## Requirements

- **Drupal 11.1 or newer** (`core_version_requirement: ^11.1 || ^12`). This is a
  tight requirement — Template Whisperer 4.1.x will **not** install on Drupal 10
  or on Drupal 11.0. Use the 4.0.x branch for Drupal 10.
- Core's **Field** (`field`) and **Views** (`views`) modules, which Drupal
  enables automatically as dependencies.
- **PHP 8.0+** recommended (the project notes PHP 7.0 as the historical minimum,
  but a modern PHP is advised).

There are no third‑party Composer or external library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/template_whisperer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. The Composer package name (`drupal/template_whisperer`)
matches the module's machine name (`template_whisperer`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/template_whisperer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en template_whisperer -y
```

## Verify it worked

Log in as an administrator and go to **Structure → Template Whisperer**
(`/admin/structure/template-whisperer`). You should see the suggestion management
page with an **Add Template Whisperer** button. From here, follow the workflow in
the [main guide](../index.md) to create a suggestion and attach the field to a
content type.
