# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- Contributed modules pulled in via Composer:
  - **Paragraphs** (`drupal/paragraphs` `^1.17`)
  - **Field Group** (`drupal/field_group` `^3.4 || ^4.0`)
  - **Twig Tweak** (`drupal/twig_tweak` `^3.2`)
  - **Views Reference** (`drupal/viewsreference` `^2.0`)
- A number of core modules (Field, File, Filter, Image, Link, Media, Media
  Library, Options, Taxonomy, Text, User, Views, Entity Reference Revisions),
  enabled automatically as dependencies.

**Front-end requirement:** the components render USWDS markup but ship only small
per-component CSS shims — the full USWDS CSS/JS must be provided by your theme. The
project suggests the [`uswds_base`](https://www.drupal.org/project/uswds_base)
theme, and optionally
[`uswds_blb_configuration`](https://www.drupal.org/project/uswds_blb_configuration)
for Bootstrap Layout Builder helpers.

## Install with Composer

From the project root:

```bash
composer require drupal/uswds_paragraph_components -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Paragraphs, Field
Group, Twig Tweak, Views Reference and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/uswds_paragraph_components -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

The base module on its own ships **no** paragraph bundles — it only provides the
base template, the field widget and the help page. Enable it plus the component
submodules you actually need:

```bash
drush en uswds_paragraph_components -y
```

## Submodules — enable only the components you need

Each component is a separate submodule that installs its bundle(s), fields,
displays and template. Enable them individually with `drush en`:

| Submodule | What it adds |
|-----------|--------------|
| `uswds_paragraph_components_accordions` | USWDS accordion (bordered / multiselect options) |
| `uswds_paragraph_components_alerts` | USWDS alert (info/warning/error/success, slim, no-icon) |
| `uswds_paragraph_components_breakpoints` | Grid helper — `uswds_breakpoints` taxonomy + card breakpoints type + a view. Auto-required by Cards and Columns |
| `uswds_paragraph_components_cards` | Responsive card groups (regular and flag layouts) |
| `uswds_paragraph_components_columns` | Two- and three-column responsive grid layouts |
| `uswds_paragraph_components_modal` | USWDS modal dialog |
| `uswds_paragraph_components_process_list` | Numbered process list |
| `uswds_paragraph_components_step_indicator` | Step indicator (counters, centered, no-labels variants) |
| `uswds_paragraph_components_summary_box` | USWDS summary box |

For example, to enable accordions and alerts:

```bash
drush en uswds_paragraph_components_accordions uswds_paragraph_components_alerts -y
```

Each submodule requires the base module (already present once installed), and the
Cards and Columns submodules automatically bring in
`uswds_paragraph_components_breakpoints`.

Once the components are enabled, add a Paragraphs field to a content type and allow
the top-level bundles — see the [overview](../index.md) for the field-setup steps.
