# Hooks implemented

All in `entity_translation_sync.module`. These matter to integrators who add custom entity types or
want the sync entry point to appear.

| Hook | What it does |
|---|---|
| `hook_entity_type_alter` | For each entity type present in `entity_translation_sync.settings:entity_types` that has a `canonical` link template and does not yet have `drupal:entity-translation-sync`, adds the link template `drupal:entity-translation-sync` = `<canonical>/entity-translation-sync`. This is the anchor the route subscriber and tab derivative key off. **A custom entity type must expose a `canonical` link template to be syncable.** |
| `hook_entity_operation` | Adds an `entity_translation_sync` operation (title "Entity translation sync", weight 50, url = the entity's `drupal:entity-translation-sync` link) to an entity's operation list when: its type+bundle is enabled in config, it has the link template, and the current user holds `synchronize any entity translation` OR `synchronize <type> translation`. |
| `hook_help` | Returns a one-paragraph description on `help.page.entity_translation_sync`. |

## Notes for integrators

- The per-entity sync route (`entity.<entity_type_id>.entity_translation_sync`) and the "Entity
  translation sync" **local task tab** are not defined statically — they are built at runtime from config
  by `EntityTranslationSyncRouteSubscriber` and the `EntityTranslationSyncLocalTasks` deriver
  respectively. Enabling a new entity type therefore requires a **cache rebuild** before the route, tab
  and operation appear.
- There are no hooks *invoked* by this module for others to implement (no alter hooks, no events emitted).
  The only event subscription is the internal `RoutingEvents::ALTER` handler above.
