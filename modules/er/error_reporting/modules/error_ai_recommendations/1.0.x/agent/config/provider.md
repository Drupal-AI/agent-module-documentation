<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Provider selection (settings-form alter) — error_ai_recommendations

This submodule has no settings form of its own. It alters the parent Error Reporting form.

## `hook_form_alter` (`error_ai_recommendations.module`)

- `error_ai_recommendations_form_alter()` acts only on form id `error_reporting_config_form`.
- Adds `$form['provider']`: a `select` titled "Select AI Provider".
  - Options: `['' => 'Select AI Provider'] + error_ai_recommendations_provider_options('chat')`.
  - Default value: `config('error_reporting.settings')->get('provider')` or the ai module's
    default chat provider (`getDefaultProviderForOperationType('chat')['provider_id']`) or `''`.
- Appends `error_ai_recommendations_form_submit` to `$form['#submit']`.

## Helper `error_ai_recommendations_provider_options($operation_type)`

- Iterates `ai.provider` service `getDefinitions()`, instantiates each, and includes those whose
  `isUsable($operation_type)` is TRUE (operation type `chat`). Returns `[id => label]`.

## Submit `error_ai_recommendations_form_submit()`

- Saves the selected provider into the parent config:
  `config.factory->getEditable('error_reporting.settings')->set('provider', <value>)->save()`.

## Config key

- `error_reporting.settings:provider` (string) — written here but **not** covered by the base
  module's `config/schema/error_reporting.schema.yml`; this submodule ships no schema file of its
  own. `AiSuggestionController` does not read this key — it resolves the provider from the ai
  module's default for the `chat` operation type. The stored `provider` value therefore currently
  drives only the form default, not the controller's provider choice.
