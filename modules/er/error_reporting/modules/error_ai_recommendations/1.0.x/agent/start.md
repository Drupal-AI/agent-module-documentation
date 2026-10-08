<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Error Reporting: AI-Powered Recommendations (error_ai_recommendations) — agent index

Submodule of **error_reporting**. Adds a "Suggest AI Fix" button to the enhanced error page that
sends the failing frame + error message to an AI provider (via **drupal/ai**) and shows the
returned fix. Package `Tools and Utilities`. Core `^10 || ^11`. License GPL-2.0-or-later.
Version 1.0.3.

Dependencies (`error_ai_recommendations.info.yml`): `error_reporting:error_reporting`, `ai:ai`.

- **The AI endpoint, controller and provider call** → [api/ai-suggestion.md](api/ai-suggestion.md)
- **The settings-form alter (provider selector)** → [config/provider.md](config/provider.md)

## What it actually is

- One route `error_ai_recommendations.response` → `POST /ai-suggestion/response`, controller
  `AiSuggestionController` (`src/Controller/AiSuggestionController.php`, invokable `__invoke`).
- `__invoke(Request)`: reads the raw JSON body (`code.content`, `code.file`, `code.line`,
  `error_msg`), then `getAiResponse()` resolves the default chat provider via the `ai.provider`
  service (`getDefaultProviderForOperationType('chat')` + `createInstance`), builds a `ChatInput`
  (a `system` "Drupal pro developer" message and a `user` message with the error/line/file/code),
  calls `$provider->chat(...)`, and returns the normalized text as JSON `{response: ...}`.
- `error_ai_recommendations.module`:
  - `hook_form_alter` on `error_reporting_config_form` adds a "Select AI Provider" select (options
    from usable chat providers) and a submit handler that saves the choice to
    `error_reporting.settings:provider`.
  - Helper `error_ai_recommendations_provider_options()` lists providers whose
    `isUsable('chat')` is true.
- No AI keys handled here — credentials belong entirely to the `drupal/ai` provider/module. No
  config schema, no permissions, no plugins, no Drush shipped by this submodule.
- The parent template's `fixErrorWithAI()` JS is what calls the endpoint (see the parent module's
  `templates/custom-error-display.html.twig`).

## Provides

- Routes: 1 (`/ai-suggestion/response`). Controllers: 1. Hooks: `hook_form_alter` (+ submit).
  Config: writes the `provider` key into the parent's `error_reporting.settings`.
