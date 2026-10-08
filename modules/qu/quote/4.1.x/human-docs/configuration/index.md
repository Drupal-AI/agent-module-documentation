# Configuration

Open the settings form at **Configuration → Content authoring → Quote**
(`/admin/config/content/quote`). You need the **administer quote** permission to
reach it. Saving the form flushes all caches, so expect a brief pause after each
save.

## Quote modes — which links appear

Tick the quote link variants you want to offer:

- **Quote selected** — copies only the text the user has highlighted.
- **Quote all** — copies the entire body.
- **Reply and quote all** — comment‑only; opens the core reply form pre‑filled with
  a blockquote of the comment.
- **Reply and quote selected** — comment‑only; replies with the highlighted text.

## Where quoting is allowed

- **Allowed content types** — check the node types on which quoting is enabled. A
  quote link only appears on these types.
- **Allow quoting on comments** — additionally show quote links on comments (only
  where the node type itself allows quoting).

Remember the runtime rules: a link shows only when the type is enabled, comments are
open, and the user has both **post comments** and **use quote**.

## CKEditor 5 support

- **CKEditor 5 support** — when enabled and the core **CKEditor 5** module is
  present, the editor takes priority so the quoted text is inserted into the rich
  editor rather than a plain textarea. This option is unavailable unless CKEditor 5
  is enabled.

## Quote text options

- **Quote limit** — the maximum number of characters copied into the quote
  (default **400**).
- **Keep HTML tags** — whether HTML tags are preserved in the quoted text or
  stripped (off by default).
- **Prepend the author's name** — optionally add the original author's name to the
  quote. The author name is escaped when rendered.

## CSS selectors (advanced)

The JavaScript uses CSS selectors to find the relevant elements on the page. The
defaults suit standard themes; change them only if your theme uses different markup:

- **Comment textarea** — where the quote is inserted (default `#comment-form textarea`).
- **Comment body to copy** (default `.field--name-comment-body`).
- **Node body to copy** (default `.field--name-body`).
- **Node author source** (default `.node__meta`).
- **Comment author source** (default `.comment__author`).

## Save

Click **Save configuration**. Caches are flushed automatically, and the new quote
links and options take effect right away.
