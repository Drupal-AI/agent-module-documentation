<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Deep Reference — token API

Everything the module does lives in `ai_dr.module` (procedural token hooks). There is no config,
no UI, and nothing to set up beyond enabling the module.

## Install & enable

```bash
composer require drupal/ai_dr
drush en ai_dr -y
```

Requires the contrib **Token** module (`drupal/token:^1.0`); Drupal core `^10 || ^11`. The AI
module is recommended for the intended use case but is not a hard dependency.

## The tokens

### `[term:description]`

Registered by `ai_dr_token_info()` under a `term` token type (`needs-data => 'term'`).
`ai_dr_tokens()` returns `$data['term']->getDescription() ?? ''` for the `description` name.

Note: Drupal core's own taxonomy token layer (`TaxonomyTokensHooks`) already provides a
`[term:description]` token. When both run against the same replacement, the core implementation
also writes this key, so which value survives depends on hook-implementation ordering. Treat
`[node:term-description:FIELD_NAME]` below as this module's distinctive, always-active token.

### `[node:term-description:FIELD_NAME]` (dynamic)

Registered by `ai_dr_token_info()` and re-surfaced onto the `node` token group by
`ai_dr_token_info_alter()` (so the token browser shows it with the hint
`[node:term-description:field_name]`).

Replacement logic in `ai_dr_tokens()` for `$type === 'node'`:

1. Match token names starting with `term-description:`; the remainder is `$field_name`.
2. If `$node->hasField($field_name)` and the field is not empty:
3. Loop `$node->get($field_name)->referencedEntities()`; for each entity that is a
   `\Drupal\taxonomy\TermInterface`, collect `$term->getDescription() ?? ''`.
4. Return `implode("\n\n", array_filter($descriptions))` — the non-empty descriptions joined by a
   blank line.

`FIELD_NAME` is any entity-reference field on the node that points at taxonomy terms
(e.g. `field_color`, `field_characters`). Non-term referenced entities are skipped.

## Using it in a prompt

The README's worked example (a Dungeons & Dragons scene illustrator):

```text
Setting: [node:field_scene], [node:field_scene:entity:description]

Characters: [node:field_characters]:
- [node:field_characters:0:entity:description]
- [node:field_characters:1:entity:description]

Description: [node:field_description]
```

Here `[node:FIELD:entity:description]` is core's chained token to one referenced term's description;
`[node:term-description:FIELD]` is this module's flat token that returns *all* referenced terms'
descriptions from a field at once. Both are resolved by `\Drupal::token()->replace()` /
`Token::replace()` wherever your workflow assembles prompt text (AI Automator, custom code, Views,
mail, metatags, etc.).

## Surface summary

- No routes, no `*.permissions.yml`, no `*.services.yml`, no `*.routing.yml`, no `config/`.
- No config schema (`provides_config_schema` is false — the module has no configuration).
- Behaviour is entirely determined by the tokens above; enabling the module is the only step.
