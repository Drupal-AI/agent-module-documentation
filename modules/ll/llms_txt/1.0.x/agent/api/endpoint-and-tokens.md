# Endpoint, tokens, path processor, caching

## The `/llms.txt` endpoint

- Route `llms_txt.llms_txt` → path `/llms.txt`, `_access: 'TRUE'` (public), controller
  `LlmsTxtController` (invokable, `@internal`).
- Returns a `CacheableResponse` with `Content-Type: text/markdown; charset=utf-8`.
- Body = `token->replace(llms_txt.settings.content)` then, for each **published**
  `llms_txt_section` the current user may view (ordered by `weight`), a
  `"## {label}\n{rendered content}\n"` block. Text bodies render via `#type: processed_text`.
- Cacheability: depends on `llms_txt.settings`, the section list cache tags/contexts, each
  included entity, and token metadata — so edits invalidate correctly.

**Web-server note:** the route only works if the web server passes `/llms.txt` to Drupal.
Nginx example:

```
location = /llms.txt {
  access_log off;
  try_files $uri @drupal;
}
```

## Markdown-menu tokens (`llms_txt.tokens.inc`)

Token type **`llms_txt_markdown_menu`** with **one token per menu**:
`[llms_txt_markdown_menu:<menu_id>]` (e.g. `:main`, `:footer`, `:admin`). It renders that menu
as a nested Markdown list:

- depth up to 3, enabled links only, access-checked;
- each item `- [Title](absolute-url)`; `<nolink>` items become plain `- Title`; a link
  description is appended after `: `.

Use it inside `llms_txt.settings.content` or a section body to embed navigation.

### Optional Views tokens

If the `markdownify_views` module is enabled, token type **`llms_txt_views`** is added with one
token per display of each View **tagged `llms_txt_section`**
(`[llms_txt_views:<view_id>:<display_id>]`), rendering that display's output as Markdown via
`markdownify.html_converter`. Without `markdownify_views`, these tokens do not exist.

## Path processor

`HttpKernel\LlmsTxtOnlyOnDefaultPathProcessor` is tagged `path_processor_inbound`
(priority 1024) and `path_processor_outbound` (priority -1024) so it runs around the language
path processor — keeping `/llms.txt` at the site root with **no language prefix** on
multilingual sites.

## No Drush / no plugin types

The module defines a content entity type, a controller, a config form, and token hooks — but no
Drush commands and no plugin manager of its own. Extend it by adding menus (for menu tokens),
section entities, or Markdown-tagged Views (with markdownify_views).
