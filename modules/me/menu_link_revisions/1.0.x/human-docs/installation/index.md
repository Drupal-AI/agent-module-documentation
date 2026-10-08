# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Menu Link Content** module (`menu_link_content`) and **Menu UI**
  (`menu_ui`) — enabled automatically as dependencies when you turn this module on.
- No third‑party PHP or JavaScript libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_link_revisions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/menu_link_revisions -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_link_revisions -y
```

After enabling, visit **People → Permissions** and grant the module's menu‑link
revision permissions to the appropriate roles.

## Verify it worked

Edit a menu link at **Structure → Menus → *(a menu)* → Edit link**, save a change,
and confirm you can see the link's revision history and revert to an earlier
version — the same way node revisions work.
