# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Link** module (`link`) — the only dependency, enabled automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/link_as_popup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/link_as_popup -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en link_as_popup -y
```

## Verify it worked

On a bundle with a Link field, open **Manage form display** and confirm the **Link
As Popup** widget is available; set it and, on **Manage display**, choose the
matching formatter. Edit content, pick the popup target for a link, and view the
page — the link should open in the modal.
