<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Content Suggestions (ai_content_suggestions) — agent index

Alters content entity edit forms to add LLM-powered editorial tools (summarise, suggest title,
alter tone, evaluate readability, moderate, suggest taxonomy tags) plus a per-field "AI
suggestions" button. All AI I/O goes through the **AI module** (`ai.provider`); this module holds
no credentials and makes no direct HTTP calls. Version **1.5.0**. Package `AI`.
Core `^10.4 || ^11`.

- **Dependencies:** `ai:ai` (`^1.4`), `field_widget_actions:field_widget_actions` (`^1.3`). No other libs.
- **Permission:** one — `access ai content suggestion tools` (gates all editor-facing tools).
  Settings route uses core `administer ai`.
- **Config route:** `ai_content_suggestions.settings` → `/admin/config/ai/suggestions`
  (`administer ai`), menu under *Configuration → AI*.

## What it provides (from source)

- **A plugin type** `AiContentSuggestions` (manager `AiContentSuggestionsPluginManager`, service
  `plugin.manager.ai_content_suggestions`, annotation `@AiContentSuggestions`, dir
  `src/Plugin/AiContentSuggestions`). Base class `AiContentSuggestionsPluginBase`. Six shipped
  plugins → [plugins/suggestion-plugins.md](plugins/suggestion-plugins.md):
  `summarise`, `title_suggest`, `readability`, `tone`, `taxonomy_suggest` (all `operation_type:
  chat`), `moderate` (`operation_type: moderation`).
- **A Field Widget Actions plugin** `prompt_content_suggestion`
  (`src/Plugin/FieldWidgetAction/PromptContentSuggestion.php`) — per-field, token-aware, AJAX,
  returns selectable suggestions in a modal → [plugins/field-widget-action.md](plugins/field-widget-action.md).
- **An AI function group** `content_suggestions`
  (`src/Plugin/AiFunctionGroup/ContentSuggestions.php`) — groups function-calling tools for AI agents.
- **Form-alter service** `ai_content_suggestions.form_alter` (`AiContentSuggestionsFormAlter`) —
  `hook_form_alter` entry point that injects the plugin UIs into every
  `ContentEntityFormInterface` form → [api/form-alter.md](api/form-alter.md).
- **A cache context** `ai_content_suggestions_plugins` (invalidates the altered form when the set
  of plugins changes).
- **Config**: `ai_content_suggestions.settings` (config object; schema + install defaults present).
  Two `ai.ai_prompt_type` + two `ai.ai_prompt` config entities for taxonomy prompts.

## Docs

- **Settings form, config object, schema, entity-type/bundle gating** →
  [config/settings.md](config/settings.md)
- **The six suggestion plugins, the plugin type, how a request runs** →
  [plugins/suggestion-plugins.md](plugins/suggestion-plugins.md)
- **Per-field `prompt_content_suggestion` Field Widget Action** →
  [plugins/field-widget-action.md](plugins/field-widget-action.md)
- **Form-alter service, access gating, field discovery, AJAX flow** →
  [api/form-alter.md](api/form-alter.md)

## Install

`composer require drupal/ai_content_suggestions` (pulls `drupal/ai` + `drupal/field_widget_actions`),
`drush en ai_content_suggestions`. You must configure at least one AI provider in the AI module
first, or the settings form shows only a "configure a provider" warning and no plugins are available.
