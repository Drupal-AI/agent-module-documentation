# Installation

## Requirements

- **Drupal 10.2.2 or 11** (`core_version_requirement: ^10.2.2 || ^11`).
- These modules, which Composer/Drupal pull in as dependencies: `contextual`,
  `imce`, `token`, `entity_reference_revisions`, `rest`, `ckeditor5`, and
  `jquery_ui`.
- A valid **Acquia Site Studio licence / API key** for the build service. Without
  it the module installs but cannot compile styles or templates.

## Install with Composer

From the project root:

```bash
composer require drupal/cohesion -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed. The installed release documented here is `8.x-8.2.6`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cohesion -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module first:

```bash
drush en cohesion -y
```

## Submodules — enable the features you need

The base module is mostly plumbing; the features live in submodules. Enable the
ones your site needs, for example:

```bash
drush en cohesion_elements cohesion_templates cohesion_custom_styles cohesion_base_styles cohesion_website_settings sitestudio_page_builder -y
```

Available submodules include:

| Submodule | What it adds |
|-----------|--------------|
| `cohesion_elements` | Components and element helpers — the building blocks. |
| `cohesion_templates` | The Twig template layer for content types, views, and more. |
| `cohesion_custom_styles` / `cohesion_base_styles` | Style management. |
| `cohesion_style_guide` / `cohesion_style_helpers` | A brand style guide and helpers. |
| `cohesion_website_settings` | Site-wide settings such as colours and fonts. |
| `cohesion_sync` | Export/import a Site Studio package between environments. |
| `cohesion_breakpoint_indicator` | A responsive breakpoint indicator in the editor. |
| `sitestudio_page_builder` | The in-page drag-and-drop editor. |
| `sitestudio_governance` | Governance rules over who can edit what. |
| `sitestudio_data_transformers` | Transform data for display. |
| `sitestudio_claro` | Claro admin-theme support. |
| `sitestudio_legacy_ckeditor` | Support for migrating legacy CKEditor 4 sites. |

## Verify it worked

After enabling, go to the **Site Studio** admin section and enter your Acquia API
key (see [Configuration](../configuration/index.md)), then run:

```bash
drush cohesion:import      # first time on a new environment
drush cohesion:rebuild     # compiles styles and templates
```

If the import and rebuild complete without licence errors, Site Studio is
connected to its build service and ready to use.
