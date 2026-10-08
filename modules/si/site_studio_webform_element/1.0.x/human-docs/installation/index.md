# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Acquia Site Studio** module (`cohesion`) — a hard dependency and Acquia's
  commercial licensed product.
- The **Webform** module (`webform`).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/site_studio_webform_element -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/site_studio_webform_element -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en site_studio_webform_element -y
```

There is no configuration form and no permissions to grant. The Webform element
becomes available in the Site Studio builder immediately.

## Verify it worked

Open the Site Studio builder, edit or create a component, and confirm that a
**Webform element** now appears in the palette and that adding it lets you pick
from your site's Webforms.
