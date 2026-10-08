<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Documentation generator (documentation_generator) — agent index

Assembles a **user guide of the site's structure** (content types + fields, block content types,
menus, paragraph types, taxonomy vocabularies, user roles, views, enabled modules) from pluggable
**chapter** plugins, and emits it via pluggable **render** plugins as an on-screen HTML overview
table or a downloadable **Word (`.docx`) / PDF** file. Version **2.0.9** (dir `2.0.x`). Core
`^9.3 || ^10 || ^11`. License GPL-2.0-or-later.

## What it actually is

- No hard Drupal module dependencies (`.info.yml` lists none). Chapter plugins each declare an
  optional runtime module dependency (e.g. `menu`→`menu_ui`, content types→`node`, views→`views`)
  and are skipped when it is absent.
- Requires two PHP libraries via Composer: `phpoffice/phpword` (Word export) and `dompdf/dompdf`
  (PDF export). Exposed as services `documentation_generator.php_word` and
  `documentation_generator.dompdf`.
- Provides **1 permission**, **2 plugin types**, **4 routes/forms+controller**, **2 config
  objects (with schema)**, **2 theme hooks**. No entities, no Drush.

## Routes (all require permission `administer documentation generator`)

Base path `/admin/config/documentation-generator`; local tasks under *Configuration → Content →
"Administer your user guide"*.

| Route | Path suffix | Handler | Purpose |
|---|---|---|---|
| `documentation_generator.overview` | `/overview` | `OverviewController::generateOverview` | On-screen HTML overview table of the compiled guide |
| `documentation_generator.generate` | `/generate` | `Form\GenerateForm` | Pick a render plugin, generate a `.docx`/`.pdf` into `private://` |
| `documentation_generator.settings_plugin_form` | `/plugins` | `Form\SettingsPluginForm` | Enable/disable chapter plugins |
| `documentation_generator.settings_element_form` | `/elements` | `Form\SettingsElementsForm` | Hide individual elements per plugin |

## Solution docs

- **Routes, permission, config objects/schema, the four forms/controller, the generate + download
  flow** → [config/settings.md](config/settings.md)
- **The `DocumentationGeneratorChapter` plugin type, the 8 built-in chapters, and how to add one
  (sample plugin)** → [plugins/chapters.md](plugins/chapters.md)
- **The `DocumentationGeneratorRender` plugin type, the PDF and Word plugins, and the private-file
  download hook** → [plugins/render.md](plugins/render.md)
