# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No module dependencies are declared, and there are no third‑party Composer or PHP
  library requirements.
- **A working breadcrumb source.** For the injected breadcrumb to contain a proper
  trail, the module expects you to use either the **Easy Breadcrumb**
  (`easy_breadcrumb`) module, or the core breadcrumb patch referenced in the
  module's documentation (drupal.org issue 2884217) if you rely on core breadcrumbs.
  Set this up before or alongside installing this module.

## Install with Composer

From the project root:

```bash
composer require drupal/template_breadcrumb -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/template_breadcrumb -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

If you also want Easy Breadcrumb:

```bash
composer require drupal/easy_breadcrumb -W
```

## Enable the module

```bash
drush en template_breadcrumb -y
```

Enabling the module makes the breadcrumb available to place on a view mode, but does
not change any display yet. Continue with [Configuration](../configuration/index.md).

## Verify it worked

After configuring a view mode to show the breadcrumb (next page) and adding
`{{ content.template_breadcrumb }}` to the matching template, view a piece of content
— the breadcrumb trail should render at the position you placed it in the template.
