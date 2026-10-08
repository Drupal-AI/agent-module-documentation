<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Quote settings

**Route:** `quote.settings_form` — `/admin/config/content/quote` (permission `administer quote`). Saving runs `drupal_flush_all_caches()`.

## Quote modes (which links appear)
- `quote_modes_quote_sel` — **quote selected**
- `quote_modes_quote_all` — **quote all**
- `quote_modes_quote_reply_all` — **reply and quote all** (comments only; uses the `comment-quote-all-reply` query flow)
- `quote_modes_quote_reply_sel` — **reply and quote selected** (comments only)

## Where quoting is allowed
- `quote_allow_types` — checkboxes of node content types where quoting is enabled.
- `quote_allow_comments` — also allow quoting on comments (only where the node type allows quoting).

## Visibility rules (in code)
A quote link renders only when: the bundle is in `quote_allow_types`, comments are **open**, and the current user has **both** `post comments` and `use quote`. (Comment links additionally require the commented entity to exist.)

## CKEditor 5
- `quote_ckeditor_support` — if checked and CKEditor 5 is present, the editor takes priority when inserting the quote. Disabled unless the `ckeditor5` module is enabled.

## Other settings (passed to `js/quote.js` via drupalSettings)
| Setting | Default | Purpose |
|---|---|---|
| `quote_selector` | `#comment-form textarea` | target field the quote is inserted into |
| `quote_selector_comment_quote_all` | `.field--name-comment-body` | comment body to copy |
| `quote_selector_node_quote_all` | `.field--name-body` | node body to copy |
| `quote_selector_node_author` | `.node__meta` | node author name source |
| `quote_selector_comment_author` | `.comment__author` | comment author name source |
| `quote_limit` | `400` | max characters quoted |
| `quote_html_tags_support` | `false` | keep HTML tags in the quote |

## Reply-and-quote-all flow
`hook_form_alter` reads `?comment-quote-all-reply=<cid>`, loads that comment and pre-fills the reply body with a `<blockquote>` of it (truncated to `quote_limit`).
