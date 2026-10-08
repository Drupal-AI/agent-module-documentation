<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Per-content-type context & the node-add link

There is **no settings form and no config schema** in this module. The only persisted configuration
is a single per-node-type value, and the only UI additions are on the node-type edit form and the
`/node/add` list. All logic lives in `ai_content_assistant.module`.

## The `node_type_description` third-party setting

`ai_content_assistant_form_node_type_form_alter()` (implements
`hook_form_node_type_form_alter`) adds an **"AI Content Assistant"** details group (in the
`additional_settings` vertical tabs) to every content type edit form
(`/admin/structure/types/manage/{type}`), with one textarea:

- **"Node type description for AI"** — free-form guidance describing when/how to use the bundle
  (e.g. *"Articles are long-form editorial content"*).

`ai_content_assistant_node_type_form_builder()` (registered via `$form['#entity_builders']`) saves a
trimmed non-empty value as the node type's third-party setting
`ai_content_assistant.node_type_description`, or unsets it when empty. There is **no config schema**
shipped for this third-party setting.

### How it is used

The stored description is read back in three places and fed to callers/AI:

- `ContentGenerator::generate()` → `$node_type->getThirdPartySetting('ai_content_assistant',
  'node_type_description', '')` → injected into the system prompt by `buildSystemPrompt()` as
  admin-provided "Content type context". It is intentionally passed to the AI unmodified so admins
  can give free-form guidance (writing it requires the `administer content types` permission).
- `ContentSchemaDiscovery::getSchema()` exposes it as the `description` key (used by the MCP
  `describe_content_type` and `list_content_types` tools).

## The "Generate with AI" node-add link

- `ai_content_assistant_preprocess_node_add_list()` (implements
  `hook_preprocess_node_add_list`) prepends a **"Generate with AI"** item to the `/node/add` list,
  linking to `ai_content_assistant.generate`. It first checks
  `currentUser->hasPermission('generate ai content')` and returns early if the user lacks it, so the
  link only appears for permitted users. It handles both the Claro `bundles` variable and the core
  default `types` variable.
- `ai_content_assistant_theme_registry_alter()` (implements `hook_theme_registry_alter`) moves this
  preprocess to the **end** of the `node_add_list` preprocess chain so it still runs after theme
  preprocessors (e.g. Claro) that rebuild the template variables.

## Summary of what an operator configures

1. Grant **`generate ai content`** to the appropriate roles (`/admin/people/permissions`).
2. Configure an AI **chat** provider in the `drupal/ai` module (and a **text_to_image** provider if
   any target bundle has required image fields).
3. Optionally add a "Node type description for AI" on each content type to improve output quality.

Everything else (fields, paragraphs, reference targets) is discovered automatically from the
bundle's own schema at generation time.
