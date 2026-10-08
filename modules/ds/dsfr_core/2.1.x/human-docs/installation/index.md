# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Companion modules, which Composer pulls in as dependencies:
  - **DSFR Twig Components** (`dsfr_twig_components`) — the Twig components that
    render DSFR markup.
  - **Form Options Attributes** (`form_options_attributes`).
  - **Style Selector** (`style_selector`).
- Recommended: the base **DSFR theme**, which the suite is built to work with.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/dsfr_core -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the companion
modules and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/dsfr_core -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dsfr_core -y
```

Drupal enables the required companion modules (DSFR Twig Components, Form Options
Attributes, Style Selector) alongside it.

## Verify it worked

Confirm the module and its companions appear as enabled on the **Extend** page
(`/admin/modules`). With DSFR Core in place, you can add the feature‑level DSFR
modules such as **DSFR Menus** that depend on it.
