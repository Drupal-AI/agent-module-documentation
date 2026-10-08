<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Workspace — install & configuration

## Install / enable
`composer require drupal/ai_workspace` then enable `ai_workspace` (pulls core `user`, `system`, `ai`).
Requires at least one chat-capable provider configured in the AI module; `ai_workspace_requirements()`
(`ai_workspace.install`) emits a runtime WARNING (via `ai.provider`->`hasProvidersForOperationType('chat')`)
if none is configured, linking to `/admin/config/ai/providers`. Entity schemas are auto-managed by the
entity system — no manual table install. When installing from git, the compiled React bundle
(`js/dist/ai_workspace.js|.css`) must be built with `bash build_js.sh`; official releases include it.

## Config object `ai_workspace.settings`
Default values in `config/install/ai_workspace.settings.yml`; typed in `config/schema/ai_workspace.schema.yml`.

| Key | Type | Default | Effect |
|---|---|---|---|
| `default_model_key` | string | `''` | Composite `provider_id__model_id` for new threads; empty = AI module global default. |
| `allowed_providers` | sequence<string> | `[]` | Allow-list of provider ids; empty = all configured providers. |
| `system_prompt` | text | Copilot default (permits `<i><b><ul><li><h2><h3><code><pre>` in replies) | Prepended to every conversation (`ChatService::resolveSystemPrompt()`). |
| `starter_suggestions` | text | 2 lines | `title|subtitle` per line; parsed in `WorkspaceController::page()`, shown on empty state. |
| `max_threads_per_user` | integer | `0` | `0` = unlimited (config key present; **not enforced** in this release's code). |
| `tools_enabled` | boolean | `false` | Master toggle for tool calling (scaffold only; no tools ship). |
| `enable_logging` | boolean | `true` | Intended audit toggle (services log unconditionally regardless). |
| `workspace_path` | string | `/ai_workspace` | Page URL path; applied by `RouteSubscriber`. |
| `workspace_name` / `welcome_title` / `welcome_subtitle` | string | branding strings | Injected into `drupalSettings.aiWorkspace`. |

## Settings form
`Form\SettingsForm` (`getFormId()` `ai_workspace_settings`), route `ai_workspace.settings` at
`/admin/ai/workspace`, permission `administer ai workspace`, menu under AI (`ai.admin_settings`).
Sections: Appearance, Model Configuration (default model select + provider checkboxes, options built
from `ModelAdapter::getAvailableModels()`), Conversation (system prompt, starter suggestions, thread
cap), Tool Calling, Audit & Logging. `submitForm()` normalises `workspace_path` (single leading slash,
no trailing slash) and calls `router.builder`->`rebuild()` only when the path changed.

## Configurable page path
`EventSubscriber\RouteSubscriber::alterRoutes()` rewrites the `ai_workspace.page` route path from
`workspace_path` on every route rebuild (normalised the same way). Changing the path needs a router
rebuild (`drush cr` or the auto-rebuild on save).

## Bootstrap to the front-end
`WorkspaceController::page()` returns theme `ai_workspace_page` (template `templates/ai-workspace-page`;
`hook_theme_suggestions_page_alter` adds a `page__workspace` suggestion on the workspace path) and
attaches libraries `ai_workspace/workspace_init` + `workspace_page`. It injects `drupalSettings.aiWorkspace`:
`apiBase` `/api/ai-workspace`, `csrfTokenUrl` `/session/token`, `defaultModelKey`, `currentUserId`,
`hasProviders`, `starterSuggestions`, and the branding strings. Cache: context `user`, tag
`config:ai_workspace.settings`.
