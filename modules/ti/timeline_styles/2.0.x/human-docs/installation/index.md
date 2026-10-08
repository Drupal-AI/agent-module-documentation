# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Views** module (`views`).
- Two contrib modules for the per-event colour field:
  - **Color Field** (`color_field`)
  - **Color Picker** (`color_picker`)

There are no PHP library requirements. Note that this release is **not** covered by
drupal.org's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/timeline_styles -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the required
**Color Field** and **Color Picker** packages as well. If you prefer to be
explicit, you can require all three together:

```bash
composer require drupal/timeline_styles drupal/color_field drupal/color_picker -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/timeline_styles -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en timeline_styles -y
```

Drupal will also enable the required `views`, `color_field`, and `color_picker`
modules as dependencies. Enabling Timeline Styles installs its starter content type,
tags vocabulary, image style, and demo view.

## Verify it worked

Edit or create a View and open the **Format** setting — you should see **Timeline
Styles** and **Timeline Styles With Image** as options. You should also find a new
**Timeline Styles** content type under **Structure → Content types** and a demo
`timeline_styles` view under **Structure → Views**.
