<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Tokens (token_custom) — agent index

Define your own reusable tokens. Each token stores formatted content and resolves as
`[<type>:<machine_name>]` wherever Drupal's Token API runs. Two entity types:
`token_custom` (content entity, the tokens) and `token_custom_type` (config bundle entity,
the token *types*; default type `custom`). Depends on `token`, `filter`, `text`.

- **Create/manage tokens and types (UI, config, and in code)** →
  [configure/tokens.md](configure/tokens.md)
- **How replacement works (hook_token_info / hook_tokens, allowlist, formats)** →
  [api/mechanism.md](api/mechanism.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)

Key facts: manage at `/admin/structure/token-custom` (configure route
`entity.token_custom.collection`). A token entity has `machine_name`, `name`, `type` (bundle),
`description`, `content` (text_long value + `format`). Programmatic:
`TokenCustom::create(['machine_name'=>'x','name'=>'X','type'=>'custom','content'=>['value'=>'…','format'=>'plain_text']])->save();`
then `\Drupal::token()->replace('[custom:x]')`.
