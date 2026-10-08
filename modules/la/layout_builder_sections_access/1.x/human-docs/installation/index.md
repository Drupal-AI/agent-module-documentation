# Installation

## Requirements

Layout Builder Sections Access extends core Layout Builder. It needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Layout Builder** module (`layout_builder`) enabled — this is the only
  dependency, and Drupal will enable it (and its own dependencies) automatically.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_sections_access -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_builder_sections_access -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_sections_access -y
```

That's all it takes. There is no separate settings form — the per‑section options
appear directly in the Layout Builder UI.

## Verify it worked

Edit a page that uses Layout Builder and add or configure a section. In the section
settings you should now see an extra option to **deactivate** the section or
**restrict** it to selected roles. Restricting a section and viewing the page as a
non‑matching role should remove that section from the rendered HTML entirely.
