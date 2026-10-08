<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Submodule: AI Schema.org JSON-LD Breadcrumb (ai_schemadotorg_jsonld_breadcrumb)

Adds `BreadcrumbList` Schema.org JSON-LD to the page head. Package `AI`, core `^11`, depends only on
`ai_schemadotorg_jsonld`. No routes, no permissions, no config — enabling it is all the setup there is.

## What it provides

- Service `ai_schemadotorg_jsonld_breadcrumb.manager` → `AiSchemaDotOrgJsonLdBreadcrumbManager`
  (alias `...ManagerInterface`), autowired.
- Hook class `Hook/AiSchemaDotOrgJsonLdBreadcrumbPageHooks` implementing `page_attachments`.

## Mechanism (from source)

`AiSchemaDotOrgJsonLdBreadcrumbManager::build(RouteMatch, BubbleableMetadata)`:

- Returns `NULL` unless the chain breadcrumb builder `applies()` and produces links.
- For each breadcrumb link, uses the link's **absolute URL** as `item.@id` and the link **text** as
  `item.name` (rendering it via `renderInIsolation()` if the text is a render array), building
  `ListItem` entries with 1-based `position`.
- If the current route resolves to a canonical content entity (shared
  `AiSchemaDotOrgJsonLdCurrentEntityTrait`), appends a final `ListItem` for the entity itself
  (`@id` = canonical absolute URL, `name` = `$entity->label()`).
- Returns a `{@context, @type: BreadcrumbList, itemListElement: [...]}` array, and adds the breadcrumb
  and entity as cacheable dependencies.

`Hook/AiSchemaDotOrgJsonLdBreadcrumbPageHooks::pageAttachments()`:

- Calls `build()`; if empty, returns.
- Applies **only cache metadata** to `$attachments` via `CacheableMetadata::createFromRenderArray(...)
  ->addCacheableDependency($bubbleable_metadata)->applyTo(...)` — deliberately **not**
  `BubbleableMetadata::applyTo()`, whose `#attached` overwrite would clobber the parent module's head
  JSON-LD (documented in the code).
- Appends a `#type: html_tag` `script` with `#attributes.type = application/ld+json` and the encoded
  breadcrumb array to `#attached[html_head]`, keyed `ai_schemadotorg_jsonld_breadcrumb`.

## Operating notes

- The breadcrumb JSON-LD reflects whatever the site's breadcrumb builder produces (Drupal core, or an
  overriding module like `menu_breadcrumb`), plus the current entity as the last crumb.
- Emitted on any route where breadcrumbs apply, not only entity canonical routes.
- No configuration — there is nothing to tune; disable the submodule to stop emitting it.
