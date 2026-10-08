# Installation

## Requirements

- **Drupal 10** (`core_version_requirement: ^10`).
- Core's **Link** module (`link`) — Drupal enables it automatically as a
  dependency.
- Optional but recommended for advanced use: the
  [Twig Tweak](https://www.drupal.org/project/twig_tweak) module, which lets your
  snippets render blocks and views (handy for mega menus).

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_twig -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/menu_twig -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_twig -y
```

There is no configuration step. The **Menu Twig** section appears automatically on
the menu link edit form.

> **Before you hand this to editors:** because Menu Twig executes the snippet as a
> server‑side Twig template, review who holds the **Administer menus and menu
> links** permission. Keep it restricted to trusted administrators — see the
> security note on the [overview page](../index.md).

## Verify it worked

Go to **Structure → Menus**, edit a menu link, and confirm a **Menu Twig** section
with a WYSIWYG text field and an override option now appears on the form. Enter a
small snippet, save, and check that it renders where the link appears.
