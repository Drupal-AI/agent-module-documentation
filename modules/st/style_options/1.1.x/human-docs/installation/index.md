# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- For the **Layout Builder** integration, core's Layout Builder module.
- For the **Paragraphs** integration, the **Paragraphs** module (`paragraphs`). This is a
  *soft* dependency — it isn't declared in the module's info file, so install it yourself if
  you want the paragraph behavior: `composer require drupal/paragraphs -W`.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/style_options -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/style_options -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en style_options -y
```

There are no submodules and no settings page. To start using it, add a
`[your_theme].style_options.yml` file to declare your controls, then wire them into Layout
Builder and/or Paragraphs — see [How to use it](../index.md#how-to-use-it) on the overview
page.
