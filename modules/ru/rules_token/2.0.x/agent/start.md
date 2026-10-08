# Rules Token — agent index

Adds Token support to Rules: one action + two conditions that resolve/compare tokens. No config
page (`configure` null), no permissions, no schema, no Drush. Requires `rules` and `token`.

- **The three Rules plugins (ids, contexts, operators, entity-token handling) and how to use them** →
  [configure/rules.md](configure/rules.md)

Key facts:
- Action `rules_token_get_token_value` → provides `token_value`.
- Conditions `rules_token_compare_data_with_token`, `rules_token_compare_token_with_token`.
- Token replacement uses `\Drupal::token()->replace($token, $data, ['clear' => TRUE])`.
- "Entity of Token" context: required only for context-bound tokens (`[node:...]`, `[webform_submission:...]`); leave empty for global tokens (`[date:...]`, `[site:...]`).
- These are consumed through the Rules UI (config entities), not implemented by other modules.
