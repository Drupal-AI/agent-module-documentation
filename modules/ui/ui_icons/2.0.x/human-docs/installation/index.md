# Installation

## Requirements

- **Drupal 11.3 or 12** (`core_version_requirement: ^11.3 || ^12.0`). The 2.0.x
  branch requires Drupal 11.3+; use the 1.1.x branch for Drupal 11.1/11.2.
- Core's **Icon API** (part of Drupal core from 11.1) — no separate install
  needed.

The base module has **no module dependencies** and no third-party Composer or PHP
library requirements. (Individual submodules pull in the core modules they
integrate with — Media, CKEditor 5, and so on.)

## Install with Composer

From the project root:

```bash
composer require drupal/ui_icons -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ui_icons -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ui_icons -y
```

The base module gives you the icon autocomplete form element and its services. On
its own that's rarely what you want — enable the submodules for the integrations
you need.

## Submodules — enable only what you need

UI Icons ships a rich set of submodules, each adding one integration surface.
Enable them individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Icon field** | `ui_icons_field` | An Icon field type (plus Link-field integration) so you can store a picked icon on an entity and render it in displays. This is the one most sites want first. |
| **Icon field — Link attributes** | `ui_icons_field_link_attributes` | Link-with-attributes integration for icon fields (nested under Icon field). |
| **Icon field — Linkit** | `ui_icons_field_linkit` | Linkit integration for icon fields. |
| **Icon field — Linkit attributes** | `ui_icons_field_linkit_attributes` | Linkit-with-attributes integration for icon fields. |
| **Icon in Canvas** | `ui_icons_canvas` | *(New in 2.0)* Makes the icon field/widget editable as a Drupal Canvas component input. |
| **Icon media** | `ui_icons_media` | Lets icons be used as a media type. |
| **Icon picker** | `ui_icons_picker` | A fancy modal grid picker widget for choosing icons. |
| **Icon library** | `ui_icons_library` | An admin overview page listing every icon available on the site (ships a permission). Great as editor documentation or a client showcase. |
| **Icon font** | `ui_icons_font` | A web-font extractor so you can define icon packs from web fonts. |
| **Icon text filter** | `ui_icons_text` | A text filter to embed icons in filtered content via `<drupal-icon>`. |
| **Icon in menu** | `ui_icons_menu` | Menu UI integration to attach icons to menu links. |
| **Icon in CKEditor 5** | `ui_icons_ckeditor5` | A CKEditor 5 plugin/button to embed icons in rich text. **Not compatible** with the `ckeditor5_icons` module. |
| **Icon UI Patterns** | `ui_icons_patterns` | Icons integration with UI Patterns 2.x (1.x is no longer supported). |

For example, to add an icon field and the modal picker:

```bash
drush en ui_icons_field ui_icons_picker -y
```

Each submodule requires the base UI Icons module, which is already present once you
have installed it above.

## Verify it worked

After enabling, define (or copy from the examples repository) an
`EXTENSION.icons.yml` icon pack so there are icons to choose from, then rebuild
caches (`drush cr`). If you enabled **Icon library**, visit its admin overview
page to confirm your icons are discovered. If you enabled **Icon field**, add an
Icon field to a content type and check that the autocomplete (or picker) lists your
icons.
