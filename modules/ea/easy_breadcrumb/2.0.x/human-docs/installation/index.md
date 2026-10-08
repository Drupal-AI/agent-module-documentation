# Installation

## Requirements

Easy Breadcrumb needs **Drupal 9.2, 10, or 11** and has **no dependencies** beyond
Drupal core — there are no contrib modules to pull in. The breadcrumb itself renders
through core's standard breadcrumb block, so nothing else is required to get a trail
on screen.

## Install with Composer

From the project root:

```bash
composer require drupal/easy_breadcrumb -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/easy_breadcrumb -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en easy_breadcrumb -y
```

Once enabled, Easy Breadcrumb registers a high-priority breadcrumb builder that takes
over breadcrumb rendering automatically. The settings form appears under
**Configuration → User interface → Easy Breadcrumb**
(`/admin/config/user-interface/easy-breadcrumb`).

## Place the breadcrumb block

Easy Breadcrumb works through core's **Breadcrumbs** block. In most themes that block
is already placed in the breadcrumb region, so a trail shows up as soon as the module
is enabled — you don't have to do anything. If you don't see a breadcrumb on your
pages, place the block by hand:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Find your theme's **Breadcrumb** region and click **Place block**.
3. Choose the **Breadcrumbs** block and place it into that region.

## Verify it worked

Log in as an administrator and visit any content page a few levels deep in your
site's path (for example a page whose alias is `/about/team`). You should see a full
`Home › About › Team` trail rendered by Easy Breadcrumb, with the current page as the
last crumb.

Next, open the settings form and tune the trail — see
[Configuration](../configuration/index.md).
