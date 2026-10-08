The llms_txt module serves a dynamic **`/llms.txt`** endpoint — a Markdown "homepage for LLMs" — that you author from the Drupal admin, so AI agents and crawlers can discover your site's key content.

---

The module registers a public route at `/llms.txt` (controller `LlmsTxtController`) that returns
`text/markdown`. The body is assembled from two sources: the config object
`llms_txt.settings.content` (a text value that supports **tokens**, edited on the config form at
`/admin/content/llms-txt`, route `llms_txt.llms_txt_config`), followed by any published
**`llms_txt_section`** content entities (each a title + Markdown `content` body, ordered by
`weight`), rendered as `## Title` blocks. Sections are managed at
`/admin/content/llms-txt/sections` (add/edit/delete/reorder); they live in the database, so
environment-specific content stays out of exported config while the generic top matter stays in
config. The module adds a token type **`llms_txt_markdown_menu`** with one token per menu
(e.g. `[llms_txt_markdown_menu:main]`) that renders that menu as a nested Markdown link list
(depth 3, access-checked, absolute URLs) — ideal for embedding a navigation map in llms.txt.
When the optional `markdownify_views` module is present, it also exposes `llms_txt_views` tokens
that render Markdown-tagged Views. Output is render-cached with proper invalidation. A path
processor (`LlmsTxtOnlyOnDefaultPathProcessor`) keeps `/llms.txt` free of language prefixes.
A single permission, *Administer /llms.txt configuration*, gates the admin. Your web server must
be configured to serve `/llms.txt` (e.g. an Nginx `location = /llms.txt` block) since `.txt`
files in the web root are often blocked. It requires core Text and conflicts with the `llmstxt`
and `llms_txt_generator` modules.

---

- Publish a curated `/llms.txt` so LLMs and AI agents understand your site during inference.
- Author the llms.txt top matter (title, description) as tokenised config content.
- Add environment-specific llms.txt sections as database `llms_txt_section` entities.
- Order llms.txt sections with a weight so the most important content appears first.
- Embed a site menu as a Markdown link list via `[llms_txt_markdown_menu:main]`.
- Include the footer or a docs menu as Markdown to guide crawlers to key pages.
- Keep generic llms.txt parts in code (config) and site-specific parts in the database.
- Unpublish an llms.txt section to temporarily remove it without deleting it.
- Provide clean, machine-readable content links instead of relying on HTML scraping.
- Use `[site:name]` / `[site:slogan]` and other core tokens in the llms.txt body.
- Point AI agents at Markdown (.md) versions of pages through the section content.
- Render Views output as Markdown in llms.txt when markdownify_views is installed.
- Gate who can edit the llms.txt content with the 'Administer /llms.txt configuration' permission.
- Serve llms.txt with correct `text/markdown` content type and render caching.
- Keep `/llms.txt` at the site root without a language prefix on multilingual sites.
- Maintain an AI-facing site index alongside robots.txt and sitemap.xml.
- Describe your API docs or product pages for AI assistants in a standard format.
- Deploy the generic llms.txt content as part of configuration management.
- Add per-environment notices (staging vs production) via database sections.
- Migrate from a static llms.txt file to a Drupal-managed, editable one.
- Give AI agents an authoritative summary of what the site offers and where to look.
- Reorder or retitle sections as the site's content priorities change.
