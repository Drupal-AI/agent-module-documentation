# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- The **Chosen** module (`chosen`).
- The **Chosen Field** module (`chosen_field`).
- The **jQuery UI Sortable** module (`jquery_ui_sortable`).

Composer installs the contrib dependencies for you when you require the module.
Note that the **Chosen** module itself also needs its Chosen JavaScript library
available — follow the Chosen module's own installation instructions for that.

## Install with Composer

From the project root:

```bash
composer require drupal/chosen_order -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update and install the
shared dependencies (Chosen, Chosen Field, jQuery UI Sortable) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/chosen_order -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en chosen_order -y
```

Drush enables the dependent modules (`chosen`, `chosen_field`,
`jquery_ui_sortable`) along with it. Make sure the Chosen library is in place so
the Chosen widget actually renders.

## Verify it worked

Open the add/edit form of an entity with a multiple-value select field that uses
the Chosen widget. Select a few values — you should now be able to drag the
selected chips to reorder them, and that order should stick after you save.
