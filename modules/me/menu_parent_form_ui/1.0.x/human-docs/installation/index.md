# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Menu UI** module (`menu_ui`) — enabled automatically as a dependency when
  you turn this module on.
- No third‑party PHP or JavaScript libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_parent_form_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/menu_parent_form_ui -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_parent_form_ui -y
```

That's all it takes — the cascading parent selector is active immediately, with no
required configuration.

## Verify it worked

Add or edit a menu link at **Structure → Menus → *(a menu)* → Add link**, or open a
node's edit form with menu settings. Instead of one long "Parent link" dropdown you
should now see cascading select boxes for choosing the menu and parent step by step.
