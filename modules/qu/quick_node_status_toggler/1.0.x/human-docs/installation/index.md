# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Node** (`node`) and **Views** (`views`) modules — Views (and Views UI)
  must be available to display the toggle switches in your content list. Both are
  enabled on a standard Drupal site.

No additional contrib modules or external libraries are required. Note the project is
*not* covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/quick_node_status_toggler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/quick_node_status_toggler -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en quick_node_status_toggler -y
```

On install, the module automatically adds a **Quick Status Toggle** column to the
default *Content* view — no further setup is needed.

## Verify it worked

Log in as a user with the **Administer nodes** permission and open **Content**
(`/admin/content`). Each row should show a toggle switch; clicking one instantly
publishes or unpublishes that item without a page reload. If you use a custom content
view, add the **Quick Status Toggle** field to it through the Views UI.
