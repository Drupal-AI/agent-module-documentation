<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Deep Reference (ai_dr) — agent index

Registers Drupal **tokens** that expose taxonomy-term **description** text, including descriptions of
terms referenced from a node's entity-reference fields, for assembling AI prompts from tokens.

- **Version:** 1.0.x (1.0.0-alpha1)  •  **Core:** `^10 || ^11`  •  **Package:** AI  •  License GPL-2.0-or-later
- **Depends on:** `token` (contrib Token module) only. The AI module is *not* required.
- **Ships:** four procedural hooks in `ai_dr.module`. **No** routes, permissions, services, entities,
  plugins, config objects, config schema, Drush commands, or settings form.

## What it actually is (from source)

`ai_dr.module` implements:

- **`ai_dr_token_info()`** — declares token type `term` with token `description`, and a dynamic
  node token `term-description` (`'dynamic' => TRUE`).
- **`ai_dr_token_info_alter(&$info)`** — re-adds `term-description` onto the existing `node` token
  group so it appears in the token browser with usage hint `[node:term-description:field_name]`.
- **`ai_dr_tokens($type, $tokens, $data, $options, $bubbleable_metadata)`** — the replacement logic:
  - type `term`: token `description` → `$data['term']->getDescription() ?? ''`.
  - type `node`: any token name beginning `term-description:` → takes the suffix as a field name,
    and if the node has that non-empty field, iterates `->referencedEntities()`, keeps each
    `TermInterface`'s `getDescription() ?? ''`, and returns `implode("\n\n", array_filter($descriptions))`.
- **`ai_dr_help()`** — the `help.page.ai_dr` about text.

## Tokens provided

- `[term:description]` — a taxonomy term's description.
- `[node:term-description:FIELD_NAME]` — descriptions of every term referenced by `FIELD_NAME` on
  the node, joined by blank lines.
- (Core's chained `[node:FIELD:entity:description]` also reaches a single referenced term's
  processed description; see the README example. `term-description` is the module's own flat token.)

## Solution docs

- **The token API — every token, the replacement logic, install, and how to use it in prompts** →
  [api/tokens.md](api/tokens.md)
