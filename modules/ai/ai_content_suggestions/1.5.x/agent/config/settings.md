<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, config object & schema

## Route / form / permission

- Route `ai_content_suggestions.settings` → `/admin/config/ai/suggestions`, form
  `Drupal\ai_content_suggestions\Form\SettingsForm`, requirement `_permission: 'administer ai'`
  (core AI permission, NOT a module permission). Menu link `ai_content_suggestions.settings` under
  `ai.admin_config_content` (Configuration → AI).
- The one module permission, `access ai content suggestion tools`
  (`ai_content_suggestions.permissions.yml`), gates the editor-facing tools, not this form.

## `SettingsForm` (`src/Form/SettingsForm.php`)

`ConfigFormBase`, form id `ai_content_suggestions_settings`, editable config
`ai_content_suggestions.settings`. `buildForm()` builds three detail groups:

1. **Settings for plugins** (`plugins`, `#tree`): iterates
   `plugin.manager.ai_content_suggestions` definitions, instantiates each with its stored config,
   and includes only plugins whose `isAvailable()` is TRUE (base impl: at least one model exists
   for the plugin's operation type). If none are available it renders a warning linking to
   `ai.admin_providers`. Each available plugin's `buildConfigurationForm()` is embedded via a
   `SubformState`. Legacy string-valued plugin config (`model` only) is normalised to
   `['model' => …, 'enabled' => TRUE]`.
2. **Settings for per field suggestions** (`field_settings`): a `field_widget_prompt` textarea —
   the shared **system prompt** used by the field-widget action (see field-widget-action.md).
3. **Configure … for different entity types** (`entity_type_settings`): a `vertical_tabs` tab per
   `ContentEntityTypeInterface`, each with a `mode` radio (`enable` = "Only those selected",
   `disable` = "All except those selected") and a `bundles` checkboxes set.

`submitForm()` re-instantiates each available plugin, calls `submitConfigurationForm()` through a
`SubformState`, and writes `plugins`, `field_widget_prompt`, and `entity_types` back to config.
Entity-type entries with `mode = enable` and no bundles are dropped. Cache contexts
`ai_content_suggestions_plugins` and `ai_providers` are added so the form rebuilds when plugins or
providers change. Attaches library `ai_content_suggestions/settings.admin`.

## Config object `ai_content_suggestions.settings`

Schema `config/schema/ai_content_suggestions.schema.yml` (`config_object`); install defaults
`config/install/ai_content_suggestions.settings.yml`:

- `field_widget_prompt` (text) — system prompt instructing the LLM to return RFC8259 JSON of
  `{"suggestion": …}` objects (default shipped in install file; historic markdown/`<span>` variant
  set by `update_10001`, replaced by `update_10005`).
- `plugins` (sequence keyed by plugin id) — each value typed by
  `ai_content_suggestions.plugin_config.[%key]`. Base mapping = `enabled` (bool) + `model`
  (string). Per-plugin extensions: `summarise`/`readability`/`title_suggest`/`tone` add `prompt`
  (text); `tone` also adds `taxonomy` (string vid) + `taxonomy_enabled` (bool); `taxonomy_suggest`
  uses `prompt_open` + `prompt_from_voc` (each a string that must reference an existing
  `ai.ai_prompt` — `ConfigExists` constraint).
- `entity_types` (sequence keyed by content entity type id, `PluginExists` against
  `entity_type.manager`) — each = `bundles` (sequence of bundle machine names, `EntityBundleExists`)
  + `mode` (`enable`|`disable`). Install default lists `node`, `taxonomy_term`, `block_content`
  each with empty bundles and `mode: disable` (⇒ enabled for all bundles of those types until you
  narrow it). Added by `update_14001`.
- Schema also defines `field_widget_action.plugin.prompt_content_suggestion` (settings: `model`,
  `prompt`, `display_on_focus`) for the Field Widget Action plugin.

## Prompt config entities (`config/install/`)

- `ai.ai_prompt_type.suggest_tags`, `ai.ai_prompt_type.suggest_vocabulary` — prompt types (from
  the AI module) for the taxonomy plugin.
- `ai.ai_prompt.suggest_tags__suggest_tags_default`,
  `ai.ai_prompt.suggest_vocabulary__suggest_vocabulary_default` — default prompts referenced by the
  `taxonomy_suggest` plugin's `prompt_open` / `prompt_from_voc`.

## Update / post-update history (context)

`.install`: `10001`/`10005` set the field-widget system prompt; `10002` installs
`field_widget_actions`; `10003`/`10004` migrate legacy string prompts into `ai.ai_prompt` entities;
`14001` seeds `entity_types`. `.post_update.php`: `post_update_10001` migrates former
`third_party_settings[ai_content_suggestions]` on form displays to a
`field_widget_actions` `prompt_content_suggestion` action; `post_update_15001` moves per-plugin
config (model/prompt/tone-taxonomy) out of the retired `ai_content_suggestions.prompts` and
`.tone` config objects into `settings.plugins` and deletes the old objects.
