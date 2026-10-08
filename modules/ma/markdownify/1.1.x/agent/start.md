# Markdownify — agent index

Serves a **Markdown** version of supported entities (default: `node`, `taxonomy_term`) by
rendering them to HTML and converting with `league/html-to-markdown`. Requires
`node` + `taxonomy`, library `league/html-to-markdown`. Configure route:
`markdownify.settings` → `/admin/config/services/markdownify`. Permission:
`administer markdownify`.

- **Six access methods, the `markdownify.settings` config keys (`supported_entities`,
  `default_converter`, `noindex`, `converters`), the settings form and access control** →
  [configure/settings.md](configure/settings.md)
- **The `html_to_markdown_converter` plugin type — how to add your own converter (e.g.
  CommonMark) and the shipped `league` plugin** → [plugins/converters.md](plugins/converters.md)
- **Services (`markdownify.entity_converter`, `.html_converter`, `.supported_entity_types.validator`),
  the `markdownify` link template and `[entity:markdownify-url]` token** →
  [api/services.md](api/services.md)
- **The four `hook_markdownify_*_alter()` hooks in `markdownify.api.php`** →
  [hooks/hooks.md](hooks/hooks.md)

Submodules (own docs): **markdownify_path** (`.md` on aliases), **markdownify_views**
(Markdown for Views pages), **markdownify_file_attachment** (inline file contents).

Key facts:
- Markdown reachable via `/node/1.md`, `/markdownify/node/1`, `?_format=markdown`,
  `Accept: text/markdown`, `Content-Type: text/markdown` (and alias `.md` with markdownify_path).
- Output is `text/markdown` (`MarkdownResponse`), `noindex` by default, `Vary: Accept`.
- Access re-uses the entity's own view permission (`MarkdownifyEntityAccessCheck`).
