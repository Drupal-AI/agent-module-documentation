<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The generation pipeline (services, form, access)

## Install & enable

```bash
composer require drupal/ai_content_assistant
drush en ai_content_assistant -y
```

Requires `drupal/ai` and a configured AI **chat** provider (e.g. `ai_provider_openai`). Install
`drupal/paragraphs` only if you generate paragraph-based bundles. Grant the **`generate ai
content`** permission to the roles that should use it.

## Entry points

- **Route** `ai_content_assistant.generate` → `/node/add/ai-generate` (`_admin_route: TRUE`), form
  `AiContentGenerateForm`, requirement `_permission: 'generate ai content'`.
- `AiContentGenerateForm::buildForm()` shows a `node_type` select (only bundles the current user
  can create, via `entityTypeManager->getAccessControlHandler('node')->createAccess()`) and a
  required `prompt` textarea. `submitForm()` calls `ContentGenerator::generate($prompt, $type)`,
  adds a status message, and redirects to the new node. It catches
  `MissingTextToImageProviderException` (actionable admin message + logged warning) and any other
  `\Throwable` (generic error + logged error). Because it is a Form API form, CSRF protection is
  automatic.

## Access — `Access\AiContentGenerateAccess`

`access(AccountInterface $account, NodeTypeInterface $node_type)` returns
`allowedIfHasPermission($account, 'generate ai content')->andIf(<node createAccess for the bundle>)`.
Both conditions must pass. This same checker is injected into `ContentGenerator` and the MCP tools,
so authorization is identical regardless of entry point.

## `Service\ContentGenerator`

Constructor args: `@ai.provider`, `@entity_type.manager`, the schema-discovery service,
`@logger.factory`, the access checker, `@current_user`, `@plugin.manager.entity_reference_selection`,
and optional `@?filter.format_repository`.

- **`generate(string $prompt, string $content_type): NodeInterface`** — loads the node type
  (throws `\InvalidArgumentException` if missing), runs the access check (throws
  `\Drupal\Core\Access\AccessException` if denied) **before** any AI call, calls
  `schemaDiscovery->assertContentTypeIsReady()`, builds the system prompt, calls the AI, then hands
  the parsed data to `generateFromData()`.
- **`generateFromData(array $data, string $content_type): NodeInterface`** — the shared node
  builder. Re-runs the exact same access check (so callers with pre-structured data, e.g. MCP's
  `create_node`, cannot bypass authorization) and re-asserts readiness, then creates the node with
  `status = 0`, maps node-level `fields`, and builds paragraphs from `paragraphs` keyed by paragraph
  reference field name. Returns the saved draft node.
- **`callAi()`** — prefers `getDefaultProviderForOperationType('chat_with_complex_json')`, falling
  back to `'chat'`; throws `\RuntimeException` if none. Sends the user prompt as a `ChatMessage`
  plus a system prompt, strips markdown code fences, extracts the `{...}` JSON object, `json_decode`s
  it, and requires a non-empty `title` and at least one of `fields`/`paragraphs` (else
  `\RuntimeException`).
- **`buildSystemPrompt()`** — embeds the schema description, the admin-supplied bundle description
  (see [config/content-type-context.md](../config/content-type-context.md)), and rules. When no
  `text_to_image` provider is configured the prompt instructs the AI to omit image fields.

### Field mapping (`mapFieldValue()` and helpers)

- **Entity references** — `{"target_id": N}` (single) or an array of them. Each ID is validated by
  `validateEntityReference()`: the entity must load, and the field's **selection handler**
  (`selectionPluginManager->getSelectionHandler()->validateReferenceableEntities()`) must accept it;
  otherwise it is logged and skipped. Catches AI hallucinations of valid-but-wrong-bundle IDs.
- **Images** — `{"image_prompt": "..."}` routes through `generateImage()`, which uses the default
  `text_to_image` provider, saves the result as a `media:image` entity under
  `public://ai-generated/Y-m/` with a `uniqid()` filename and the prompt (first 512 chars) as alt
  text. Failures are logged and return `NULL`. Existing media may be reused with `{"target_id": N}`.
- **Links** — `validateLinkValue()` accepts a URI only if it starts with one of
  `ALLOWED_URI_SCHEMES` (`route:`, `internal:`, `https://`, `http://`, `entity:`, `<nolink>`), then
  enforces the field's `link_type` (internal-only rejects external URLs and vice-versa). Rejected
  values are logged and dropped.
- **Formatted text** (`text`, `text_long`, `text_with_summary`) — normalized to `{value, format}`,
  where `getTextFormat()` picks `basic_html` (when the field allows it or has no restriction) else
  `plain_text`.
- **Plain strings** — `decodeEntities()` (`html_entity_decode`, `ENT_QUOTES | ENT_HTML5`) so stored
  titles are not double-encoded; Drupal handles output escaping on render.

### Paragraphs

`generateFromData()` reads `getParagraphSchema()` and, for each paragraph reference field, creates a
`paragraph` entity per item via `createParagraph()`, attaching `target_id`/`target_revision_id`.
Compound (nested) paragraph types are supported **one level deep** — sub-paragraphs are created
recursively with an empty compound map so recursion stops. `createParagraph()` also accepts
sub-paragraphs sent under a sibling `paragraphs` key (a shape MCP clients tend to produce), merging
them into `fields` with existing fields taking precedence.

## `Service\ContentSchemaDiscovery`

Builds the machine- and human-readable schema the AI sees.

- `getNodeFields()` / `getFieldsForBundle()` — enumerate configurable, non-computed fields (core
  base fields in `SKIP_NODE_FIELDS`/`SKIP_PARAGRAPH_FIELDS` are excluded), recording type, required,
  cardinality (honoring the `field_config_cardinality` third-party override), `max_length`, allowed
  text formats, link title/type, color-field default palette, and referenceable entities.
- `getParagraphSchema()` — for each `entity_reference_revisions`→`paragraph` field, walks allowed
  bundles and their sub-paragraph fields; a bundle is included only if `isBundleUsable()` passes
  (every required reference field can be filled).
- **Referenceable entities** come from the field's selection handler
  (`getReferenceableFromHandler()`), falling back to `queryAvailableEntities()`. Both cap at
  `ENTITY_LIST_LIMIT = 15`, run `accessCheck(TRUE)`, and additionally filter each loaded entity with
  `->access('view')`, so the AI is only ever shown entities the current user may view. Results are
  cached per request by `entity_type|bundles`.
- `getSchema()` — the compact, agent-facing shape (`bundle`, `label`, `description`, `usage_notes`)
  returned by the MCP `describe_content_type` tool.
- `canGenerateImages()` — TRUE when a default `text_to_image` provider exists.
- `assertContentTypeIsReady()` — throws `MissingTextToImageProviderException` when a **required**
  node-level image-media field, or a required paragraph reference whose allowed types all need image
  generation, cannot be filled without a `text_to_image` provider. Strict at the node level, lenient
  at the paragraph level.

## Operating notes

- Every generated node is an **unpublished draft**; a human publishes it.
- No content is rendered raw by this module — values are stored as ordinary field data and rendered
  later through Drupal's normal field formatters and text formats.
- Logs are written to the `ai_content_assistant` channel (parse failures, skipped references/links,
  image failures, blocked bundles).
