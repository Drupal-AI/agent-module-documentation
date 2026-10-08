# Installation

## Requirements

Display Selected and Unselected is lightweight and has no third‑party
dependencies:

- **Drupal 8 or newer** (`core_version_requirement: >=8`).
- A fieldable entity with a **List (text)**, **List (float)** or **List
  (integer)** field to format. These field types are provided by core's *Options*
  module.

There are no Composer library or PHP extension requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/display_selected_and_unselected -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/display_selected_and_unselected -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en display_selected_and_unselected -y
```

## Verify it worked

Go to **Structure → Content types → *(a type with a list field)* → Manage
display**. Open the **Format** dropdown for your list field — you should now see
**Display selected and unselected values** and **Display selected and unselected
keys** among the options. Pick one, save, and view a piece of content: the field
should render all of its allowed options with the selected ones marked.
