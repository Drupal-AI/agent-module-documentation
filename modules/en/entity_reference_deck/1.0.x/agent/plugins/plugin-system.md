<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin system: actions, groups, meta items, and the builders

Three attribute-based plugin types, each with a `DefaultPluginManager` subclass declared in
`entity_reference_deck.services.yml` (`autowire: true`, `parent: default_plugin_manager`). All
discovery caches under a dedicated cache key and runs an `alterInfo()` hook.

## Action plugins (toolbar buttons/tags)

- Directory `src/Plugin/EntityReferenceDeckAction`; attribute
  `Attribute/EntityReferenceDeckAction` (`id`, `label`, `group='default'`, `weight=0`,
  `enabled=TRUE`, `deriver`); interface `EntityReferenceDeckActionInterface`; manager
  `EntityReferenceDeckActionManager` (alter `entity_reference_deck_action_info`).
- Interface methods: `applies(EntityInterface, EntityReferenceDeckContext): bool`,
  `build(...): ?array` (render array or NULL to omit), `weight(): int`, `group(): string`.
- Core plugin: **`moderation`** (`ModerationEntityReferenceDeckAction`, group `meta`, weight -10) —
  renders the `entity_reference_deck:status-tag` component; only `applies()` when
  `EntityReferenceDeckModerationStyle::resolve()` returns a tint. Base class
  `Plugin/EntityReferenceDeckAction/EntityReferenceDeckActionBase`.

## Group plugins (toolbar group wrappers)

- Directory `src/Plugin/EntityReferenceDeckGroup`; attribute `Attribute/EntityReferenceDeckGroup`;
  interface `EntityReferenceDeckGroupInterface` with `element(): string` (custom tag, e.g. a Lit
  element) and `library(): string` (library to attach). Manager
  `EntityReferenceDeckGroupManager`. Base `Plugin/EntityReferenceDeckGroup/EntityReferenceDeckGroupBase`.
- Groups are *not* enumerated by a config list: the settings UI derives group rows from the
  distinct `group` values declared across discovered action plugins (see settings.md).

## Meta-item plugins (muted card lines)

- Directory `src/Plugin/EntityReferenceDeckMetaItem`; attribute
  `Attribute/EntityReferenceDeckMetaItem`; interface `EntityReferenceDeckMetaItemInterface`
  (`applies(entity, context, EntityReferenceDeckCardBag)`, `build(...): ?array` returning a list of
  render arrays, `weight()`). Manager `EntityReferenceDeckMetaItemManager`.
- Core plugins: **`timestamps`** (`TimestampsEntityReferenceDeckMetaItem`) and **`editor`**
  (`EditorEntityReferenceDeckMetaItem`), both enabled by default. `EntityReferenceDeckCardBag`
  carries shared per-card state (moderation result + a lazily-loaded "tip" revision entity).

## Builders (how a card is assembled)

- `EntityReferenceDeckCardBuilder::build(EntityInterface $entity, ?EntityReferenceDeckContext)` is
  the single entry point for every host. It resolves the card label (via
  `EntityReferenceDeckCardTypePresentationInterface`, falling back to `$entity->label()` /
  entity-type label), builds the icon/type/meta/toolbar slots, adds cache metadata (the entity, the
  tip entity, and `config:entity_reference_deck.settings`) and returns a
  `#type => component` / `#component => entity_reference_deck:erdeck-card` render array. It ends by
  invoking `hook_entity_reference_deck_card_alter()`.
- `EntityReferenceDeckBuilder::build()` collects action definitions, skips disabled ones
  (`$context->actionSettings()`), calls each plugin's `applies()`/`build()`, reserves an empty slot
  when an applicable action returns NULL, invokes `hook_entity_reference_deck_actions_alter()`,
  sorts by weight, and packs actions into group wrappers (a plain `div`, or the group plugin's
  custom element + library). The `meta` group is lifted out as a sibling chip; other groups sit in
  a gray `pill` container. CSS class names come from `EntityReferenceDeckCss`.
- `EntityReferenceDeckMetaBuilder::build()` does the equivalent for meta-item plugins and returns
  the meta render arrays plus the shared "tip" entity used for cacheability.
- `EntityReferenceDeckContext` is an immutable value object (view mode, host widget id, field name,
  host entity, resolved `settings`, `hasUnsavedChanges`, `showPreview`) with `withSettings()`,
  `withHasUnsavedChanges()`, `withShowPreview()` and per-plugin override accessors.

## Extending

Implement the relevant interface, add the attribute, drop the class under the matching
`Plugin/...` namespace of your own module — no service registration needed. Alter existing
definitions with `hook_entity_reference_deck_action_info_alter()` /
`_group_info_alter()` / `_meta_item_info_alter()`, or the built render arrays with
`hook_entity_reference_deck_actions_alter()` / `_meta_items_alter()` / `_card_alter()`
(signatures in `entity_reference_deck.api.php`).
