<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugins — Prompts and completion providers

Prompts are reusable, parameterised message templates exposed to MCP clients. They are **config
entities** (`mcp_prompt_config`), not plugins; argument autocomplete is supplied by
`PromptArgumentCompletionProvider` plugins.

## The `mcp_prompt_config` entity

- `McpPromptConfig` (`src/Entity/McpPromptConfig.php`), `config_prefix: mcp_prompt_config`. No
  `admin_permission` on the entity; CRUD routes in `mcp_server_ui` require
  `administer mcp prompt configurations`.
- config_export keys (schema `mcp_server.mcp_prompt_config.*`): `id`, `label`, `title?`,
  `description?`, `arguments`, `messages`, `status`.
- `arguments[]`: `label`, `machine_name` (required), `description` (required), `required` (bool),
  `completion_providers[]` (`plugin_id` + typed `configuration`).
- `messages[]`: `role` (`user`|`assistant`) + `content[]` polymorphic items
  (`mcp_server.message_content_item`): `type` (`text`|`image`|`audio`|`resource`), `text?`,
  `data?` (base64), `mimeType?`, `resource?` (`uri`, `mimeType?`, `text?`).
- Getters: `getTitle()`, `getDescription()`, `getArguments()`, `getMessages()`,
  `getArgumentCompletionProviders(string $argument_name)`. `preSave`/`postDelete` invalidate
  `mcp_server:discovery`.

## Registration — PromptConfigLoader

`McpServerFactory::registerPrompts()` adds a **`PromptConfigLoader`** (SDK `LoaderInterface`) to the
builder. On `load()` it fetches all `mcp_prompt_config` entities with `status = TRUE`
(`loadByProperties(['status' => TRUE])`) and for each calls `registerPrompt()`:

- builds an SDK `Prompt` (`name` = entity id, `description`, `arguments` mapped to `PromptArgument`
  objects, `meta.title` when a title is set);
- the message handler returns `getMessages()`;
- `buildCompletionProviders()` wires each argument's configured completion providers (a single
  `PluginProviderAdapter`, or a `ChainedCompletionProvider` when several are configured).

## Completion provider plugin type

- Manager `plugin.manager.mcp_server.prompt_argument_completion_provider`
  (`PromptArgumentCompletionProviderManager`); dir `Plugin/PromptArgumentCompletionProvider`;
  attribute `#[PromptArgumentCompletionProvider]` (`id`, `label`, `description`); interface
  `PromptArgumentCompletionProviderInterface` (also `ConfigurableInterface` + `PluginFormInterface`);
  alter `mcp_server_prompt_argument_completion_provider`.
- Key method: `getCompletions(string $current_value, array $configuration): array`.
- Adapters: `PluginProviderAdapter` bridges a Drupal provider plugin to the SDK provider interface;
  `ChainedCompletionProvider` concatenates several providers' completions for one argument.

### Bundled examples (mcp_server_examples)

- `entity_query` (`EntityQueryCompletionProvider`) — queries a configured `entity_type`/`bundle`,
  returns absolute canonical URLs; applies `accessCheck(TRUE)` and a `$entity->access('view')`
  post-filter; limited to 10.
- `static_list` (`StaticListCompletionProvider`) — prefix-matches against a configured static list.

## Notifications (contract-only)

The fourth plugin type, `plugin.manager.mcp_server.notification` (`NotificationProviderManager`, dir
`Plugin/Notification`, `#[Notification]`, interface `NotificationProviderInterface` with
`getNotifications(): iterable`), is a Phase-1 stub: the base returns `[]` and no providers ship in
core.
