<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — settings entities, routes, permission

## Install & enable

```bash
composer require drupal/ai_translate_plus
drush en ai_translate_plus -y
```

Requires `ai` and `ai_translate` (Drupal AI). Core `^11`.

## Permission

`ai_translate_plus.permissions.yml` defines one permission: **`manage ai translate plus prompts`**
(`restrict access: true`) — gates the overview form. The per-entity-type form and the translate
route reuse core/AI permissions instead (see routes).

## Routes (`ai_translate_plus.routing.yml`)

- **`ai_translate_plus.settings_form`** → `/admin/config/ai/ai-translate-plus`, form
  `AiTranslatePlusOverviewForm`, `_permission: manage ai translate plus prompts`, `_admin_route`.
- **`ai_translate_plus.settings.entity_type`** →
  `/admin/config/ai/ai-translate-plus/{entity_type_id}` (`entity_type_id: [a-zA-Z_]+`), form
  `AiTranslatePlusSettingsForm`, `_permission: administer site configuration`.
- **`ai_translate.translate_content`** (overrides AI Translate's route) →
  `/admin/content/{entity_type}/{entity_id}/translate/{lang_from}/{lang_to}`, controller
  `\Drupal\ai_translate_plus\Controller\AiTranslateController::translate`,
  `_permission: administer ai translate`.

Local tasks (`ai_translate_plus.links.task.yml`) add "Default Settings" and "Plus Settings" tabs
under `ai_translate.settings_form`.

## Config entity `ai_translate_plus_settings`

`src/Entity/AiTranslatePlusSettings.php` — a `ConfigEntityBase` (`config_prefix =
entity_type_settings`, id = entity type machine name). `preSave()` fills the label from the entity
type definition when empty. Exported properties (with getters/setters):

| Property | Shape | Meaning |
|---|---|---|
| `entity_type` | string | Entity type machine name. |
| `entity_type_default_prompt` | string (AiPrompt id) | Default prompt for all languages. |
| `entity_type_prompts` | `{langcode: prompt_id}` | Per-language prompt for the entity type. |
| `entity_type_default_model` | string | Default provider/model for all languages. |
| `entity_type_models` | `{langcode: model}` | Per-language model for the entity type. |
| `bundle_default_prompts` | `{bundle: prompt_id}` | Bundle default prompt (all languages). |
| `bundle_prompts` | `{bundle: {langcode: prompt_id}}` | Per-bundle, per-language prompt. |
| `bundle_default_models` | `{bundle: model}` | Bundle default model (all languages). |
| `bundle_models` | `{bundle: {langcode: model}}` | Per-bundle, per-language model. |
| `disabled_fields` | `{bundle: [field_name, ...]}` | Fields excluded from extraction/translation. |

Prompt-id values are validated by schema constraint `ConfigExists` with prefix `ai.ai_prompt.`
(they must reference existing `ai` prompt entities).

> Note: the config **entity** exports `disabled_fields`, while
> `config/schema/ai_translate_plus.schema.yml` names the mapping `bundle_disabled_fields`; the
> getter/setter used by the code is `getDisabledFields()` / `setDisabledFields()`.

## Forms

- **`AiTranslatePlusOverviewForm`** (`src/Form/AiTranslatePlusOverviewForm.php`, `FormBase`) — lists
  all content entity types that are translatable and have a bundle entity type, each linking to the
  per-entity-type form. No submit handling.
- **`AiTranslatePlusSettingsForm`** (`src/Form/AiTranslatePlusSettingsForm.php`) — edits one
  `ai_translate_plus_settings` entity: per-language and per-bundle prompt/model selection and
  disabled-field checkboxes. Uses `PromptTokenHelpTrait` to show example tokens for the entity type.

## How resolution works at translate time

The `chat_translation_plus` provider resolves prompt and model **most-specific-first**:
`bundle + language` → `bundle default` → `entity-type + language` → `entity-type default` → AI
Translate's own `<langcode>_prompt` / `prompt`. See [../plugins/provider.md](../plugins/provider.md).
