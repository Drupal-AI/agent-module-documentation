# Hooks, route subscriber & update path

Hooks use the OOP `#[Hook]` attribute (no `.module` file); the classes are registered as services in
`flowdrop_ai_provider.services.yml`.

## `Hook\AiProviderHooks` (args: `operation_availability`, `extension.path.resolver`)

- **`hook_library_info_alter`** — when `flowdrop_ui_components` defines its `flowdrop` library, appends a
  dependency on `flowdrop_ai_provider/ai-prompt-field` (the Svelte AI-prompt / guardrail-set field
  widgets). Done via library alter, not page attachments, because the FlowDrop editor/playground render
  through `BareHtmlPageRenderer`, which skips page-attachment hooks.
- **`hook_form_flowdrop_node_type_add_form_alter`** and **`…_edit_form_alter`** — both call
  `attachProviderWarning()`: if the node type's operation type has **no configured provider**, it replaces
  the whole form with a warning (`#access = FALSE` on every non-`form_*` child) listing compatible
  provider modules pulled from `ai`'s `resources/ai.provider_registry.yml`.

## `Hook\EntityHooks` (arg: `ai_prompt_resolver`)

- **`hook_entity_presave`** — for an `ai_agent` entity whose `system_prompt` field holds an
  `ai_prompt:<id>` reference, resolves it to the prompt text before save (leaves the value unchanged if
  resolution throws).

## Route subscriber — `Routing\AiSettingsRouteSubscriber`

`alterRoutes()` widens the `ai.settings.menu` route's `_permission` from the AI module's single
`administer ai` to `<current>+manage ai prompts` (Drupal `+` = OR), so a user with only
`manage ai prompts` can reach the AI settings overview and its child links. Idempotent (skips if
`manage ai prompts` is already present).

## Install / update (`flowdrop_ai_provider.install`)

No `hook_install`/`hook_schema` (config-only). Seven update hooks migrate node-type config and the
workflows that reference them across the module's beta history — pure data migrations, safe to run on
`drush updatedb`:

- `_10001` — rename node type `flowdrop_ai_provider_chat_model` → `…_chat` (+ fix workflow node/edge refs).
- `_10002` — move 8 bare-id node types to module-prefixed ids, namespace `executor_plugin`, drop obsolete
  `color`/`version`/`config` keys, add `plugin_version`/`parameters`.
- `_10003` — move all node types from the `model` category to `ai`.
- `_10004` — set the authoritative `parameters` + `outputs` map on every AI node type.
- `_10005` — import the `session_history` node type (shipped after initial install).
- `_10006` — re-sync each site node type's `parameters`/`outputs` with the shipped YAML (adds new keys,
  prunes removed ones, keeps per-site flag tweaks).
- `_10007` — repoint workflow edges to renamed output ports (e.g. `audio`→`audio_files`, `video`→
  `video_files`, `image`→`images`, `results`→`information`); these ports now carry a list of file arrays.
