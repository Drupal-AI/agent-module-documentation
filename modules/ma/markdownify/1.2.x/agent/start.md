# Markdownify — agent index

Serves a **Markdown** version of supported entities (default: `node`, `taxonomy_term`) by
rendering them to HTML and converting with `league/html-to-markdown`. Requires
`node` + `taxonomy`, library `league/html-to-markdown` (`^5.1`). Configure route:
`markdownify.settings` → `/admin/config/services/markdownify`. Permission:
`administer markdownify`.

- **Six access methods, the `markdownify.settings` config keys (`supported_entities`
  incl. per-bundle `view_modes`, `default_converter`, `noindex`, `converters`), the settings
  form and access control** → [configure/settings.md](configure/settings.md)
- **The `html_to_markdown_converter` plugin type — how to add your own converter (e.g.
  CommonMark) and the shipped `league` plugin** → [plugins/converters.md](plugins/converters.md)
- **Services (`markdownify.entity_converter`, `.entity_renderer`, `.html_converter`,
  `.supported_entity_types.validator`), the `markdownify` link template and
  `[entity:markdownify-url]` token** → [api/services.md](api/services.md)
- **The four `hook_markdownify_*_alter()` hooks in `markdownify.api.php`** →
  [hooks/hooks.md](hooks/hooks.md)
- **The `markdownify_metadata` submodule — YAML frontmatter prepended to the Markdown** →
  [metadata/metadata.md](metadata/metadata.md)

Submodules (own docs): **markdownify_path** (`.md` on aliases), **markdownify_views**
(Markdown for Views pages), **markdownify_file_attachment** (inline file contents),
**markdownify_metadata** (YAML frontmatter, new in 1.2.x).

Key facts:
- Markdown reachable via `/node/1.md`, `/markdownify/node/1`, `?_format=markdown`,
  `Accept: text/markdown`, `Content-Type: text/markdown` (and alias `.md` with markdownify_path).
- Output is `text/markdown; charset=utf-8` (`MarkdownResponse`), `noindex` by default, `Vary: Accept`.
- Access re-uses the entity's own `view` access (`_entity_access` + `MarkdownifyEntityAccessCheck`
  enforcing supported entity type/bundle/language).
- Per-bundle **view mode** selection (`supported_entities.<type>.view_modes.<bundle>`, new in
  1.2.x); falls back to `full` when unset.

## Diff 1.1.x → 1.2.x

- **New submodule `markdownify_metadata`** — prepends a YAML frontmatter block (URL, title,
  author, dates, license/copyright, tags, images, files, publication status, plus Metatag /
  Open Graph / Schema Metatag JSON-LD when those modules are present) to the Markdown output.
  Own config `markdownify_metadata.settings`, form at `/admin/config/services/markdownify/metadata`,
  permission `administer markdownify metadata`. Requires core `^10 || ^11`.
- **Per-bundle view mode** — new `supported_entities.<type>.view_modes.<bundle>` config key and
  a "View mode per bundle" control on the settings form; `MarkdownifyController::render` now
  resolves the configured view mode (default `full`). Schema adds `view_modes`.
- **`markdownify_file_attachment`** — dedicated settings form/route at
  `/admin/config/services/markdownify/file-attachment` (`administer site configuration`) and menu
  link; default `allowed_extensions` widened to `txt, yml, yaml, wsdl, json`, `max_file_embed_size`
  default `1 MB`.
- Markdown library unchanged: still `league/html-to-markdown` `^5.1` (no library version change).
- Same four alter hooks and the `league` converter plugin as 1.1.x; the deprecated
  `hook_markdownify_supported_entity_types_alter()` / `getSupportedEntityTypes()` remain (removed
  in 2.0.0).
