# Copyright Block — agent index

A single Block plugin that renders a copyright notice with an auto-updating year range. No
settings page (`configure: null`) — you configure it per block, plus a site-default config
object. Depends on core Token.

- **Place & configure the block, the `[copyright_statement:dates]` token, defaults** →
  [configure/block.md](configure/block.md)

Key facts:
- Block plugin id `copyright_block` (`src/Plugin/Block/CopyrightBlock.php`). Place at
  `/admin/structure/block`.
- Block form fields: `start_year` (number 1900–current), `separator` (string), `text`
  (`text_format`). Body rendered as `processed_text` with `token->replace(...)`.
- Token: type `copyright_statement`, token `dates` (`copyright_block.module`
  `hook_token_info`/`hook_tokens`). `[copyright_statement:dates]` → `start` if start==current,
  else `start<separator>current`. Resolves only within this block (needs its `config` context).
- Defaults in config `copyright_block.settings` (`separator: '-'`, `text.value: 'Copyright'`,
  `text.format: basic_html`). No permissions, no plugin types.
