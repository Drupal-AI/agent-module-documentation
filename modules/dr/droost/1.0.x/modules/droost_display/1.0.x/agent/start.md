<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Droost Display (droost_display) — agent index

SDC-first entity-display orchestration for AI agents, over MCP. Depends on `droost`, `ui_patterns`,
`ui_patterns_field_formatters`. Version **1.0.0-rc1** (dir 1.0.x). Core `^10.3 || ^11 || ^12`.
**Local development only.**

## What it provides
- **3 MCP tools** (`{success, message, data}` envelope, gated by mcp_server `access mcp server`):
  - `droost_display_sources` — read-only; the UI Patterns source vocabulary, filtered like the UI.
  - `droost_display_get` — read-only; an entity view display as an abstract component mapping.
  - `droost_display_compose` — **destructive** (config write); compose a display from SDCs.
  See [tools/display-tools.md](tools/display-tools.md).
- **1 service**: `droost_display.context_builder` (`DisplayContextBuilder`).
- **No permissions, no routes, no config, no Drush.**
- **`hook_requirements`** (`droost_display.install`): warns when Drupal Canvas is installed (both take over
  `plugin.manager.sdc`; apply the coexistence patch, see README).

## Mechanism (source)
- `DisplaySources` uses `SourcePluginManager` + `PropTypePluginManager`; with a field context it filters sources
  exactly as the Manage Display form does.
- `DisplayGet` reads `EntityViewDisplay` components and unwraps `ui_patterns_component[_per_item]` bindings via
  `normalizeComponent()` into `{component_id, variant, props, slots}`.
- `DisplayCompose` (extends `DestructiveToolBase`) validates all items (`validateItem()`), then `setComponent()` /
  `removeComponent()` and `save()`. Gated by `requireCliTransport()` + `gate('allow_config_write')`; `dry_run` skips both.
- `DisplayContextBuilder::forField()` mirrors ui_patterns_field_formatters' contexts and builds a sample entity via
  `createWithSampleValues()` (no tempstore write) so read/validate paths write nothing.

## Docs
- The three tools, gating, and the compose payload → [tools/display-tools.md](tools/display-tools.md).
