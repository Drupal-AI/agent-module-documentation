# /llms.txt — agent index

Serves a dynamic **`/llms.txt`** Markdown file (a "homepage for LLMs") assembled from a
tokenised config body + published section entities. Permission: *Administer /llms.txt
configuration*. No Drush, no plugin types.

- **Author the content: `llms_txt.settings.content`, the `llms_txt_section` entity, admin
  routes** → [configure/content.md](configure/content.md)
- **The `/llms.txt` endpoint, the Markdown-menu tokens, path processor, caching** →
  [api/endpoint-and-tokens.md](api/endpoint-and-tokens.md)

Key facts:
- Endpoint: route `llms_txt.llms_txt` at `/llms.txt` (public, `text/markdown`).
- Body = `llms_txt.settings.content` (text, tokens) + published `llms_txt_section` entities
  (title + Markdown `content`, ordered by `weight`) rendered as `## Title` blocks.
- Config form: `llms_txt.llms_txt_config` at `/admin/content/llms-txt`; sections collection at
  `/admin/content/llms-txt/sections`.
- Token type `llms_txt_markdown_menu` → `[llms_txt_markdown_menu:<menu_id>]` renders a menu as
  a Markdown list. `llms_txt_views` tokens appear only if `markdownify_views` is enabled.
- Requires core `text`; conflicts with `llmstxt` and `llms_txt_generator`. Your web server must
  allow `/llms.txt` (Nginx `location = /llms.txt`).
