<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# View mode page — services

| Service | Class | Purpose |
|---|---|---|
| `view_mode_page.path_processor` | `PathProcessor\DynamicPathProcessor` | Inbound + outbound path processor (priority 250). Rewrites request paths matching a pattern's `%`-based pattern to the internal route `view_mode_page.display_entity`, and rewrites outbound URLs back. Args: `@path_alias.manager`, `@entity_type.manager`, `@view_mode_page.repository.pattern`, `@language_manager`. |
| `view_mode_page.repository.pattern` | `Repository\ViewmodepagePatternRepository` | Loads/queries the `view_mode_page_pattern` config entities. Arg: `@entity_type.manager`. |
| `view_mode_page.manager.alias_type` | `AliasTypeManager` | Plugin manager for `@AliasType` plugins (see plugins/alias-type.md). |

## Internal route

`view_mode_page.display_entity` → `/view_mode_page/{view_mode}/{entity_type}/{entity_id}`
(controller `MainController::displayEntity`, permission `access content`). You normally never link
this directly; the path processor targets it. The controller clones the current request, matches the
entity's canonical internal path, injects `view_mode`, and returns a `SUB_REQUEST` response so the
entity renders inline in that view mode.

## Programmatic pattern access

```php
// Load all patterns (config entities):
$patterns = \Drupal::entityTypeManager()->getStorage('view_mode_page_pattern')->loadMultiple();
foreach ($patterns as $p) {
  $p->id(); $p->get('pattern'); $p->get('view_mode'); $p->get('type');
}
```

There are no public hooks beyond the AliasType plugin type; `hook_block_build_alter()` in the module
only adds the `url.path` cache context to the system main block.
