<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DOI Field (doi_field) — agent index

Adds one **field type** for storing a **DOI** (Digital Object Identifier, e.g. `10.1000/182`). On
display, its formatter resolves the stored DOI to publication metadata (title, authors, abstract,
date, links) and renders it. Package `Field types`. Version **2.0.2** (dir 2.0.x). Core
`^8.8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later.

- **Dependency:** requires **`doi_search`** (`drupal/doi_search:^2.0`, auto-installed by Composer).
  The formatter calls its `doi_search.manager` service to fetch metadata.
- **No** permissions, routes, services, config schema, install file, Drush commands or submodules.

## What it provides (all in `src/Plugin/`)

- **Field type** `doi_field` — `Field/FieldType/DoiFieldItem.php`. One string property `value`
  (varchar 255). `default_widget = "string_textfield"`, `default_formatter = "doi_field_formatter"`,
  `category = "general"`. Attaches the `Doi` validation constraint.
- **Widget** `doi_field_widget` — `Field/FieldWidget/DoiFieldWidget.php`. A plain `textfield`
  (selectable alternative to core's string_textfield).
- **Formatter** `doi_field_formatter` — `Field/FieldFormatter/DoiFieldFormatter.php`. Fetches
  metadata per item and themes it; settings choose which elements show and whether to print labels.
- **Validation constraint** `Doi` (+ validator) — `Plugin/Validation/Constraint/`. Regex
  `^10\.\d+(\.\d+)*\/\S+$`.
- **Theme hook** `doi_field` + template `templates/doi-field.html.twig` (declared in
  `doi_field.module` `hook_theme()`); also `hook_help()`.

## Solution docs

- Field type, widget, DOI validation constraint, and how to add the field to an entity →
  [fields/field-type.md](fields/field-type.md)
- The formatter, its display settings, the external Crossref lookup, and the template →
  [fields/formatter.md](fields/formatter.md)
