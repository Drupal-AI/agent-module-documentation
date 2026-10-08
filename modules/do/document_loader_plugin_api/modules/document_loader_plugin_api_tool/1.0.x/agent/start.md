<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Document Loader Plugin - API Tool (document_loader_plugin_api_tool) — agent index

Opt-in submodule of **document_loader_plugin_api**. Registers ONE Tool-API plugin,
`document_loader_from_api`, that lets AI agents / Tool consumers fetch an HTTP/HTTPS API endpoint and
get the response converted to a chosen format. Package `Document Loader Plugins`. Depends on
**`document_loader_plugin_api`** and **`tool:tool`**. Core `^10.3 || ^11`. License GPL-2.0-or-later.
Version 1.0.x (installed `1.0.0-alpha3`).

- **The tool: id, inputs/outputs, execution flow, access** →
  [tools/document-loader-from-api.md](tools/document-loader-from-api.md)

## What it actually is

- One plugin: `DocumentLoaderTool` (id **`document_loader_from_api`**, label *"Load Document from
  API"*), in `src/Plugin/tool/Tool/DocumentLoaderTool.php`, extending
  `Drupal\tool\Tool\ToolBase`, declared with the `#[Tool]` attribute
  (`operation: ToolOperation::Read`).
- No routes, permissions, config, services, or hooks of its own. It does not define a plugin type.
- It is a thin bridge: it calls the parent module's `document_loader:api` loader through
  `plugin.manager.document_loader`.

## Mechanism (from source)

- `create()` injects `plugin.manager.document_loader` into `$this->pluginManager`.
- `doExecute(array $values)`:
  - Reads `location`; defaults `output_format` to `markdown`.
  - Parses the URL scheme/extension; `$isUrl = scheme in ['http','https']`.
  - Proceeds only if `$isUrl` **and** (`method != GET` OR request body OR request headers OR the URL
    "looks like an API" — `/api/` path, or a `.json/.xml/.yaml/.yml/.toml` extension).
  - Calls `loadApi()` → builds `new ApiInput($url, ['method'=>..., 'headers'=>..., 'body'=>...])`
    (headers JSON-decoded; invalid JSON → `InvalidArgumentException`) → `executeLoader('document_loader:api', $input, $format)`
    → `pluginManager->createInstance('document_loader:api')->load($input, $format)`.
  - On success returns `ExecutableResult::success(...)` with `content` + `format`; failures/other
    inputs return `ExecutableResult::failure(...)`.
- **Access:** `checkAccess()` returns `AccessResult::allowedIf($account->isAuthenticated())` — any
  authenticated user.

## Inputs / outputs

- Inputs (`InputDefinition`): `location` (required), `output_format`, `http_method`, `request_body`,
  `request_headers` (all optional). Note the input help lists `html` as a format, but the underlying
  loader supports only json/yaml/markdown/text/csv/toml.
- Outputs (`ContextDefinition`): `content`, `format`.
