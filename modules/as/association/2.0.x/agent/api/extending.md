<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extending Entity Association

The README's "Extending" section maps to these four seams. Cite classes when implementing.

## 1. Behavior plugins (`@AssociationBehavior`)

Manager `plugin.manager.association.behavior` (`BehaviorPluginManager`, dir
`Plugin/Association/Behavior`). Implement `BehaviorInterface` (base `BehaviorBase`); usually also
`AssociationPluginFormInterface` for the config form. A behavior decides which entity type/bundle
"tags" are allowed, their cardinality/ordering, and provides a **manager builder** (constant
`manager_builder:` in the attribute, or implement `ManagerBuilderInterface`) that renders the manage
UI at `/association/{id}/manage`. Key methods: `isValidEntity($tag,$type,$bundle)`, `getTags()`,
`getTagInfo($tag)` (returns `cardinality` + `entity_types`), `createEntity()`, `createAccess()`,
`alterLink()`, `validateConfigUpdate()`.

Ships:
- `entity_list` (`EntityListBehavior`) — an unordered list of any configured entity type/bundle;
  cardinality unlimited; tag = `{entity_type}:{bundle}`.
- `entity_manifest` (`EntityManifestBehavior`) — structured "slots", each tag bound to specific
  entity type(s)/bundle(s) with its own cardinality; configured via `ConfigureManifestBehaviorForm`.

## 2. Landing-page handler plugins (`@AssociationLandingPage`)

Manager `plugin.manager.association.landing_page` (`LandingPagePluginManager`, dir
`Plugin/Association/LandingPage`). Implement `LandingPagePluginInterface` (base `LandingPagePluginBase`);
optionally `RevisionablePagePluginInterface`. Supplies `getPage($association)`, `getPageUrl()`,
`onCreate()`, `onPreDelete()`/`onPostDelete()`. Ships `none` (`None.php`) and `associated_entity`
(`AssociatedEntity.php`); the `association_page` submodule adds `association_page`.

## 3. Entity adapters (YAML)

Add `<yourmodule>.association.entity_adapter.yml`:

```yaml
node:
  label: Content (node)
  entity_type: node
  class: \Drupal\association\Adapter\EntityAdapter   # optional; default used if omitted
```

Discovered by `EntityAdapterManager` (Toolshed `YamlPluginManager`, service
`strategy.manager.association.entity_adapter`). The default `EntityAdapter` (`src/Adapter/EntityAdapter.php`,
implements `EntityAdapterInterface`) provides bundle listing, entity creation (restricted to allowed
bundles), form building, `checkAccess()` and `accessQueryAlter()`. Override the `class` for entity
types needing special creation values, form init, or access logic. The alter hook
`hook_association_entity_adapter_info_alter()` (dispatched as event `association_entity_adapter_alter`)
can adjust definitions.

## 4. Entity updaters

Command objects implementing `EntityUpdater\EntityUpdaterInterface`, run over association members when
an association is saved (via queue worker `association_linked_content_updater`,
`Plugin/QueueWorker/AssociatedEntityUpdater`). Ships `PathAliasUpdater` and `SearchApiUpdater` (each has
a static `applies()`). Register extra updaters from an event subscriber for
`AssociationEvents::ENTITY_UPDATER_ALTER` (`AssociatedEntityUpdaterAlterEvent`).

## 5. Association negotiators (tagged service)

Implement `AssociationNegotiatorInterface`; register with tag `association_negotiator` (optional
`priority`, lower = earlier; default is priority 0). The collector service `association.negotiator`
(`AssociationNegotiator`) resolves the "active association" `byRoute()` / `byEntity()` and caches
per-request. `DefaultAssociationNegotiator` resolves from route params (`association`,
`association_page`, or an associable entity's link) — matching route regex
`/^(entity|layout_builder.overrides)\.(association(?:_page)?)\.[a-z_]+$/`.

## Events (`Event/AssociationEvents.php`)

`ENTITY_UPDATER_ALTER`, `QUERY_ACCESS_ALTER` (alter the access WHERE conditions per adapter),
`INSERT_ASSOCIATED_FORM_ALTER` / `UPDATE_ASSOCIATED_FORM_ALTER` (`AssociatedEntityFormEvent`, fired
from `association_form_alter` when a member's add/edit form is built), and
`association_entity_adapter_alter`.

## Tokens

`association.tokens.inc` defines the `association` token type (`name`, `type`, and `path` when Pathauto
provides a `path` field) and chains `[<entity>:associations:*]` from any associable entity to its
association. All token values go through the Token API's replacement (escaped), not raw output.
