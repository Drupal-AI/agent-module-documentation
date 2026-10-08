# Token Block — agent index

One block plugin (`token_block`) that renders token-replaced body text. No dedicated admin
page (`configure` null), no permissions, no Drush, no plugin types. Provides config schema
`block.settings.token_block`. Depends on `token`.

- **Placing the block, the body/token field, the ignored text format, `#markup` XSS behavior,
  and cache metadata** → [configure/block.md](configure/block.md)

Key facts:
- Plugin: `Drupal\token_block\Plugin\Block\TokenBlock` (id `token_block`, category "Token Block").
- `build()` = `\Drupal::token()->replace($config['body']['value'])` returned as `#markup`.
- The stored text format's filters are NOT applied; only `#markup`'s `Xss::filterAdmin()` runs.
- Configure only via core Block Layout; body stored in the block config entity.
