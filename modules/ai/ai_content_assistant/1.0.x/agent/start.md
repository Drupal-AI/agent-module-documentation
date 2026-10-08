<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Content Assistant (ai_content_assistant) — agent index

Generates a complete **unpublished node** from a text prompt by reading the content type's field
schema (node fields + Paragraphs + sub-paragraphs) and asking the `drupal/ai` chat provider for
structured JSON. Package `AI`. Core `^11`. License GPL-2.0-or-later. Version 1.0.2 (dir 1.0.x).

- **Depends on:** `node`, `ai` (drupal/ai `^1.0`). **Paragraphs is optional** — only needed for
  paragraph-based bundles (the code guards for it). At least one configured AI **chat** provider is
  required; a **text_to_image** provider is required only for bundles with required image fields.
- **Submodule:** `ai_content_assistant_mcp` (exposes generation as MCP tools) →
  [modules/ai_content_assistant_mcp/1.0.x/agent/start.md](../../modules/ai_content_assistant_mcp/1.0.x/agent/start.md)

## What it provides

- **Route** `ai_content_assistant.generate` → `/node/add/ai-generate`, form
  `\Drupal\ai_content_assistant\Form\AiContentGenerateForm`, `_permission: 'generate ai content'`,
  `_admin_route: TRUE`.
- **Permission** `generate ai content` (`ai_content_assistant.permissions.yml`).
- **Services** (`ai_content_assistant.services.yml`):
  - `ai_content_assistant.content_generator` → `Service\ContentGenerator` — prompt build, AI call,
    JSON→entity mapping, node/paragraph creation.
  - `ai_content_assistant.content_schema_discovery` → `Service\ContentSchemaDiscovery` — inspects a
    bundle's fields/paragraphs, lists referenceable entities, builds the prompt description.
  - `ai_content_assistant.access_checker` → `Access\AiContentGenerateAccess` — permission **and**
    per-bundle node create-access.
- **Exception** `Exception\MissingTextToImageProviderException` — thrown when a required image field
  cannot be filled because no `text_to_image` provider is configured.
- **Hooks** (`ai_content_assistant.module`): `hook_form_node_type_form_alter` +
  entity-builder add a per-bundle **third-party setting** `node_type_description`;
  `hook_preprocess_node_add_list` + `hook_theme_registry_alter` add the "Generate with AI" link.
- No config form, **no config schema**, no Drush, no defined plugin types, no libraries.

## Solution docs

- **Generation pipeline** — services, form, access, AI call, field/paragraph/image mapping →
  [api/generation.md](api/generation.md)
- **Per-content-type context & the node-add link** — the `node_type_description` third-party
  setting and the node-add-list integration → [config/content-type-context.md](config/content-type-context.md)

## Key facts (from source)

- Nodes are always created with `status = 0` (draft) — `ContentGenerator::generateFromData()`.
- Access is enforced in **three** places: the route permission, `AiContentGenerateForm` (lists only
  bundles the user can `createAccess`), and inside `generate()`/`generateFromData()` via
  `AiContentGenerateAccess::access()` (permission `andIf` node `createAccess`). Structured-data
  callers cannot skip the check.
- All entity listing for reference fields runs `accessCheck(TRUE)` **and** a per-entity
  `->access('view')` filter (`ContentSchemaDiscovery::queryAvailableEntities()` /
  `getReferenceableFromHandler()`).
- Link URIs are restricted to `ALLOWED_URI_SCHEMES` (`route:`, `internal:`, `https://`, `http://`,
  `entity:`, `<nolink>`) and to the field's internal/external `link_type`.
- Formatted-text fields are written with `basic_html` (preferred when allowed) or `plain_text`.
