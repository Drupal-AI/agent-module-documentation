<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `mcp` plugin type

Discovery: attribute-based plugins in `src/Plugin/Mcp/` (any module). Manager `plugin.manager.mcp`
(`McpPluginManager`), interface `McpInterface`, base class `McpPluginBase`, attribute
`Drupal\mcp\Attribute\Mcp`. Alter hook `hook_mcp_info_alter`. Cache bin `mcp_plugins`.

## Define a plugin
```php
namespace Drupal\my_module\Plugin\Mcp;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\mcp\Attribute\Mcp;
use Drupal\mcp\McpPluginBase;
use Drupal\mcp\ServerFeatures\Tool;

#[Mcp(
  id: 'my_feature',
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
    if ($toolId === 'do-thing') {
      return [['type' => 'text', 'text' => 'result']];
    }
    return [];
  }
}
```
Use `ContainerFactoryPluginInterface` + a `create()` method to inject services (see core `General`,
`mcp_content` `Content`, `mcp_ai` `AiFunctionCalling`).

> **Plugin id rule (has a footgun):** the id must match `^[a-zA-Z0-9-]+$` (letters, numbers, hyphens —
> `getAvailablePlugins()` throws otherwise) and, per the `Mcp` attribute docs, must equal the plugin
> *group* or be prefixed `group:bar`. Also: tool names are namespaced as `pluginId_toolName` and split
> back on the **first** underscore in `executeTool()`, so an underscore in the plugin id breaks
> tool routing — prefer hyphens (e.g. `ai-function-calling`).

## Methods you can override (`McpPluginBase` defaults return empty / TRUE)
- `checkRequirements(): bool` — gate on dependencies (e.g. a module or service being present).
- `defaultConfiguration(): array` — defaults; base provides `['enabled' => TRUE, 'config' => []]`.
- `buildConfigurationForm/validateConfigurationForm/submitConfigurationForm` — per-plugin subform on
  `/admin/config/mcp` (nested under `config`).
- `getTools(): Tool[]` / `executeTool(string $toolId, mixed $arguments): array` — the tool set and its
  execution. Each result item is `['type' => 'text'|'image'|'resource', ...]`.
- `getResources(): Resource[]` / `readResource(string $resourceId): Resource[]` — readable resources.
- `getResourceTemplates(): ResourceTemplate[]` — URI templates (e.g. `node/{type}/{id}`).
- `isEnabled(): bool` — final; reads `configuration['enabled']`.

## Value objects (`src/ServerFeatures/`)
- `Tool(string $name, string $description, mixed $inputSchema)` — `inputSchema` is a JSON-schema array.
- `Resource(string $uri, ?string $name, ?string $description, ?string $mimeType, ?string $text)`.
- `ResourceTemplate(string $uriTemplate, string $name, ?string $description, ?string $mimeType)`.

`McpService` prefixes tool names with `pluginId_` and resource/template URIs with `pluginId://`
before returning them to clients, and validates result `type` values.
