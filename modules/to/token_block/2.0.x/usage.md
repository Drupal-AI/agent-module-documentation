Token Block provides a single configurable block plugin ("Token Block") whose body text is run through the Token module's `[token]` replacement at render time, so you can place blocks that show dynamic values like the site name, current date, or the current node's fields.

---

The module defines one block plugin, `token_block` (`src/Plugin/Block/TokenBlock.php`, category "Token Block"). Its config form is a single `text_format` field ("Body") pinned to the `full_html` format, plus a "Browse available tokens" tree link. On render, `build()` takes the stored body **value** and calls `\Drupal::token()->replace()` on it, returning the result as `#markup`. Note it does **not** run the stored text format's filters — the selected format is ignored at render; the token-replaced string is emitted directly as `#markup` (which Drupal passes through `Xss::filterAdmin()`, stripping `<script>`/event handlers but allowing most admin HTML). Cache metadata is customised: `getCacheContexts()` adds `url.path`, `url.query_args`, `languages`, `route`; `getCacheTags()` adds `node:<id>` when a node is present on the route, so a block using node tokens invalidates with that node. The block is placed and configured entirely through core Block Layout (`configure` is null — no dedicated settings page) and stores its body in the block config entity (schema `block.settings.token_block`). Depends on the Token module. Supports block translation.

---

- Show a dynamic copyright line like `Copyright - [date:custom:Y]` in the footer.
- Display the site name (`[site:name]`) or slogan (`[site:slogan]`) in a block.
- Render the current node's title (`[node:title]`) or author (`[node:author]`) in a placed block.
- Show the logged-in user's name (`[current-user:display-name]`) in a greeting block.
- Build a "last updated" block from `[node:changed:medium]`.
- Place per-region dynamic text without writing a custom block plugin.
- Combine static markup and tokens (e.g. a styled banner with `[site:name]`).
- Show taxonomy or field tokens for the node being viewed.
- Provide translated token blocks (block translation is supported).
- Insert the current date/time via `[date:*]` tokens.
- Surface a mail-to or URL built from `[site:*]` / `[current-page:url]` tokens.
- Add a quick contextual note that varies by route (block re-renders per URL path/query).
- Reuse any token exposed by contrib modules that integrate with Token.
- Create a promotional block whose text references site configuration tokens.
- Show the current page title via `[current-page:title]`.
- Display node field values in a sidebar block on node pages.
- Build a footer legal block that pulls the organisation name from a site token.
- Provide editors a token-aware block they configure from Block Layout with a token browser link.
- Cache-correctly invalidate a node-token block when its node changes (adds `node:<id>` tag).
- Serve different block output per language using language-aware tokens.
