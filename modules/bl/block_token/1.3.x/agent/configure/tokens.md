# Configure Block Token

No settings page (`configure` null). Three steps.

## 1. Enable the "Replace tokens" filter on a text format
At **Admin » Configuration » Content authoring » Text formats**, enable Token Filter's
**Replace tokens** filter on the format(s) that should render block tokens. (Block Token supplies
the tokens; Token Filter does the in-text replacement.)

## 2. Flag a block to expose a token
Edit a block (`admin/structure/block/manage/<block>`). With `administer block token`, the form
shows **"Create the token for this block"** (`block_token_form_block_form_alter`). Check it and
save. This stores:

```yaml
# block.block.<id>
third_party_settings:
  block_token:
    token_value: true
```

The form then shows the token string. Token name = `<provider_module>:<block_id>` (the block's
last module dependency + its id), e.g. `system:navigation`.

## 3. Use the token in content
Insert into any field using a token-filter-enabled format:

```
[block_token:system:navigation]
```

## How replacement works
- `block_token_blocks()` selects all `block.block.*` rows from the `config` table whose data has
  `third_party_settings.block_token.token_value` set (data decoded with
  `unserialize($data, ['allowed_classes' => FALSE])`), building the token list.
- `hook_token_info` registers a `block_token` token type with one token per flagged block.
- `hook_tokens` resolves `[block_token:<module>:<bid>]` by calling `block_token_block_render($bid)`,
  which loads the block and renders it through the block **view builder** + renderer (standard,
  escaped render pipeline — not raw markup injection). A missing block logs a warning and yields ''.

## Notes
- Which block a token renders is fixed by the flagged block config (an admin action); the editor
  using the token only chooses *which flagged block* to embed, not its markup.
- The block renders with its normal access/visibility as produced by the view builder.
- Route access: enabling this module governs who can reach the block edit form and block listing
  via `block_token_route_access()` — see [../permissions/permissions.md](../permissions/permissions.md).
