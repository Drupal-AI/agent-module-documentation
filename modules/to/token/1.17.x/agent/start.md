# token — agent start

Token API UI + missing core tokens. No config screen, no permissions. Just enable it;
other modules and your forms consume it.

- Embed a token browser in a form → [api/token-tree-ui.md](api/token-tree-ui.md)
- Call token services / helper functions → [api/token-service.md](api/token-service.md)
- Declare your own tokens (so they appear in the browser) → [extend/provide-tokens.md](extend/provide-tokens.md)
- Clear the token cache → [drush/cache-clear.md](drush/cache-clear.md)

Replacement itself is core: `\Drupal::token()->replace('[node:title]', ['node' => $node])`.
Browse the live tree at `/token/tree`.
