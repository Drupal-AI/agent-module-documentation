Insert Block provides a text-format filter that replaces `[block:BLOCK_ID]` placeholders in rich text with the rendered contents of a block, letting editors embed blocks inside node bodies (or any filtered text) without PHP snippets.

---

Insert Block ships a single filter plugin (`filter_insert_block`) that you enable per text format at Admin > Configuration > Content authoring > Text formats and editors. Once enabled, any occurrence of `[block:BLOCK_ID]` in text run through that format is scanned by a regular expression and swapped for the block's rendered markup. `BLOCK_ID` is a block **entity id**: the filter first tries to load a placed-block config entity (`block`) by that id, and if none matches it falls back to loading a content block (`block_content`, i.e. a custom block) by numeric id. A legacy Drupal-7-style `[block:module=delta]` form is tolerated — the part after `=` is used as the id. The filter has one setting, `check_roles` (default on): when enabled it honors a placed block's role-visibility conditions so blocks restricted to certain roles stay hidden from users who lack them; content blocks are always rendered. Cache tags and contexts from each rendered block are merged into the filter result so embedded blocks invalidate correctly. Because it is `TYPE_TRANSFORM_IRREVERSIBLE` the transformation is applied on display only and the raw `[block:...]` tag is preserved in stored content. The module depends only on core `block` and `filter`, adds no routes, permissions, services, or Drush commands, and exposes its one setting through core's filter configuration UI.

---

- Embed a "recent posts" or "popular content" sidebar block directly into the middle of an article body.
- Reuse a custom (content) block — such as a call-to-action or promo — across many nodes by pasting `[block:5]` instead of copying markup.
- Insert a menu block into page content where the theme has no region for it.
- Drop a Views block (e.g. a listing of related items) into WYSIWYG content.
- Place a "subscribe to newsletter" block inside a landing-page body field.
- Show a contact or social-links block within a node's text.
- Insert a branding/site-logo block into arbitrary filtered text.
- Add a language-switcher block into the body of a specific page.
- Embed a search-form block mid-article.
- Reference a block by its config entity machine name, e.g. `[block:olivero_syndicate]`.
- Reference a custom block by numeric id, e.g. `[block:12]`, taken from its `/admin/content/block` edit URL.
- Keep role-restricted blocks hidden for unauthorized viewers by leaving the `check_roles` setting enabled.
- Force a role-restricted block to always render (ignore its role visibility) by disabling `check_roles` on that text format.
- Avoid insecure PHP-filter snippets by using a safe placeholder syntax instead.
- Compose newsletter/email body text that pulls in a shared block of boilerplate.
- Insert the same footer disclaimer block into many pieces of content via one tag.
- Enable block embedding only in a trusted "Full HTML" format while leaving basic formats without it.
- Migrate legacy Drupal 7 `[block:module=delta]` content and still resolve the id after the `=`.
- Embed multiple blocks in a single field — every matching `[block:...]` tag in the text is replaced.
- Use block cache tags so edited blocks automatically refresh in the content that embeds them.
- Provide editors a copy-pasteable snippet for standard promotional blocks without granting block-layout access.
- Insert a block into a comment or other entity's text field wherever the filter format is applied.
- Surface a "related links" or "downloads" block inline within documentation pages.
- Add an advertisement/marketing block into specific article bodies only.
