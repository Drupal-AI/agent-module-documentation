<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Document Loader: AI Automator (document_loader_automator) — agent index

AI Automator types that extract a source field's document via **Document Loader** and write the
result into the destination field. **No AI provider needed** (extends `ExternalBase`). Package
`Web services`. Version 2.0.5. Core `^10.4 || ^11`. GPL-2.0-or-later.
Depends on `document_loader` + `ai_automators` (from the AI module). No permissions, routes, or
Drush.

## What it provides

- **Plugin type consumed**: `ai_automators` `AiAutomatorType` plugins in
  `src/Plugin/AiAutomatorType/`. Base `DocumentLoaderAutomatorBase` (uses `InputResolverTrait`;
  `needsPrompt()`/`advancedMode()` = FALSE). Shipped plugin IDs (one per destination field type):
  - `document_loader_text` (field_rule `text`)
  - `document_loader_text_long` (`text_long`)
  - `document_loader_text_with_summary` (`text_with_summary`)
  - `document_loader_string` (`string`)
  - `document_loader_string_long` (`string_long`)
  - `document_loader_json`, `document_loader_json_native`, `document_loader_json_native_binary`
- **Config schema** (`config/schema/document_loader_automator.schema.yml`): each plugin extends
  `ai_automator_type_plugin_base` with `automator_output_format` (string); the text variants also
  add `automator_use_text_format` (nullable string).
- **Mechanism**: reads the base field, resolves it to `['file_input' => …]` or `['url' => …]` per
  source type (file/image/media/link/string/text — see README table), calls
  `DocumentLoaderManager::loadFromData($data, currentUser, $output_format)`, stores content in the
  destination field. Output formats discovered dynamically from installed loaders.

## Operate

1. `drush en document_loader_automator -y` (needs a loader plugin module installed to extract).
2. *Structure → Content types → [type] → Manage fields*, edit the destination field.
3. Under **AI Automator**, choose a *Document Loader…* type, pick the **base field** (source) and
   the **output format**. For formatted-text destinations, set a **text format** so cron runs
   (anonymous) can render.

## Notes

- Requires at least one Document Loader **loader** plugin; otherwise loads throw
  `DocumentLoaderNotFoundException` and the field stays empty.
- Runs as the current user; the source file's entity `view` access is enforced by the pipeline's
  `FileInputNormalizer`.
