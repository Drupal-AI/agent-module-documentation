<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Chapter plugins (`DocumentationGeneratorChapter`)

A **chapter** contributes one section of the generated guide. This is the extensible plugin type
that decides *what* the module documents.

## Plugin type wiring

- Manager service `plugin.manager.documentation_generator_chapter.processor` =
  `Plugin\DocumentationGeneratorChapterManager` (extends `DefaultPluginManager`); discovers plugins
  in `Plugin/DocumentationGeneratorChapter`, interface
  `Plugin\DocumentationGeneratorChapterInterface`, annotation
  `Annotation\DocumentationGeneratorChapter` (`@DocumentationGeneratorChapter(id, label)`).
- Base class `Plugin\DocumentationGeneratorChapterBase` (injects `entity_type.manager`,
  `entity_field.manager`, `module_handler`, `config.factory`, `extension.list.module`).

## Interface / base contract

Each chapter implements:

- `moduleDependencies()` → array of module machine names the chapter needs (empty = none).
- `pluginElements()` → the raw items it will document, **keyed** (the keys become the
  `<pluginId>_<key>` toggles on the "Disabled Elements" form).
- `elements()` → the ordered array of output elements. Each element is
  `['type' => 'title'|'paragraph', 'level' => int, 'value' => string, 'parameters' => [...]?]`.
  A `value` may contain the literal token `@parameter`; each `parameters[k]` is either
  `['type' => 'link', 'text' => ..., 'src' => ...]` or `['type' => 'list', 'items' => [...]]` and
  is substituted where the token appears (by `OverviewController::resolveParameter()` for HTML and
  by the render plugins for Word/PDF).

Base helpers:

- `available()` — TRUE only if every `moduleDependencies()` module exists **and** the plugin id is
  present in `documentation_generator.enabled_plugins:plugins`. Both the overview controller and the
  generate form skip unavailable chapters.
- `removeDisabledElements(&$elements)` — unsets any element whose `<pluginId>_<key>` is listed in
  `documentation_generator.disabled_elements:elements`.

## Built-in chapters (`src/Plugin/DocumentationGeneratorChapter/`)

| id | label | requires module | documents |
|---|---|---|---|
| `block_content_type` | Block Content Type | `block_content` | Block (custom) content types |
| `menu` | Menu | `menu_ui` | Menus + each menu block's region and visibility (node types / paths / roles) |
| `node_type` | Content Type | `node` | Content types and their field definitions |
| `paragraph` | Paragraph Types | `paragraphs` | Paragraph types and their fields (contrib `paragraphs`; off by default) |
| `taxonomy_vocabulary` | Taxonomy Vocabulary | `taxonomy` | Vocabularies |
| `user_role` | User Role | `user` | User roles |
| `view` | View | `views` | Configured views |
| `enabled_modules` | Modules | — | Installed modules + descriptions (from `extension.list.module`) |

Each pulls data from Drupal's own APIs (entity storage, `entity_field.manager`, `module_handler`)
and adds `Url::fromUserInput(...)` links to the relevant admin pages (e.g. the menu chapter links
to `/admin/structure/menu/manage/<id>`).

## Add your own chapter

Copy `sample/SampleDocumentationPlugin.php` (id `sample_documentation_plugin`, label "Sample
Documentation Plugin") into your module's `src/Plugin/DocumentationGeneratorChapter/`, adjust the
`@DocumentationGeneratorChapter` annotation, and implement the three interface methods. Return
`title`/`paragraph` elements with a `level`; use the `@parameter` token with a `link` or `list`
parameter for links and bullet lists. Then enable it on the "Enabled Plugins" form. (The sample
lives under `sample/`, which is **not** autoloaded — it is a template to copy, not an active
plugin.)
