# Installation

## Requirements

- **Drupal 10.3.4 or 11** (`core_version_requirement: ^10.3.4 || ^11`). The base
  module builds on core's Single Directory Components (SDC) system.
- The **`justinrainbow/json-schema`** PHP library (`^5.2 || ^6.3`), used to
  validate component prop values against their JSON schema. Composer installs it
  automatically.

No other Drupal modules are required by the base module — but you'll want at least
one **delivery submodule** (below) to actually use components, and you need SDC
components defined somewhere (in a theme or module) for there to be anything to
place.

## Install with Composer

From the project root:

```bash
composer require drupal/ui_patterns -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the JSON-schema
library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ui_patterns -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the base module and the submodules you need

```bash
drush en ui_patterns -y
```

The base module is the engine; the **submodules** are where components actually
surface. Enable the ones matching where you want to use components:

| Submodule | Machine name | What it lets you do |
|-----------|--------------|---------------------|
| **Field formatters** | `ui_patterns_field_formatters` | Render a field's value as a component (whole field → one component, or each item → a component) on **Manage display**. |
| **Blocks** | `ui_patterns_blocks` | Place a component as a block in a region (or the Layout Builder block chooser). |
| **Layouts** | `ui_patterns_layouts` | Use a component as a Layout Builder / Display Suite section layout, with its slots as regions. |
| **Views** | `ui_patterns_views` | Build Views listings whose rows or style are a repeatable component. |
| **Field** | `ui_patterns_field` | Store a component as a field value, so editors pick and fill a component in a field widget. |
| **Library** | `ui_patterns_library` | A page that previews and browses every available component. |
| **UI** | `ui_patterns_ui` | Additional UI helpers for working with components. |
| **Legacy** | `ui_patterns_legacy` | Migrate legacy UI Patterns 1.x `pattern` definitions onto SDC. |

For example, to render fields as components and place components as blocks:

```bash
drush en ui_patterns_field_formatters ui_patterns_blocks -y
```

## Verify it worked

Enable the **Library** submodule (`ui_patterns_library`) and visit its component
browser to confirm your SDC components are discovered. Or, with
`ui_patterns_field_formatters` enabled, go to a bundle's **Manage display** and
check that a field's **Format** dropdown now offers a "Component" option. See
[Configuration](../configuration/index.md) for wiring a component up.
