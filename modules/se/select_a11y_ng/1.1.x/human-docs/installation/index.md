# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **`select-a11y` JavaScript library** (the `bordeaux-metropole/select-a11y`
  fork) installed to `/libraries/select-a11y`. The module wraps this library and
  needs it present to work.

Select A11y NG declares no contrib module dependencies and no PHP requirement.

## Install with Composer

From the project root:

```bash
composer require drupal/select_a11y_ng -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/select_a11y_ng -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Install the JavaScript library

The module needs the `bordeaux-metropole/select-a11y` JavaScript library in your
site's `libraries/select-a11y` directory. If your project is set up with an asset
packagist (such as `asset-packagist.org`) you may be able to require it through
Composer; otherwise download the library and place it so that its files live under
`/libraries/select-a11y`. Consult the project page for the version that matches
this release.

## Enable the module

```bash
drush en select_a11y_ng -y
```

## Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Select A11y NG for Better Exposed Filters** | `select_a11y_ng_bef` | Accessible widget for Views exposed filters and exposed sort criteria (via Better Exposed Filters). |
| **Select A11y NG for Facets** | `select_a11y_ng_facets` | Renders a facet as an accessible dropdown that navigates to the selected option's facet URL. |
| **Select A11y NG for Webform** | `select_a11y_ng_webform` | Adds a per-element option on Webform select elements that swaps them to the accessible widget (disabling select2/chosen/choices). |

For example:

```bash
drush en select_a11y_ng_bef -y
```

## Verify it worked

On **Manage form display** for an entity with a list or entity-reference field,
set its widget to Select A11y NG and save. Open a form using that field — it should
render as an accessible, searchable select. If the widget appears as a plain select
instead, confirm the JavaScript library is present at `/libraries/select-a11y`.
