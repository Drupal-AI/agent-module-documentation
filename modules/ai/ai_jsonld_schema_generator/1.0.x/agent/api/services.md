<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services, controllers & the generation flow

## Services (`ai_jsonld_schema_generator.services.yml`)

- **`ai_jsonld_schema_generator.schema_generator`** — `Service\SchemaGeneratorService`. Builds
  content, calls the AI chat provider, parses/validates/post-processes JSON-LD.
- **`ai_jsonld_schema_generator.schema_attacher`** — `Service\SchemaAttacherService`. Loads/saves
  `ai_schema_route` rows by path/node, resolves titles, does `[site:url]` token swaps, and returns
  the blocks for the current request.
- **`ai_jsonld_schema_generator.content_extractor`** — `Service\ContentExtractorService`. Renders
  an internal path to visible text (+ breadcrumb/video/audio URLs) for full-page generation.
- **`ai_jsonld_schema_generator.route_subscriber`** — `Routing\RouteSubscriber` (event subscriber).

## SchemaGeneratorService

- `generateForNode(NodeInterface $node)`: content source per config — `tokens`
  (`token->replace(content_template)`, falling back to `buildNodeContent()` which walks all
  fields, expands referenced paragraphs, strips HTML) or `full_page`
  (`ContentExtractorService::extractFromPath()`). Appends detected video/audio URLs, ensures a
  `FAQ:` signal, builds the prompt (`buildPrompt()` = `str_replace('{{ content }}', ...)`), calls
  `callAi()`, then `parseAndNormalizeToSchemas()`, and post-processes each block
  (`sanitizeJsonLd`, `normalizeHowToInJsonLd`, `truncateArticleBodyInJsonLd`,
  `postProcessGraphForNode`, `ensureBreadcrumbInGraph`). Returns
  `['schemas' => [...], 'schema_types' => [...]]` or NULL.
- `generateForContent(string $content)`: same pipeline for URL/views content (no node
  post-processing).
- `callAi()`: enforces Flood rate limiting per `current_user` (`FLOOD_NAME` +
  `rate_limit_max_per_hour`/`rate_limit_window`; throws `RateLimitExceededException`), resolves
  provider/model (`getProviderAndModel()` — config `provider_model` or default `chat`), sets the
  system prompt "You output only valid JSON…", calls `provider->chat()`, returns the text.
- Validation: `parseAndValidateResponse()` / `parseAndNormalizeToSchemas()` strip markdown
  fences, JSON-decode, and require `@context` + `@type`/`@graph` (`isValidJsonLd()`).

## SchemaAttacherService

Path/node lookups (`loadByPath`, `loadByNode`, `getNodeForPath`, `getTitleForPath` via
`router.no_access_checks`), `saveSchemaForNode()` (upsert keyed by node → `route_path` from the
alias), and `getSchemaForCurrentRequest()` = site-wide config blocks + the current path's row.
Token helpers `replaceBaseUrlWithToken()` / `replaceTokenWithBaseUrl()` +
`normalizeDoubleSlashesInUrls()`.

## ContentExtractorService

`extractFromPath($path)`: forces `$path = '/' . ltrim($path,'/')` (so the target host is always
the site's own), fetches via `fetchViaSubrequest()` (`http_kernel` SUB_REQUEST with the current
request's cookies) or, failing that, a same-host Guzzle GET (`fetchUrl()`, 15s timeout).
Extracts breadcrumb (DOMXPath), visible text (strip script/style + tags), and video/audio URLs.

## Controllers & routes

- `Controller\SchemaGenerationController::generateForNode()` (`generate_node`, gated
  `generate ai schema` + `node.update`): generates, stores the result in the private tempstore,
  redirects to the preview form.
- `Controller\PageSchemaGenerationController::generateForPath()` (`generate_page_schema`, gated
  `manage url schema`): the `path` query must be in `page_schema_paths` config or already mapped;
  extracts content, generates, and upserts an `ai_schema_route` row.
- `Controller\PreviewValidateController::validatePage()` (`preview_validate`, `_access: TRUE`):
  renders a minimal noindex HTML page with the preview JSON-LD for Google Rich Results Test; only
  returns schema when a valid short-lived `token` (from `SchemaPreviewForm`) matching the node id
  is supplied, else 404. `UrlSchemaRedirectController` redirects the legacy list URL to the view.

## Hooks

`hook_page_attachments()` (attach), `hook_form_alter()` (node edit button), `hook_entity_insert`
/`hook_entity_update` (optional auto-generate/regenerate when published + enabled + provider
available), `hook_entity_presave` for `ai_schema_route` (normalize + tokenize base URL),
`hook_views_data()` (exposes `ai_schema_route` to Views).
