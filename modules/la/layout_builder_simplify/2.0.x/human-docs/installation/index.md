# Installation

## Requirements

Layout Builder Simplify extends core Layout Builder. It needs:

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **Layout Builder** module (`layout_builder`) enabled.
- Core's **System** module (`system`) — always present in a Drupal install.

Drupal will enable the Layout Builder dependency (and its own dependencies)
automatically when you turn on this module. There are no third‑party Composer or PHP
library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_simplify -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_builder_simplify -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_simplify -y
```

That's all it takes. There is no settings form — the block chooser changes as soon
as the module is enabled.

## Verify it worked

Edit a page that uses Layout Builder and click **Add block**. The off‑canvas chooser
should now show block **categories** first; clicking a category should open a second
screen with that category's blocks and a name filter. Under **Custom** you should see
recently updated content blocks and a type‑ahead search box.
