# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).

There are no module dependencies and no third-party PHP libraries. To actually see
components, you also need a **custom theme** you can add a `theme-settings.php` (or
`.theme`) hook to — the module previews whatever you register there.

## Install with Composer

From the project root:

```bash
composer require drupal/style_guide -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/style_guide -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en style_guide -y
```

## Wire it into your theme

The module renders whatever components you register from your theme. In your
theme's `theme-settings.php` (or `yourtheme.theme`), implement
`hook_form_style_guide_theme_settings_alter()` and add your components inside it —
for example a color palette, typography samples, or Form API examples. Recent
releases include a `theme-settings.php` starting point for Bootstrap 5, and the
maintainer offers a companion Bootstrap SASS starter kit to get going faster.

## Verify it worked

Go to **Appearance → Style guide** (`/admin/appearance/style-guide`) and select
your front-end theme. The components you registered in your theme's alter hook
should render there, styled by that theme.
