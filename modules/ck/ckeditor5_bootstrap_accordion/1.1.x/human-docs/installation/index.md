# Installation

## Requirements

- **Drupal 10.6+ or 11.3+** (`core_version_requirement: ^10.6 || ^11.3`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled — this is the only
  dependency, and Drupal enables it automatically as a dependency.
- A front‑end **theme that loads Bootstrap 5 CSS and JavaScript**. This isn't a
  Composer dependency — it's a runtime requirement for the accordions to display
  and animate on the page. The module adds no front‑end assets of its own.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_bootstrap_accordion -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor5_bootstrap_accordion -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_bootstrap_accordion -y
```

Enabling the module doesn't add the accordion button anywhere yet. You need to add
the **Accordion** button *and* enable the **Accordion enabler** filter on each
text format you want to use it in — see [the main
page](../index.md#how-to-set-it-up) for the walkthrough.
