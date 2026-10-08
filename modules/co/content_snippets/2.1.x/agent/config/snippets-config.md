<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration model

Content Snippets stores everything in **two ordinary config objects** (no schema file ships, so
these are untyped config). There is no entity type and no database table.

## `content_snippets.items` — definitions

One entry per snippet, keyed by machine ID. Written by `SnippetEdit` and `ContentSnippetsEdit`,
deleted by `SnippetDelete`. Shape:

```yaml
my_snippet:
  label: 'My Snippet'      # shown to editors
  id: my_snippet           # machine name (lowercase, numbers, underscores; maxlength 64)
  type: textfield          # number | textfield | textarea | text_format
  description: 'Help text'  # shown to editors on the value form (may contain HTML)
  group: 'Footer'          # optional; groups snippets into a details element
  weight: 10               # ordering on the editor form
  filter: basic_html       # only present for type: text_format — chosen text format
```

Helper `content_snippets_config()` returns this object with `_core` stripped.

## `content_snippets.content` — values

All snippet values live under a single `snippets` key (this layout was introduced by
`content_snippets_post_update_restructure_config`):

```yaml
snippets:
  my_snippet: 'The current text'
  price_threshold: '500'
```

Helpers: `content_snippets_retrieve('my_snippet')` returns the string (or `NULL`);
`content_snippets_retrieve_all()` returns the whole `snippets` array.

## The forms

- **`ContentSnippets`** (`/admin/config/content_snippets/admin`) — read-only table of defined
  snippets sorted by group, then weight, then ID, with edit/delete links and an "Add Snippet"
  action. `administer content snippets`.
- **`SnippetEdit`** (`/new`, `/{snip_id}/edit`) — defines a snippet: label, machine ID
  (`machine_name` element, disabled once set), type (`select`), text format (`select`, visible
  only when type is `text_format`, populated from `filter_formats()`), help text, group, weight.
  `administer content snippets`. Note: the format list is **all** formats, chosen by the admin.
- **`ContentSnippetsEdit`** (`/admin/content/content_snippets`) — one form field per defined
  snippet, of the snippet's declared `type`, grouped by `group`. For `text_format` snippets the
  submitted format is written back into the definition's `filter`. `edit content snippets`.
- **`SnippetDelete`** (`/{snip_id}/delete`) — confirmation form; clears the snippet from both
  `content_snippets.content` and `content_snippets.items`. `administer content snippets`.

## Type behaviour

| `type` | Widget | Stored value | Render |
|--------|--------|--------------|--------|
| `number` | number | numeric string | escaped/plain |
| `textfield` | text field | plain string | escaped/plain |
| `textarea` | textarea | plain string | escaped/plain |
| `text_format` | formatted text + format select | raw markup + `filter` | run through the text format (`processed_text`) |

## Deployment

Because both objects are plain configuration, they are exported by `config:export` and replaced by
`config:import`. To let editors own snippet **values** on production, exclude
`content_snippets.content` from configuration import (e.g. via a config-ignore/split strategy);
otherwise their edits are reverted at the next deploy.
