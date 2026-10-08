# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The two modules it bridges, both required dependencies (Composer installs them):
  - **Link Attributes** (`link_attributes`) — the widget that lets you set `rel`,
    `target`, `class`, and similar attributes on a link.
  - **Link with description** (`link_description`) — the link field that carries a
    description.

## Install with Composer

From the project root:

```bash
composer require drupal/link_description_attributes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including Link Attributes and Link with description.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/link_description_attributes -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en link_description_attributes -y
```

## Verify it worked

On a bundle that has a **Link with description** field, open **Manage form
display** and confirm the **Link description (with attributes)** widget is
selectable. Choose it, save, then edit a piece of content to confirm you can set
link attributes on the described link.
