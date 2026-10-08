<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Quote adds "quote" links below nodes and comments; clicking one inserts the source text into a new comment (or reply) form so users can respond to specific content.

---

The module is driven by hook implementations in `QuoteHooks` (autowired service). `hook_node_links_alter` and `hook_comment_links_alter` add up to four link variants — *quote selected*, *quote all*, *reply and quote all*, *reply and quote selected* — but only when the entity/comment's bundle is enabled in config, comments are open, and the current user has both `post comments` and the `use quote` permission. The links attach `js/quote.js` plus `drupalSettings` that tell the JavaScript which CSS selectors identify the comment textarea, the node/comment body, and the author name, whether CKEditor 5 support is enabled, a character `quote_limit`, and whether raw HTML tags are allowed; the JS copies the selected or full body (optionally the author) into the comment field. The "reply and quote all" variant links to the core comment reply route with a `comment-quote-all-reply` query parameter; `hook_form_alter` then pre-fills the reply form's body with a `<blockquote>` of that comment (truncated to `quote_limit`). A settings form at `/admin/config/content/quote` (permission `administer quote`) controls the enabled modes, allowed content types, comment quoting, CKEditor support, selectors, limit, and HTML-tag support, and flushes caches on save.

Typical setup is to enable the module, grant `use quote` to commenting roles, and on the settings form choose which content types allow quoting and which quote modes to expose. In the reply-and-quote-all flow, `hook_form_alter` loads the comment named by the `comment-quote-all-reply` query parameter and pre-fills the reply body from it; the text is placed as a text-format widget default value (filtered on submit) and the author name is escaped via `t()`.

---
- Add a "quote" link below comments in a discussion.
- Add a "quote" link below nodes of selected content types.
- Let users quote the full body of a post into a reply.
- Let users quote only their selected text into a comment.
- Offer a "reply and quote all" action on comments.
- Offer a "reply and quote selected" action on comments.
- Restrict quoting to specific content types.
- Enable or disable quoting on comments separately from nodes.
- Require the `use quote` permission to see quote links.
- Enable CKEditor 5 support so quotes insert into the rich editor.
- Set a character limit on how much text is quoted.
- Allow or strip HTML tags in the quoted text.
- Customize the CSS selector for the comment textarea.
- Customize the selector for the node/comment body to quote.
- Customize the selector for the node/comment author name.
- Prepend the original author's name to the quote.
- Wrap "reply and quote all" text in a blockquote automatically.
- Restrict configuration to admins via `administer quote`.
- Build forum-style threaded discussions with quoting.
- Encourage contextual replies on article comment threads.
