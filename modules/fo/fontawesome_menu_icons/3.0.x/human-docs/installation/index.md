# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Font Awesome** module (`fontawesome`) — this is what actually loads the
  Font Awesome icon font on your site; FontAwesome Menu Icons only adds the icon
  to the menu link markup.
- Core's **Menu UI** module (`menu_ui`), which provides the menu-link forms this
  module extends. Drupal enables it as a dependency automatically.

There are no additional PHP library requirements. An optional
`fontawesome-iconpicker` front-end library enhances the icon field with a visual
picker; the module works without it, falling back to a plain text field.

## Install with Composer

From the project root:

```bash
composer require drupal/fontawesome_menu_icons -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Font Awesome
module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fontawesome_menu_icons -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fontawesome_menu_icons -y
```

This also enables Font Awesome and Menu UI if they are not already on. Make sure
the Font Awesome module is configured to load the icon set (and the version —
4, 5, or 6) you plan to reference, so the classes you enter on your menu links
actually resolve to glyphs.

The module ships no submodules and no settings form. Once enabled, edit any menu
link under **Structure → Menus** to see the new *FontAwesome Icon* fieldset — see
[the index page](../index.md#how-to-use-it) for the walkthrough.
