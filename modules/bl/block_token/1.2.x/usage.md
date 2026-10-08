Block Token lets you flag any configured block to expose a `[block_token:<module>:<block_id>]` token, so the block's rendered output can be embedded inside text-format content via the Token Filter module.

---

On the block configuration form (`block_token_form_block_form_alter`), users with `administer block token` get a "Create the token for this block" checkbox stored in the block's `third_party_settings.block_token.token_value`. `block_token_blocks()` scans the `config` table for `block.block.*` entries that have that third-party setting and builds a token name `<provider_module>:<block_id>`. These are registered via `hook_token_info` under a `block_token` token type, and `hook_tokens` replaces `[block_token:<module>:<bid>]` by loading the block and rendering it through the block view builder (`block_token_block_render`). Combined with Token Filter's "Replace tokens" text-format filter, this means an editor can drop a block into body/other formatted fields and have it rendered inline. The module also defines a `RouteSubscriber` that replaces the access requirements on the core block edit form and block listing routes with its own callback `block_token_route_access()`. There is no dedicated settings page (`configure` null) and no config schema; the only permission is `administer block token`.

---

- Embed a configured block inside a node's body or other formatted text field.
- Reuse a menu, view, or custom block inside WYSIWYG content via a token.
- Let content editors place blocks in-line without using Layout Builder or block regions.
- Expose only selected blocks as tokens (per-block opt-in checkbox).
- Show the token string for a block on its edit form for easy copy/paste.
- Render a "call to action" or promo block within article text.
- Insert a search block or newsletter signup block mid-content.
- Combine with Token Filter to allow tokens (including block tokens) in a specific text format.
- Provide reusable content snippets as blocks and drop them into many pages by token.
- Embed a system/navigation block inside a static page's body.
- Keep embedded content DRY: edit the block once, updates appear everywhere the token is used.
- Build landing pages in the body field that pull in existing blocks.
- Reference blocks by a stable `<module>:<id>` token name in editorial content.
- Delegate block-token toggling to a dedicated role via the `administer block token` permission.
- Add dynamic (view-backed) blocks into otherwise static formatted text.
