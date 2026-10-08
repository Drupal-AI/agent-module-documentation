# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Link** field module (`link`), which ships with Drupal and is enabled
  automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/link_text_options -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/link_text_options -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en link_text_options -y
```

## Verify it worked

Edit the settings of a **Link** field (via **Manage fields** for its content
type) and confirm the new option for restricting the link text to a predefined
list appears. Add a couple of allowed labels, save, then open a content edit form
— the link‑text input for that field should now be a dropdown of your options.
