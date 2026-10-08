<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Widget Action: `prompt_content_suggestion`

`src/Plugin/FieldWidgetAction/PromptContentSuggestion.php` — extends
`Drupal\field_widget_actions\FieldWidgetActionBase`, declared with the
`#[FieldWidgetAction(...)]` attribute:

- `id: 'prompt_content_suggestion'`, category "AI Content Suggestions".
- `widget_types`: `string_textfield`, `string_textarea`, `text_textarea`,
  `text_textarea_with_summary`, `text_textfield`.
- `field_types`: `string`, `string_long`, `text`, `text_long`, `text_with_summary`.

This lets a site builder attach a per-field "AI suggestions" button to any of those widgets under
**Manage form display** (the button/action is configured through Field Widget Actions'
third-party settings; `post_update_10001` migrated legacy `ai_content_suggestions` third-party
settings into this plugin).

## Config (`defaultConfiguration` → `settings`)

`model` (''), `prompt` (''), `display_on_focus` (FALSE). `buildConfigurationForm()` adds:

- **model** select — options from `ai.provider->getSimpleProviderModelOptions('chat', FALSE)`,
  empty option "- Use default model for chat operation -"; description shows the current default
  chat provider/model and links to `ai.settings_form`.
- **prompt** textarea — supports entity **tokens** (`[node:field_name]` etc.) when the `token`
  module is present; renders a `token_tree_link`.
- **display_on_focus** checkbox — hide buttons until the field is focused (the form is warned this
  hurts accessibility).

Schema: `field_widget_action.plugin.prompt_content_suggestion` (see config/settings.md).

## Access

`isAvailable()` returns `currentUser->hasPermission('access ai content suggestion tools')` — the
same permission that gates the on-form plugins. Users without it never see the button.

## Runtime (`aiContentSuggestionsAjax`)

`getAjaxCallback()` → `aiContentSuggestionsAjax`; libraries `ai_content_suggestions/field_widget`.
On click:

1. Reads model + prompt from the triggering element's `#field_widget_action_settings`.
2. Resolves provider via `ai.provider->getSetProvider('chat', $model)`.
3. Builds the current entity from the form (`buildEntity()`); marks new entities `in_preview`.
4. Scans the prompt for tokens. If **no** entity-type token is present, it replaces non-entity
   tokens, renders the entity in view mode via `EntityViewBuilder`/`renderInIsolation()`, converts
   the HTML to markdown (`League\HTMLToMarkdown\HtmlConverter`, provided transitively by the AI
   module) and appends it to the prompt. If an entity token **is** present, it does a full token
   replace with the entity and converts that.
5. Calls `$provider->chat($messages, $model_id, ['field_widget_action','ai_content_suggestions'])`
   with the site's `field_widget_prompt` config value as the **system prompt** (that prompt asks the
   model for an RFC8259 JSON array of `{"suggestion": …}`).
6. Decodes the response with `ai.prompt_json_decode` (`PromptJsonDecoderInterface`); if it decodes
   to an array, pulls the `suggestion` column. Non-JSON responses yield no suggestions (so the base
   class shows its default "no suggestions" message rather than raw model output). Exceptions are
   logged to `logger.channel.field_widget_actions`.
7. Returns `returnSuggestions($suggestions, $selector)` — the base class opens a modal dialog
   (`OpenModalDialogCommand`) themed by `field_widget_actions_suggestions` (Twig-escaped) and a
   `SettingsCommand` pointing at the target field selector so the editor can insert a chosen
   suggestion.

## AI function group

`src/Plugin/AiFunctionGroup/ContentSuggestions.php` registers the `content_suggestions`
`#[FunctionGroup]` (from the AI module) — an empty grouping class that lets AI agents surface
this module's function-calling tools under a "Content Suggestions" group.
