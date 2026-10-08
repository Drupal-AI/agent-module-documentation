# Installation

## Requirements

- **Drupal 8, 9, 10 or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other modules, PHP libraries or JavaScript libraries are required — the editor
  uses only core's `core/drupal` and `core/once`.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_wysiwyg -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_wysiwyg -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_wysiwyg -y
```

## Verify it worked

There is no settings page to visit — instead, go to a bundle's **Manage form
display** (for example **Structure → Content types → Article → Manage form
display**), and confirm that **Simple WYSIWYG** now appears as a widget option for
your string/text fields. Applying it there is what activates the editor.

