# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No contributed‑module dependencies and no third‑party libraries on Drupal 8+.

> **Note:** The Drupal 7 version of this module stored templates as YAML and needed
> the `php-pecl-yaml` PHP extension. That requirement does **not** apply to this
> Drupal 8+ release.

## Install with Composer

From the project root:

```bash
composer require drupal/node_form_templates -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_form_templates -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_form_templates -y
```

## Verify it worked

After enabling, grant the Node Form Templates permissions to the appropriate roles
at **People → Permissions**, create a template on the module's settings form, then
open a node **add** form: a template dropdown should appear at the top of the form.
Choosing your template should pre‑fill the fields. See "How to use it" on the
[overview page](../index.md) for the full workflow.
