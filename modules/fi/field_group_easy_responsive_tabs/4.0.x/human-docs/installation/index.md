# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- The contrib **Field Group** module (`field_group`) — a hard dependency.
  Composer installs it automatically.
- The **Easy Responsive Tabs to Accordion** jQuery plugin, downloaded and placed
  in your site's `/libraries/` folder (see below). This is an external front‑end
  library that is *not* installed by Composer.

## Install the module with Composer

From the project root:

```bash
composer require drupal/field_group_easy_responsive_tabs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Field Group and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_group_easy_responsive_tabs -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Install the jQuery library

The tabs/accordion behavior comes from a third‑party jQuery plugin that you must
add manually:

1. Download the **Easy Responsive Tabs to Accordion** plugin.
2. Uncompress it and rename the main folder to **`easy-responsive-tabs`**.
3. Copy that folder into your site's **`/libraries/`** directory, so the plugin
   ends up at `/libraries/easy-responsive-tabs/`.

Without this library in place, the module has nothing to drive the tabs/accordion
rendering.

## Enable the module

```bash
drush en field_group_easy_responsive_tabs -y
```

Drupal will enable Field Group at the same time if it is not already on.

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage display**, add a field
group, and confirm the responsive tabs/accordion format is available. Add a couple
of child groups with fields, save, and view a piece of content — it should render
as tabs on a wide screen and collapse to an accordion as you narrow the browser
window. If nothing renders as tabs, re‑check that the jQuery library is at
`/libraries/easy-responsive-tabs/`.
