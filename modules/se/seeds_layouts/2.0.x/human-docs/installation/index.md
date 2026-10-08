# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Layout Builder** is what these layouts plug into — enable it on the
  displays where you want to use the layouts if you have not already.

Seeds Layouts declares no contrib module dependencies and no PHP or third-party
library requirements. It does register `libraries-extend` entries that hook into
the Media Library's assets, which matters for the background-image feature.

## Install with Composer

From the project root:

```bash
composer require drupal/seeds_layouts -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/seeds_layouts -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en seeds_layouts -y
```

The new layouts become available in the Layout Builder layout picker immediately.

## Submodule — enable only if you need it

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Seeds Layouts Classes Extractor** | `seeds_layouts_classes_extractor` | Makes the CSS classes emitted by these layouts discoverable to your site's CSS build tooling. Enable it if you use a utility-first framework (such as Tailwind) that purges unused classes — otherwise the layout classes can be stripped from the compiled stylesheet. |

Enable it with:

```bash
drush en seeds_layouts_classes_extractor -y
```

## Verify it worked

Edit an entity or a display that uses Layout Builder, add a section, and open the
layout picker. You should see the Seeds Layouts options alongside core's column
layouts. Selecting one and opening its section configuration should reveal the
custom class options and the background-image field.
