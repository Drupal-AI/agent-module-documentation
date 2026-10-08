# Installation

## Requirements

Semantic Views is self-contained. It needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Views** module (`views`), which is part of standard Drupal and is
  enabled automatically as a dependency.
- No third-party Composer packages, PHP extensions, or JavaScript libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/semanticviews -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/semanticviews -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en semanticviews -y
```

Enabling it makes the **Semantic Views Style** and **Semantic Views Row** plugins
available in the Views UI. There is no settings page and no configuration step —
you select the plugins per view.

## Verify it worked

Edit any view at **Structure → Views**, open its **Format** section, and confirm
that **Semantic Views Style** appears in the list of formats you can choose. See
the [how-to-use section on the overview page](../index.md#how-to-use-it) for what
to do next.
