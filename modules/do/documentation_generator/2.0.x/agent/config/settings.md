<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Install, routes, permission, config & the generate flow

## Install & enable

```bash
composer require drupal/documentation_generator
drush en documentation_generator -y
```

Composer pulls `phpoffice/phpword ^1.4.0` (Word export) and `dompdf/dompdf ^3.1.0` (PDF export).
No Drupal module dependencies are declared in `documentation_generator.info.yml`. There is **no
`configure:` key** and no up-front settings form — the module works once enabled. A PDF/Word
generation additionally needs a **working private file system** (`private://`); the generate form
tells you to check `/admin/config/media/file-system` if it fails.

## Permission (`documentation_generator.permissions.yml`)

- `administer documentation generator` — "Administer Documentation Generator". Gates **all four
  routes** and the download of the generated files. Grant only to trusted administrators.

## Routes (`documentation_generator.routing.yml`)

All under `/admin/config/documentation-generator`, all `requirements._permission:
'administer documentation generator'`:

- `documentation_generator.overview` → `/overview` → `Controller\OverviewController::generateOverview`
- `documentation_generator.generate` → `/generate` → `Form\GenerateForm`
- `documentation_generator.settings_plugin_form` → `/plugins` → `Form\SettingsPluginForm`
- `documentation_generator.settings_element_form` → `/elements` → `Form\SettingsElementsForm`

Menu link `documentation_generator.overview` sits under `system.admin_config_content`
(*Configuration → Content*, title "Administer your user guide"); the other three are local tasks
(`documentation_generator.links.task.yml`) tabbed off the overview.

## Config objects + schema (`config/`)

Two `config_object`s, both with schema in `config/schema/documentation_generator.schema.yml`
(so `provides_config_schema: true`):

- **`documentation_generator.enabled_plugins`** — `plugins`: sequence of chapter plugin ids that
  appear in the output. Install default (`config/install/…enabled_plugins.yml`):
  `block_content_type, menu, node_type, taxonomy_vocabulary, user_role, view, enabled_modules`
  (note: the `paragraph` chapter is **not** enabled by default).
- **`documentation_generator.disabled_elements`** — `elements`: sequence of
  `<pluginId>_<elementKey>` strings that are hidden even when their plugin is enabled. Install
  default: empty (`elements: {}`).

## The four handlers

- **`OverviewController::generateOverview()`** — builds a `#type => 'table'` render array. Iterates
  every chapter definition, instantiates it, and if `$plugin->available()` is TRUE appends each
  element's `value` as a row. Indented rows (level > 1) are prefixed with a rendered
  `indentation_documentation` theme element and wrapped in `Markup::create(...)`. `paragraph`
  elements carrying `parameters` are expanded by `resolveParameter()` (see plugins/chapters.md for
  the element/parameter shape). This is the on-screen HTML view; it does **not** write a file.
- **`GenerateForm`** (`FormBase`, `getFormId` `documentation-generator-generate-form`) — a radios
  list of render plugins (label from each plugin definition) plus a **Generate** submit. On submit
  it instantiates the chosen render plugin, builds `$groups` from every *available* chapter's
  `elements()`, resolves `private://` via `file_system->realpath()`, sets the doc title to
  `"<site name> Documentation"`, then calls `$plugin->render($fileName, $privatePath, $title,
  $groups)`. On success it shows a download link to `system.private_file_download` for
  `documentation.<ext>`; on failure it points the admin at the file-system settings page.
- **`SettingsPluginForm`** (`ConfigFormBase`, editable config
  `documentation_generator.enabled_plugins`) — a single `checkboxes` element listing every chapter
  plugin (id ⇒ label); saves the checked ids to `plugins`.
- **`SettingsElementsForm`** (`ConfigFormBase`, editable config
  `documentation_generator.disabled_elements`) — one `checkboxes` group per *enabled* plugin, whose
  options are `<pluginId>_<elementKey>` for each key returned by that plugin's `pluginElements()`;
  saves the checked ones to `elements`. Those keys are what `removeDisabledElements()` strips at
  generation time.

## Theme hooks (`documentation_generator.module`)

- `documentation` — variables `title`, `groups`; templates `templates/documentation.html.twig`
  (used by the render plugins to build the exported HTML).
- `indentation_documentation` — variable `size`; `templates/indentation-documentation.html.twig`
  (renders the leading indentation for nested overview rows). CSS library `indentation_styles`
  (`css/documentation_generator.css`).

## Operate it

1. `/admin/config/documentation-generator/plugins` — tick the chapters you want.
2. `/admin/config/documentation-generator/elements` — optionally hide specific elements.
3. `/admin/config/documentation-generator/overview` — read the compiled guide on screen.
4. `/admin/config/documentation-generator/generate` — choose **Word** or **PDF**, click Generate,
   then follow the download link (served from `private://documentation.docx|pdf`).
