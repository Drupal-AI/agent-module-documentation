# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- A **default theme that declares color scheme options** in its `.info.yml` (see
  below) — this is a prerequisite, not an optional extra.

There are no other module or PHP library dependencies.

## Declare your schemes first

Before enabling the module, add a list of scheme options to your default theme's
`.info.yml`:

```yaml
color_scheme:
  scheme-one: Scheme one
  scheme-two: Scheme two
```

The keys (`scheme-one`, …) are the stored values; the labels are what editors see.

## Install with Composer

From the project root:

```bash
composer require drupal/color_scheme_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/color_scheme_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en color_scheme_field -y
```

## Verify it worked

On a content type's **Manage fields** screen, start adding a field — the **Color
Scheme** field type should appear. When you edit content with that field, the schemes
you declared in the theme's `.info.yml` should be offered as choices.
