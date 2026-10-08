# Installation

## Requirements

- **Drupal 11.1 or newer** (`core_version_requirement: ^11.1`). UI Icons builds on
  Drupal core's Icon API, which only became available in 11.1 — it does not run on
  Drupal 10.

There are no third-party Composer libraries and no other Drupal module dependencies
for the base module.

## Install with Composer

From the project root:

```bash
composer require drupal/ui_icons -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. This one package includes the base module and all of the
integration submodules.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ui_icons -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ui_icons -y
```

The base module is plumbing — enable the integration submodules below to get
usable features.

## Submodules — enable the integrations you need

UI Icons ships a large set of optional submodules. Enable individually with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Icon field** | `ui_icons_field` | An Icon field type, plus integration with Link fields for icon-decorated links. |
| **Icon media** | `ui_icons_media` | Lets icons be managed as a Media type so they appear in the media library. |
| **Icon picker** | `ui_icons_picker` | A visual grid picker widget instead of a text autocomplete. |
| **Icon library** | `ui_icons_library` | An admin overview page listing every icon available on the site. |
| **Icon CKEditor 5** | `ui_icons_ckeditor5` | A CKEditor 5 button to insert icons into rich text. |
| **Icon text filter** | `ui_icons_text` | A text filter to embed icons in filtered content. |
| **Icon menu** | `ui_icons_menu` | Attach icons to menu links in the menu UI. |
| **Icon font** | `ui_icons_font` | A FontExtractor plugin to define icon packs from web fonts (e.g. Font Awesome). |
| **Icon UI Patterns** | `ui_icons_patterns` | Use icons as props/slots inside UI Patterns components. |
| **Icon Link (Linkit / attributes)** | `ui_icons_field_linkit`, `ui_icons_field_link_attributes`, `ui_icons_field_linkit_attributes` | Integrations between icon fields and Linkit / Link Attributes widgets. |

For example, to add an Icon field and the admin library overview:

```bash
drush en ui_icons_field ui_icons_library -y
```

Each submodule requires the base UI Icons module, which is already present once you
have installed the package above.

> **Deprecated placeholders:** `ui_icons_backport` and `ui_icons_iconify_api` are
> empty placeholders (the Iconify integration now lives in the separate Iconify
> Icons module) — you do not need to enable them.
