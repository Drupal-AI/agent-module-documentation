# Installation

## Requirements

- **Drupal 10** (`core_version_requirement: ^10`).
- Core's **Basic page** (`page`) content type — the module works on this content
  type specifically. It has no other dependencies beyond core.

## Install with Composer

From the project root:

```bash
composer require drupal/page_links -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/page_links -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en page_links -y
```

There is no configuration step — the module adds its panel to the Basic page edit
form automatically.

## Verify it worked

1. Edit a **Basic page** whose body contains at least one hyperlink.
2. In the form's advanced sidebar, confirm a collapsible **Page links [N]** panel
   appears, listing the links with a Local/Remote label.

If the panel does not appear, check that the page you are editing is a **Basic
page** (`page`) and that its body actually contains links — the panel is hidden
when there are none.
