<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Scope settings

Each scope dimension is a plugin (see [../plugins/scope.md](../plugins/scope.md)) with its own
config object **`ai_context.scope_settings.<id>`**. The overview form
`ai_context.settings.scope` (`Form\AiContextScopeOverviewForm`) enables/disables scopes; per-scope
settings appear as derived local-task tabs (`Plugin\Derivative\AiContextScopeLocalTask`) backed by
`Form\AiContextScopeSettingsFormBase`.

## Shipped scopes and their config

| Scope id | Config object | Extra keys | Purpose |
|---|---|---|---|
| `global` | `ai_context.scope_settings.global` | `enabled` | Item applies to every agent (capped by `max_global_items`). |
| `use_case` | `ai_context.scope_settings.use_case` | `enabled` | Predefined use cases (e.g. writing text). |
| `language` | `ai_context.scope_settings.language` | `enabled` | Target specific langcodes. |
| `tag` | `ai_context.scope_settings.tag` | `enabled` | `ai_context_tags` vocabulary terms. |
| `site_section` | `ai_context.scope_settings.site_section` | `enabled`, `sections[]{id,label,patterns[]}` | Path-pattern site sections, e.g. `/blog/*`. |
| `taxonomy` | `ai_context.scope_settings.taxonomy` | `enabled` | Match by taxonomy term. |
| `entity_type` | `ai_context.scope_settings.entity_type` | `enabled`, `entity_types[]` | Bind to whole entity types. |
| `entity_item` | `ai_context.scope_settings.entity_item` | `enabled`, `entity_item_types[]` | Bind to specific entity items (needs `dynamic_entity_reference`; auto-hidden otherwise via `hook_ai_context_scope_info_alter`). |

Only `global` and `use_case` ship enabled by default (`config/install/`). `global` and `use_case`
have no additional keys beyond `enabled`; the others carry the extra keys above.

## How matching works at runtime

`Service\AiContextScopeResolver` (service `ai_context.scope_resolver`) indexes each item's stored
scope values (`Service\AiContextScopeIndexService`, a DB index) and, at selection time:
`prefilterItemIdsByScope()` narrows candidates, `filterByCurrentContext()` /
`matchesCurrentContext()` drop items that don't match the current route/entity/language, and
`scoreAndSort()` ranks the rest by scope weight (`AiContextScope::$weight`). The current entity is
resolved by `Service\AiContextCurrentEntityResolver`; language by `Service\AiContextLanguageService`.

## Set via drush

```bash
ddev drush config:set ai_context.scope_settings.language enabled true -y
ddev drush config:set ai_context.scope_settings.site_section enabled true -y
```

```php
\Drupal::configFactory()->getEditable('ai_context.scope_settings.site_section')
  ->set('enabled', TRUE)
  ->set('sections', [
    ['id' => 'blog', 'label' => 'Blog', 'patterns' => ['/blog/*']],
  ])->save();
```

Disabling a scope triggers `EventSubscriber\AiContextScopeConfigSubscriber` →
`Service\AiContextScopeCleanupService`, which prunes now-orphaned scope values from items and the
index. An item's stored scope values live in its `scope` map field — see
[../fields/entities.md](../fields/entities.md).
