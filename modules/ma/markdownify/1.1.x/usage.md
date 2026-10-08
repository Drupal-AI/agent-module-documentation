Markdownify exposes a clean Markdown representation of Drupal entities (nodes, taxonomy terms, and any other entity you enable) by appending `.md` to a URL or negotiating the `text/markdown` format, so bots, AI agents, and LLM pipelines can consume content cheaply.

---

The module renders a supported entity through Drupal's normal render pipeline, then converts the resulting HTML to Markdown using the `league/html-to-markdown` library wrapped in a pluggable `html_to_markdown_converter` plugin (the shipped `league` plugin). Markdown output is reachable six ways: `.md` on the canonical path (`/node/1.md`), the `/markdownify/...` path prefix, the `_format=markdown` query parameter, an `Accept: text/markdown` header, a `Content-Type: text/markdown` header, and (with the `markdownify_path` submodule) `.md` on a path alias. Which entity types/bundles/languages are eligible is controlled by the `supported_entities` config; a `MarkdownifyEntityAccessCheck` re-uses each entity's normal view access so Markdown never bypasses permissions. Responses are served as `text/markdown` (a `MarkdownResponse`), get a `noindex` `X-Robots-Tag` by default, and are cache-separated from HTML via an `Accept`-negotiation middleware plus `Vary: Accept`. The module also adds a `markdownify` link template and a `[entity:markdownify-url]` token to supported entities, and injects an `<link rel="alternate" type="text/markdown">` into the HTML head. Four alter hooks (`hook_markdownify_supported_entities_alter`, `..._entity_build_alter`, `..._entity_html_alter`, `..._entity_markdown_alter`) let other modules tune the pipeline. Three submodules extend it: `markdownify_path` (aliases), `markdownify_views` (Views page output), and `markdownify_file_attachment` (inline file contents).

---

- Serve `/node/1.md` so an AI crawler ingests a page as Markdown at ~10:1 fewer tokens than HTML.
- Give an LLM retrieval pipeline clean, chrome-free Markdown of articles and taxonomy term pages.
- Offer `Accept: text/markdown` content negotiation to API clients without changing URLs.
- Fetch Markdown via `/node/1?_format=markdown` from a script that can't set headers.
- Prefix any entity URL with `/markdownify/` to get its Markdown version.
- Expose Markdown at human-readable alias URLs (`/blog/my-post.md`) via the `markdownify_path` submodule.
- Produce Markdown versions of Views listing pages with the `markdownify_views` submodule.
- Embed the contents of attached `.txt`/`.json`/`.yml` files inline in Markdown via `markdownify_file_attachment`.
- Restrict Markdown output to specific content types (e.g. only Article nodes) through `supported_entities` config.
- Restrict Markdown output to specific languages on a multilingual site.
- Keep Markdown endpoints out of search results with the default `noindex` header.
- Advertise the Markdown alternate to consumers via the `<link rel="alternate" type="text/markdown">` head tag.
- Print a page's Markdown URL anywhere tokens work using `[node:markdownify-url]`.
- Add a custom converter plugin (e.g. CommonMark) by implementing the `html_to_markdown_converter` plugin type.
- Tune the League converter's options (header style, list bullet, strip tags, tables) from the settings form.
- Add support for a custom entity type to Markdownify with `hook_markdownify_supported_entities_alter()`.
- Rewrite an entity's render array before conversion with `hook_markdownify_entity_build_alter()`.
- Post-process the generated Markdown (add a front-matter header, footer) with `hook_markdownify_entity_markdown_alter()`.
- Build an `llms.txt`-style content feed for AI agents from your existing entities.
- Reduce API costs by sending Markdown instead of HTML to token-billed AI services.
- Let a headless/decoupled front end request Markdown for server-side rendering.
- Ensure reverse-proxy caches keep HTML and Markdown variants separate via `Vary: Accept`.
- Convert entity content to Markdown programmatically with the `markdownify.entity_converter` service.
