# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Layout Builder** enabled.
- **jQuery UI Tabs** (`jquery_ui_tabs`) and **jQuery UI Accordion**
  (`jquery_ui_accordion`) — contributed modules carrying the jQuery UI components
  Drupal removed from core after Drupal 9. They are pulled in as dependencies.

Keep in mind that jQuery UI is in long-term maintenance, and the accessibility of
the resulting tabs/accordions is inherited from those components — test it before
relying on it.

## Install with Composer

From the project root:

```bash
composer require drupal/lb_tabs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the jQuery UI
dependency modules.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/lb_tabs -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lb_tabs -y
```

Enabling `lb_tabs` also enables `jquery_ui_tabs` and `jquery_ui_accordion`.

## Verify it worked

Edit a Layout Builder layout, add a section, and confirm the **Tabs** and
**Accordion** layouts appear among the layout choices. Place blocks into the
regions, save, and view the page — the blocks should render as tabs or collapsible
panels.
