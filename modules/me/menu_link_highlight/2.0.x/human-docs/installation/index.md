# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Menu Link Content** module (`menu_link_content`) — enabled automatically
  as a dependency when you turn this module on.
- No third‑party PHP or JavaScript libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_link_highlight -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/menu_link_highlight -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_link_highlight -y
```

After enabling, visit **People → Permissions** and grant the module's highlight
permission to the roles that should be able to flag menu links.

## Verify it worked

Edit a menu link at **Structure → Menus → *(a menu)* → Edit link** and confirm the
new **highlight** checkbox appears. Tick it, save, and inspect the rendered menu —
the link's `<li>` element should now carry the highlight class, ready for you to
style in your theme.
