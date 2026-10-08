# Block Token — agent index

Flags blocks to expose a `[block_token:<module>:<block_id>]` token whose replacement is the
block's rendered HTML, for embedding blocks in text-format content via Token Filter. Depends on
`block`, `token`, `token_filter`. Provides one permission; no config page (`configure` null), no
schema, no Drush, no plugin managers.

- **Enable the filter, flag a block, token format, how rendering works** →
  [configure/tokens.md](configure/tokens.md)
- **`administer block token` and the block-route access override** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Opt-in per block: checkbox on the block form (users with `administer block token`) →
  `third_party_settings.block_token.token_value`. Token name = `<provider>:<block_id>`.
- `hook_tokens` → `block_token_block_render($bid)` renders the block via the block view builder;
  used with Token Filter's "Replace tokens" filter to inline blocks in formatted text.
- `block_token_blocks()` scans the `config` table for flagged `block.block.*` (uses
  `unserialize(..., ['allowed_classes' => FALSE])` — safe).
- **Route override:** `RouteSubscriber` replaces access on `entity.block.edit_form` and
  `block.admin_display_theme` with `block_token_route_access()` → allowed for `administer block
  token` or `administer taxonomy`.
