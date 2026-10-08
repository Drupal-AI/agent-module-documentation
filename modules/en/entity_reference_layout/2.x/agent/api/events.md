# ERL — events & code integration

## Events (`src/Event/`)
| Event | Constant / name | Purpose |
|---|---|---|
| `ErlMergeAttributesEvent` | dispatched by `entity_reference_layout_merge_attributes()` | Add/adjust the `$attributes` merged onto a rendered layout section. Carries `$attributes` and `$layout_options`. Subscribe to add container classes/data at render time. |
| `ErlPropertiesFormEvent` | `erl_properties_form` | Fired while the section layout-options form is built; receives the `$form` (by reference) and `$formDefaults` so you can add fields to the per-section properties form. |

Subscribe with a normal event subscriber service tagged `event_subscriber`.

## Field value structure
`EntityReferenceLayoutRevisioned` (extends `EntityReferenceRevisionsItem`) adds properties:
`region` (string), `layout` (string, the Layout Discovery plugin id), `section_id` (int),
`options` (any — includes `container_classes`, `bg_color`), `config` (any — layout plugin
configuration). The list class is `EntityReferenceLayoutRevisionsFieldItemList`.

## Rendering
`EntityReferenceLayoutFormatter::buildLayoutTree()` walks items in order: an item with a
`layout` value opens a section (`buildLayoutContainer`, instantiating the layout plugin and its
regions); subsequent items with a `region` are placed into that section's region; each
paragraph is rendered via `buildEntityView()` (its view mode) with an `#access` check. Recursion
is capped at depth 20.

## Other integration points
- `EntityReferenceLayoutItemNormalizer` (`src/Normalizer/`) — serialize/normalize the ERL field
  item (e.g. for JSON:API/REST).
- `ErlStateResetCommand` (`src/Ajax/`) — custom AJAX command used by the widget.
- `ReplicateFieldSubscriber` (`src/EventSubscriber/`) — fixes ERL fields when cloning entities
  via the Replicate module.
- `EntityReferenceLayoutServiceProvider` — service alterations at container-build time.
