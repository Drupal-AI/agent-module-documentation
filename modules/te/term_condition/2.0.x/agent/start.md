<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Term Condition — agent index

Adds one **Condition plugin** (`id: term`) that passes when the contextual node/term
references a chosen taxonomy term. Used mainly for **block visibility**. No settings form,
no configure route, no permissions, no Drush. It defines no plugin *type* — it implements
core's Condition plugin type. Selected terms are stored as **UUIDs** under `term_uuids`.

- **Add/read the Term visibility condition on a block; config keys & storage** →
  [configure/term-condition.md](configure/term-condition.md)
- **How it evaluates (context, route fallback, referencedEntities, negation, empty config)** →
  [api/evaluation.md](api/evaluation.md)

Key fact: a placed block stores the rule at
`block.block.<id>` → `visibility.term.term_uuids: [<uuid>, …]` (plus `negate`,
`context_mapping.node: '@node.node_route_context:node'`). Matching is by term **UUID**,
not term ID (converted from tids by `term_condition_update_9201`).
