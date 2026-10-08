<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Document Loader: Tool (document_loader_tool) — agent index

Exposes **Document Loader** to AI agents as derived **Tool** plugins. Package `Web services`.
Version 2.0.5. Core `^10.4 || ^11`. GPL-2.0-or-later. Depends on `document_loader` + `tool`
(the AI module supplies the function-calling layer). No Drush, no config schema.

## Permission (`document_loader_tool.permissions.yml`)

- `use document_loader tool` — "Use Document Loader Tool". Gates every derived tool
  (`DocumentLoaderTool::checkAccess()` → `allowedIfHasPermission`).

## What it provides

- **Tool plugin** `src/Plugin/tool/Tool/DocumentLoaderTool.php` — `#[Tool(id: 'document_loader',
  operation: Read, deriver: DocumentLoaderToolDeriver::class)]`, extends `ToolBase`.
  `doExecute()` reads `output_format`/`max_length`, resolves the source category from the
  derivative ID, and delegates to `DocumentLoaderManager::loadFromData($values, currentUser,
  $output_format, $max_length, caller: 'tool')`. Success returns `content`, `format`, `loader`,
  and JSON `metadata`.
- **Deriver** `src/Derivative/DocumentLoaderToolDeriver.php` — one derivative per source category:
  `document_loader:load_file`, `:load_website`, `:load_api`, and auto-derived `:load_{category}`
  for novel input classes. Builds `InputDefinition`s from each category's merged
  `getToolInputSchema()` + shared `output_format`/`max_length`; folds in loader options scoped as
  `{loader_id-with-':' -> '_C_'}__{option}`. Categories with no registered loader are skipped.
- **Hooks** `src/Hook/DocumentLoaderToolHooks.php` — `#[Hook('form_alter')]` for
  `ai_agent_add_form`/`ai_agent_edit_form`, `modeler_api_wrapper`, and `ai_api_explorer_form`:
  for loader options whose schema has `hide_from_llm_by_default` (default TRUE), pre-selects
  "Force value" + "Hide property" and pre-fills the forced value with the schema default.

## Derived tools (out of the box)

- `document_loader:load_file` — `file_input`, `output_format`, `max_length`.
- `document_loader:load_website` — `url`, `output_format`, `max_length`.
- `document_loader:load_api` — `url`, `api_method`, `api_headers`, `api_body`, `output_format`,
  `max_length`.

## Notes

- Needs a Document Loader **loader** plugin for a category to appear (categories with no loader are
  excluded) and to actually extract.
- Runs as the current user; file entity `view` access is enforced by the pipeline.
