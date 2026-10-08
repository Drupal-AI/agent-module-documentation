# Markdownify Metadata submodule (new in 1.2.x)

`markdownify_metadata` prepends a **YAML frontmatter** block to the Markdown produced by
Markdownify, so the `.md` output carries (nearly) the same context as the HTML page for AI
agents and other consumers. Requires core `^10 || ^11` and depends on `markdownify` + `node`.

- **Config object:** `markdownify_metadata.settings`
- **Settings form:** `/admin/config/services/markdownify/metadata`
  (permission `administer markdownify metadata`, `restrict access: true`)
- **Service:** `markdownify_metadata.manager` (`MarkdownifyMetadataManager`)

## How it hooks in

Three alter hooks, in order:

1. `hook_markdownify_entity_build_alter` → `setCurrentEntity()` memorizes the entity.
2. `hook_markdownify_entity_html_alter` → `stripImagesFromHtml()` removes `<img>` and
   `<picture>` blocks from the HTML (images are surfaced in frontmatter instead).
3. `hook_markdownify_entity_markdown_alter` → `buildFrontmatter($entity)` is prepended to the
   Markdown (with a route-based fallback to re-resolve the entity if state was lost).

## What lands in the frontmatter

`MarkdownifyMetadataManager::buildFrontmatter()` builds a `$data` map, YAML-encoded between
`---` fences:

- `url` — absolute canonical URL; `title`; `author` (`name`, and `url` for non-anonymous owners).
- `date` / `updated` — created & changed times as ISO 8601 in **UTC** (normalized so cached
  responses don't vary by request timezone).
- `license` / `copyright` — from config, only when non-empty.
- `type` — bundle (or OG `type`).
- `summary` — from `text_with_summary` summaries or known field names
  (`summary`, `abstract`, `field_summary`, `field_abstract`, `field_seo_description`).
- `tags` — referenced taxonomy term labels; `image`/`images`; `files`; `published` (bool).
- Title/summary/image/URL are overridden by **Open Graph** values when present; extra `og:*`
  keys go under `og`.

## Optional integrations

- **Metatag** (`enable_metatag`, default on): basic metatags + Open Graph collected via
  `metatag_get_tags_from_route()`; OG values take precedence over duplicate field data.
- **Schema Metatag** (`enable_schema_metatag`, default on): JSON-LD parsed via
  `SchemaMetatagManager::parseJsonld()` into a `schema` key.

Both are guarded by `moduleExists()` / `function_exists()` / `class_exists()` and are no-ops
when the modules are absent. Frontmatter building is wrapped in try/catch and logs (rather than
renders) any failure.

## Config keys

```yaml
enable_metatag: true          # include Metatag / Open Graph when metatag is installed
enable_schema_metatag: true   # include Schema Metatag JSON-LD when schema_metatag is installed
license: ''                   # license URL, omitted from frontmatter when empty
copyright: ''                 # copyright notice, omitted when empty
```
