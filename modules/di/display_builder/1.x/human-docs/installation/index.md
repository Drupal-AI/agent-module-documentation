# Installation

## Requirements

- **Drupal 11.4** or newer (`core_version_requirement: ^11.4`).
- The **UI Patterns** modules — specifically `ui_patterns_field`
  (`ui_patterns:ui_patterns_field`) and `ui_patterns_library`
  (`ui_patterns:ui_patterns_library`), which Composer installs as dependencies.
- No other third‑party Composer packages or PHP libraries.
- *Recommended:* a design‑system theme built with SDC components — for example one
  of the UI Suite themes (UI Suite Bootstrap, UI Suite DaisyUI/Tailwind, UI Suite
  DSFR, UI Suite USWDS) — or your own SDC‑based theme, since Display Builder is
  designed to use your design system directly.

## Install with Composer

From the project root:

```bash
composer require drupal/display_builder -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
and pull in the required UI Patterns modules.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/display_builder -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module first:

```bash
drush en display_builder -y
```

## Submodules — enable what you want to build

The base module provides the framework; the building experiences come from its
submodules. Enable only the ones you need:

| Submodule | Machine name | What it lets you build |
|-----------|--------------|------------------------|
| **UI** | `display_builder_ui` | The builder user interface itself. |
| **Entity view** | `display_builder_entity_view` | Entity view displays (view modes) — a replacement for Layout Builder. |
| **Page layout** | `display_builder_page_layout` | Page displays — a replacement for Block Layout. |
| **Views** | `display_builder_views` | Views output — a replacement for the Views display‑building feature. |

For example, to build entity view displays with the UI:

```bash
drush en display_builder_ui display_builder_entity_view -y
```

## Verify it worked

After enabling the base module and at least one submodule, go to the relevant
building context (an entity type's **Manage display**, the page/Block layout area,
or a View, depending on which submodule you enabled) and confirm the Display Builder
interface is available there. Because it is a powerful builder, review who has
access before using it on production content.
