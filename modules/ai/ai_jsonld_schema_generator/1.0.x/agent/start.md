<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI JSON-LD Schema Generator (ai_jsonld_schema_generator) — agent index

Generates **schema.org JSON-LD** from node content or an internal URL via the **Drupal AI**
module and attaches it to the page head. Package *SEO*. Core `^11`. Depends on core **`node`,
`field`, `user`, `views`** and **`ai`** (drupal/ai). License GPL-2.0-or-later. Version 1.0.0.

- **Settings form, config object keys, prompt & site-wide schema** →
  [config/settings.md](config/settings.md)
- **The `ai_schema_route` entity, its list/forms, and how schema is attached** →
  [entities/ai_schema_route.md](entities/ai_schema_route.md)
- **Services, controllers, routes, permissions, hooks (the generate/preview flow)** →
  [api/services.md](api/services.md)

## What it provides

- **Entity type** `ai_schema_route` (`Entity\AiSchemaRoute`, base table `ai_schema_route`) —
  stores JSON-LD keyed by `route_path`, with `title`, `schema_type`, `schema_json`, `enabled`,
  `generated_on`, `entity_id`, `source_type` (`node`|`path`). Access handler
  `AiSchemaRouteAccessControlHandler`, admin permission `manage url schema`. Listed via the
  Views view `ai_schema_mappings` ("Schema mappings").
- **Three services** (`*.services.yml`): `schema_generator` (`Service\SchemaGeneratorService`),
  `schema_attacher` (`Service\SchemaAttacherService`), `content_extractor`
  (`Service\ContentExtractorService`), plus a `RouteSubscriber`.
- **Permissions** (`*.permissions.yml`): `generate ai schema`; `administer ai schema settings`
  and `manage url schema` (both `restrict access: true`).
- **Config object** `ai_jsonld_schema_generator.settings` (schema in `config/schema/`): prompt
  template, provider/model, enabled content types, node content source, site-wide
  Organization/WebSite JSON-LD, auto-generate flags, Flood rate-limit, `page_schema_paths`.

## Key mechanism (from source)

- `hook_page_attachments()` in `ai_jsonld_schema_generator.module` calls
  `SchemaAttacherService::getSchemaForCurrentRequest()` (site-wide config schema + the
  `ai_schema_route` row matching the current path) and adds each block as an `html_tag` script
  of type `application/ld+json`.
- `hook_form_alter()` adds a "Generate Schema via AI" / preview / edit link to the node edit form
  for enabled content types when the user has `generate ai schema`.
- `SchemaGeneratorService::generateForNode()` / `generateForContent()` builds content (token
  template or full-page extraction), sends the prompt to the AI chat provider, parses/validates
  the JSON-LD, post-processes it (WebPage/Article/Breadcrumb/Video/Audio normalization), and
  returns schema blocks. Generation is Flood-rate-limited per user.
- Content-schema and URL-schema generation routes are gated by `generate ai schema` +
  `node.update` (nodes) or `manage url schema` (URLs); the settings form by
  `administer ai schema settings`.

## Integration notes

- Uses the **drupal/ai** provider abstraction for all AI calls — no external API key or TLS
  handling lives in this module.
- `ContentExtractorService` fetches internal pages via an in-process **subrequest** (same host,
  current user's cookies) or a same-host Guzzle GET; it never fetches an arbitrary external host.
- Schema is stored by path; changing a node's alias means regenerating (or the stored
  `route_path` no longer matches).
