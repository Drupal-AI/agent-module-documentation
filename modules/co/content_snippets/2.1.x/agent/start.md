<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Snippets (content_snippets) — agent index

Small, editor-editable pieces of text stored as **configuration** and read by machine name from
PHP, tokens, and Twig. Version **2.1.0**. Core `^8 || ^9 || ^10 || ^11`. No hard dependencies
(the Filter module is used only to offer the formatted snippet type when present).

## Mechanism (confirmed from source)

Two configuration objects hold everything — there is **no config schema** shipped and **no custom
entity type**; snippets are plain config keys:

- **`content_snippets.items`** — snippet **definitions**. One entry per snippet, keyed by machine
  ID: `{label, id, type, description, group, weight, filter?}`. Written by the admin forms.
- **`content_snippets.content`** — snippet **values**, all under a single `snippets` key:
  `snippets[id] = value`. Written by the editor form.

`type` is one of `number`, `textfield` (Line/plain), `textarea` (Paragraph/plain), or
`text_format` (Paragraph/formatted, only offered when the `filter` module is enabled). For a
`text_format` snippet, `filter` stores the chosen text-format machine name.

### Reading a snippet (three consumer paths)
- **PHP:** `content_snippets_retrieve('id')` → raw string value, or `NULL`.
  Also `content_snippets_retrieve_all()` and `content_snippets_config()`.
- **Token:** `[content_snippets:id]` — a custom `content_snippets` token type
  (`content_snippets.tokens.inc`). Returns the raw value; core's `Token::replace()`
  HTML-escapes plain-string replacements, so output is safe.
- **Twig:** `{{ contentSnippets.id }}`. `hook_template_preprocess_default_variables_alter`
  publishes `contentSnippets`. Plain types are strings (Twig auto-escapes them); `text_format`
  types are wrapped in `\Drupal\content_snippets\RenderableSnippet`, which renders as
  `#type => processed_text` with the configured format (filtered).

## Routes / UI

| Route | Path | Permission | Purpose |
|-------|------|-----------|---------|
| `content_snippets.config.admin_index` | `/admin/config/content_snippets` | `administer content snippets` | Admin menu block (the `configure` link) |
| `content_snippets.config.snippets_config` | `/admin/config/content_snippets/admin` | `administer content snippets` | List defined snippets (`ContentSnippets` form) |
| `content_snippets.config.snippet_new` | `/admin/config/content_snippets/new` | `administer content snippets` | Create a snippet (`SnippetEdit`) |
| `content_snippets.config.snippet_edit` | `/admin/config/content_snippets/admin/{snip_id}/edit` | `administer content snippets` | Edit a snippet definition (`SnippetEdit`) |
| `content_snippets.config.snippet_delete` | `/admin/config/content_snippets/admin/{snip_id}/delete` | `administer content snippets` | Delete a snippet (`SnippetDelete`) |
| `content_snippets.content.custom_text` | `/admin/content/content_snippets` | `edit content snippets` | Edit snippet **values** (`ContentSnippetsEdit`) |

## Permissions (the key design point)

- **`administer content snippets`** — add / edit / delete snippet **definitions**. Structural;
  admin-level. Also chooses the text format for formatted snippets.
- **`edit content snippets`** — change snippet **values** only. "generally for content editors."

The split — *which snippets exist* vs *what they say* — is the module's reason to exist.

## Deployment trade (state it to the user)

Both config objects deploy with the codebase and are **overwritten by `config:import`**. An
editor's production edit to a snippet value is lost on the next deployment unless the workflow
excludes `content_snippets.content` from import. Good for wording that is a design decision; wrong
for wording that is genuinely editorial.

## Files
- `content_snippets.module` — API functions, `hook_help`, Twig variable publishing.
- `content_snippets.tokens.inc` — token type + replacement.
- `src/RenderableSnippet.php` — formatted-snippet renderable (`processed_text`).
- `src/Form/*` — `ContentSnippets` (list), `SnippetEdit` (define), `ContentSnippetsEdit` (edit
  values), `SnippetDelete` (delete).
- `src/Plugin/Menu/LocalTask/ContentSnippetLocalTask.php` — local-task title from a snippet.

## Detail docs
- `config/snippets-config.md` — config object shapes, definition fields, forms.
- `tokens/consuming-snippets.md` — token, Twig, and PHP consumption in depth.
