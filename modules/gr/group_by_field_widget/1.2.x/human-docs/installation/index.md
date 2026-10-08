# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ~9.0 || ^10.0 || ^11`).
- Core only — there are no contributed module dependencies. Core's **Field UI**
  is needed so you can change the widget on a form display.

## Install with Composer

From the project root:

```bash
composer require drupal/group_by_field_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/group_by_field_widget -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en group_by_field_widget -y
```

## Verify it worked

Go to a content type's **Manage form display** (**Structure → Content types →
*(type)* → Manage form display**) and open the widget dropdown for an
entity‑reference field. You should see **Group by field reference widget** as an
available choice. Selecting it and configuring a "group by" field should render
the options in collapsible groups on the entity's add/edit form.
