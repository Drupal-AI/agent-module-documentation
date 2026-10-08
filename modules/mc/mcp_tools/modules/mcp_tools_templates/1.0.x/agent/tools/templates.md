<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools - Templates — Site-template tools

Submodule `mcp_tools_templates`. All plugins live in `src/Plugin/tool/Tool/` and extend `Drupal\mcp_tools\Tool\McpToolsToolBase`. Permission for every tool: `mcp_tools use templates`. `operation` sets the required MCP scope (Read->read, Write->write, Trigger->admin); `destructive` tools require explicit client confirmation.

| Tool id | Class | Operation | Notes |
| --- | --- | --- | --- |
| `mcp_templates_list` | ListTemplates | Read | List built-in templates (blog, portfolio, business, documentation). -> TemplateService::listTemplates(). |
| `mcp_templates_get` | GetTemplate | Read | Return one template's component definition. -> TemplateService::getTemplate(). |
| `mcp_templates_preview` | PreviewTemplate | Read | Dry-run: show what a template would create vs. skip. -> TemplateService::previewTemplate(). |
| `mcp_templates_apply` | ApplyTemplate | Trigger | Apply a template: create its content types, vocabularies, roles, views, media types and webforms. Requires admin scope (`AccessManager::canAdmin()`). -> TemplateService::applyTemplate() + ComponentFactory. |
| `mcp_templates_export` | ExportAsTemplate | Trigger | Export existing content types/vocabularies/roles into a reusable template definition. Requires admin scope; template name is machine-name validated. -> TemplateService::exportAsTemplate(). |

Scope mapping: Read tools are usable by a read-scoped connection; Write tools need a write scope and fail closed under global read-only / config-only mode; Trigger tools need an admin scope. Services re-verify the scope and audit-log each mutation.

