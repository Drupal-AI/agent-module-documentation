# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11`; the released
  1.0.x builds run through Drupal 12).
- No module dependencies and no Composer/PHP library requirements. It builds on
  core's Field API, which is always available.

## Install with Composer

From the project root:

```bash
composer require drupal/css_size_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/css_size_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en css_size_field -y
```

## Verify it worked

Go to **Structure → Content types → *(type)* → Manage fields**, click **Add
field**, and confirm that **CSS Size** appears in the list of available field
types. Adding one, then editing a piece of content, should show a number input
with a unit selector. See the [main guide](../index.md#how-to-use-it) for the full
walkthrough.
