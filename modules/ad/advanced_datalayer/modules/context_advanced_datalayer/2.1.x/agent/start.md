# Context Advanced Datalayer — agent index

Bridges **Context** and **Advanced Datalayer**: a Context reaction lets you set GTM dataLayer
tag values conditionally (by path/role/entity/etc.). Depends on `context` + `advanced_datalayer`.
No routes, permissions, services, or config schema of its own.

- **The `context_advanced_datalayer` Context reaction: where values are stored and how they
  reach the dataLayer** → [configure/context-reaction.md](configure/context-reaction.md)

Key facts:
- Plugin: `@ContextReaction(id = "context_advanced_datalayer")`, class
  `\Drupal\context_advanced_datalayer\Plugin\ContextReaction\ContextAdvancedDatalayer`.
- Values stored at `context.context.<name>.reactions.context_advanced_datalayer` as a
  `tag_id => value` map (config form built from `advanced_datalayer.manager->form()`).
- `hook_advanced_datalayer_alter()` merges every **active** reaction's values into the
  datalayer before it is pushed (via `context.manager->getActiveReactions('context_advanced_datalayer')`).
- Sets module weight to 1000 on install so it runs after Context.
- Tag ids come from the Advanced Datalayer tag plugins (see the `example_advanced_datalayer`
  submodule for a ready set).
