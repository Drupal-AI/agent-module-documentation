<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Editor Actions (ai_editor_actions) — agent index

CKEditor 5 AI text-action tooling: an "AI Actions" toolbar dropdown runs **user-defined AI
transformations** (rephrase, translate, summarize, custom "Ask AI") on the selection or whole
document, plus a read-only **"Explain this"** insight, a plain-text-field twin, an on-page
"explain any selection" widget, and optional **speech-to-text voice input**. Calls models through
the `drupal/ai` provider abstraction (chat + speech_to_text). Package **AI**. Version **1.0.x**.
Core `^10.6 || ^11.3 || ^12`. License GPL-2.0-or-later.

- **Dependencies:** `ai`, `ckeditor5`, `editor`, `filter`, `user`. No composer.json (packaged from
  drupal.org); no submodules; no Drush.
- **Configure:** action library at `entity.ai_editor_action.collection`
  (`/admin/config/ai/editor-actions`); settings at `/admin/config/ai/editor-actions/settings`.

## What it provides

- **Content entities** (`src/Entity/`): `ai_editor_action` (`EditorAction`, base_table
  `ai_editor_action`, owner-aware, fields label/instruction/provider/category/roles/status/created)
  and `ai_editor_action_category` (`EditorActionCategory`). Access via
  `EditorActionAccessControlHandler` / `EditorActionCategoryAccessControlHandler` (admin OR owner
  OR shared-role for `view`).
- **CKEditor 5 plugin** `AiEditorActions` (`src/Plugin/CKEditor5Plugin/AiEditorActions.php`,
  toolbar item `aiEditorActions`, defined in `ai_editor_actions.ckeditor5.yml`) — injects the
  current user's catalog into the editor.
- **Controller endpoints** (`src/Controller/TransformController.php`, all under
  `/ai-editor-actions/…`): `transform`, `explain`, `transcribe` (POST, CSRF header + permission +
  flood), `catalog` (GET), and a `dialog/add-action` entity-create form. See
  [api/endpoints.md](api/endpoints.md).
- **Services** (`ai_editor_actions.services.yml`): `Service\TextTransformer`
  (implements `TextTransformerInterface`; chat + speech-to-text via `ai.provider`),
  `ActionCatalog` (builds the per-user catalog), `Service\ExplanationNormalizer`
  (structured-output → HTML), plus OOP hook classes in `src/Hook/`.
- **Config** object `ai_editor_actions.settings` (schema in `config/schema/`, install defaults in
  `config/install/`). See [config/settings.md](config/settings.md).
- **Permissions** (`ai_editor_actions.permissions.yml`): `use ai editor actions`,
  `use ai plain text actions`, `use ai explain selection`, `create ai editor actions`,
  `create shared ai editor actions`, `administer ai editor actions` (restricted).
- **Alter hooks** (`ai_editor_actions.api.php`):
  `hook_ai_editor_actions_explanation_blocks_alter`, `…_schema_alter`,
  `…_explanation_allowed_tags_alter`.

## Solution docs

- [config/settings.md](config/settings.md) — the settings object, keys, prompts, models, limits.
- [api/endpoints.md](api/endpoints.md) — routes, permissions, request/response shapes, guards.
- [entities/actions.md](entities/actions.md) — the two entity types, fields, access, defaults.
