# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other module dependencies and no third-party libraries. It works with core's
  Field UI, which is enabled on most sites.

## Install with Composer

From the project root:

```bash
composer require drupal/heading_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Note on the package name.** Use `drupal/heading_formatter` exactly as shown
> above. (The module's own README shows a mistyped example with a stray suffix —
> ignore that; the correct Composer package and machine name is
> `heading_formatter`.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/heading_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en heading_formatter -y
```

## Verify it worked

Go to the **Manage display** page of any content type that has a plain-text
(`string` / `textfield`) field — **Structure → Content types → *(your type)* →
Manage display**. In that field's **Format** dropdown you should now see a
**Heading** option. Selecting it and opening its settings lets you choose the
heading level and a CSS class, as described in [How to use
it](../index.md#how-to-use-it).
