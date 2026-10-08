<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `mcp` plugin type & the built-in plugins

Discovery: attribute plugins in `src/Plugin/Mcp/` of any module. Manager `plugin.manager.mcp`
(`McpPluginManager`), interface `McpInterface`, base `McpPluginBase`, attribute `Drupal\mcp\Attribute\Mcp`
(`id`, `name`, `description`). Alter hook `hook_mcp_info_alter`. Cache bin `mcp_plugins`.
Scaffold one with `drush generate mcp:plugin` (aka `drush generate mcp`).

## Define a plugin
```php
namespace Drupal\my_module\Plugin\Mcp;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\mcp\Attribute\Mcp;
use Drupal\mcp\Plugin\McpPluginBase;
use Drupal\mcp\ServerFeatures\Tool;

#[Mcp(
  id: 'my-feature',
  name: new TranslatableMarkup('My Feature'),
  description: new TranslatableMarkup('Does something for MCP clients.'),
)]
final class MyFeature extends McpPluginBase {
  public function getTools(): array {
    return [new Tool(
      name: 'do-thing',
      description: 'Does the thing.',
      inputSchema: ['type' => 'object', 'properties' => new \stdClass()],
    )];
  }
  public function executeTool(string $toolId, mixed $arguments): array {
    // $toolId is the SANITIZED tool name (lowercased, non-alnum -> '_').
    return $toolId === 'do_thing' ? [['type' => 'text', 'text' => 'result']] : [];
  }
}
```
Inject services with a `create()` override (base `McpPluginBase::create()` already wires `current_user`).

> **Plugin id rule (footgun):** id must match `^[a-zA-Z0-9-]+$` (letters/numbers/hyphens —
> `getAvailablePlugins()` throws otherwise) and, per the `Mcp` attribute docs, must equal the plugin *group*
> or be prefixed `group:bar`. Tool ids are `pluginId_toolName` split on the **first** underscore in
> `tools/call`, so **use hyphens in the plugin id** (built-ins use `general`, `content`, `jsonapi`, `aif`,
> `aia`, `tools`, `drush`). `executeTool()` receives the *sanitized* tool name.

## Methods to override (`McpPluginBase` defaults)
- `checkRequirements(): bool` / `getRequirementsDescription(): string` — gate on optional deps.
- `defaultConfiguration(): array` — base is `['enabled'=>TRUE,'roles'=>['authenticated'],'config'=>[],'tools'=>[]]`.
- `getTools()` / `executeTool(string $toolId, mixed $arguments)` — the tool set + its execution. A result may be
  a plain list of content items, or `['content'=>[…], 'structuredContent'=>…, 'isError'=>…]`.
- `getResources()` / `readResource(string $resourceId)` / `getResourceTemplates()` — readable resources.
- `buildConfigurationForm` / `validate…` / `submitConfigurationForm` — the per-plugin subform.
- Access (usually inherit): `hasAccess()`, `getAllowedRoles()`, `isToolEnabled()`, `getToolAllowedRoles()`,
  `hasToolAccess()`; `isEnabled()` is `final`. `getToolsWithCustomization()` applies admin-set descriptions.
- Helpers: `sanitizeToolName()`, `generateToolId()` (namespaces + caps id length at 64).

## Value objects (`src/ServerFeatures/`)
- `Tool(name, description, inputSchema, ?title, ?outputSchema, ?annotations)` — `inputSchema`/`outputSchema`
  are JSON-schema arrays; `annotations` is a `ToolAnnotations(title, readOnlyHint, idempotentHint,
  destructiveHint, openWorldHint)` — advisory client hints only.
- `Resource(uri, ?name, ?description, ?mimeType, ?text)`; `ResourceTemplate(uriTemplate, name, ?description, ?mimeType)`.

## Built-in plugins (all in the main module now — `mcp_ai`/`mcp_content`/`mcp_extra`/`mcp_tool` are gone)
| id | Class | Tools / resources | Requires | Default |
|---|---|---|---|---|
| `general` | `General` | tools `info` (site name/slogan/`\Drupal::VERSION`), `status` (modules needing updates) | — | **enabled** |
| `content` | `Content` | nodes of opt-in content types as resources (`node/{type}`, `node/{type}/{id}`) + `search-content` tool (field filters, operators, sort; `accessCheck(TRUE)`) | `node` | enabled, no types selected |
| `jsonapi` | `JsonApi` | `jsonapi_read` (filters/include/sparse-fields/page/sort via internal JSON:API sub-request) + `jsonapi_schema` (if jsonapi_schema module) | `jsonapi` | disabled; also requires `access content` |
| `aif` | `AiFunctionCalling` | every Drupal AI function-call as a tool | `drupal/ai` | disabled |
| `aia` | `AiAgentCalling` | each AI agent capability as a `{agent}__{capability}` tool taking a `prompt` | `drupal/ai_agents` + AI provider | disabled |
| `tools` | `ToolApi` | every Tool API tool (input/output schemas; entity args passed as `{{entity:*}}` artifact tokens) | `drupal/tool` | disabled |
| `drush` | `DrushCaller` | one tool per non-hidden Drush command; only allow-listed commands run (`escapeshellarg`, array `Process`, `--yes --no-interaction`) | `drush` CLI | **disabled**, all commands off — dev only |

## Submodule `mcp_studio` — plugin id `studio` (`Studio`)
No-code tools defined in `mcp_studio.settings:tools` (name, description, input schema, output). Output is a
static string or, when `output_mode = twig`, a Twig template rendered with the call arguments as context.
Managed at `/admin/config/mcp/studio`. Disabled by default.
