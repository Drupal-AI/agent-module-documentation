# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Image** module (`image`) enabled — the only dependency. Drupal enables it
  automatically if it isn't already on.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/bg_image_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/bg_image_formatter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bg_image_formatter -y
```

Once enabled, the **Background Image** formatter becomes available on any image field's
**Manage display** screen — see the [overview](../index.md#how-to-use-it) for how to
apply and configure it.

## Submodule — enable only if you need it

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Responsive Background Images Formatter** | `responsive_bg_image_formatter` | A variant that uses a **responsive image style** instead of a single image style, emitting one media‑query rule per breakpoint so the background adapts to screen size. |

```bash
drush en responsive_bg_image_formatter -y
```

It requires the base Background Images Formatter module, which is already present once
you've installed it above.
