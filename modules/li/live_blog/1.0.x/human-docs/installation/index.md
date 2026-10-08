# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).
- Core's **Node** (`node`) and **User** (`user`) modules — both standard on any
  Drupal site.

There are no third‑party Composer packages or PHP library requirements.

> **A note on security coverage:** this project is **not** currently covered by
> the Drupal security advisory policy, and (as noted in the overview) its polling
> feed endpoint is open to anonymous readers by design. Keep live‑blog content to
> what you're comfortable serving publicly.

## Install with Composer

From the project root:

```bash
composer require drupal/live_blog -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/live_blog -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en live_blog -y
```

## Verify it worked

Log in as an administrator and go to **Structure → Live Blog**
(`/admin/structure/live-blog`). You should see the Live Blog settings page, along
with the **fields** and **list** sub‑pages. From there, follow the
[Configuration](../configuration/index.md) guide to add the Live Blog field to a
content type and start posting.
