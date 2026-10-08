# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **UI Patterns** module (`ui_patterns`) — a hard dependency. This 1.x release
  targets the **UI Patterns 1.x** API.
- Core's **Layout Builder** module (`layout_builder`) — a hard dependency Drupal
  enables for you.
- A **pattern‑layout discovery module** such as **`ui_patterns_layout`** (part of
  the UI Patterns project), which registers your patterns as base layouts. Without
  it there are no `pattern_*` layouts for this module to enhance.
- A set of **UI Patterns components** defined by your theme or a component module —
  those are what appear as layouts.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ui_patterns_layout_builder -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install UI Patterns and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ui_patterns_layout_builder -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable this module together with Layout Builder and a pattern‑layout discovery
module:

```bash
drush en layout_builder ui_patterns_layout ui_patterns_layout_builder -y
```

(UI Patterns is enabled automatically as a dependency.)

## Verify it worked

Enable Layout Builder on a content type's display (**Manage display → Use Layout
Builder → Manage layout**), click **Add section**, and confirm your UI Patterns
components appear in the layout list. There is no configuration to do. See the
[overview page](../index.md#how-to-use-it) for the full walkthrough.
