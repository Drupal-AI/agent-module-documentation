# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No module dependencies and no Composer/PHP library requirements.
- **Recommended:** the **SDC Styleguide** module, if you want to preview
  Single Directory Component overrides while you work.

This is a **beta** release (1.0.0‑beta3), so test it before relying on it in
production.

## Install with Composer

From the project root:

```bash
composer require drupal/css_variables_customizer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/css_variables_customizer -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en css_variables_customizer -y
```

## One more step before it does anything

Enabling the module is not enough on its own — the module can only override
variables that your theme has **declared and annotated** for it. That one‑time
theme setup (declaring the source stylesheets in your theme's `.info.yml` and
wrapping the variables in annotation comments) is covered in
[Configuration](../configuration/index.md). Until you do it, the overview page will
list no variables to override.

## Verify it worked

After completing the theme setup in [Configuration](../configuration/index.md),
clear caches and open **Appearance → CSS Variables Customizer**
(`/admin/appearance/css-variables-customizer`). Your prepared theme should appear
in the list with its annotated variables available to override.
