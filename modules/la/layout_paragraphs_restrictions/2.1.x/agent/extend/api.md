# How enforcement works / extend it

The module is thin: no plugin types, no permissions, no config entity. It hooks into Layout
Paragraphs' existing "allowed types" event and adds a JS drag guard. To author rules, see
[../configure/restrictions.md](../configure/restrictions.md).

## Server-side: the allowed-types event subscriber
`src/EventSubscriber/LayoutParagraphsRestrictions.php` subscribes to
`\Drupal\layout_paragraphs\Event\LayoutParagraphsAllowedTypesEvent` (constant `EVENT_NAME`) at
priority **-100** (runs late). Its `typeRestrictions()` method:

1. Reads the current context from the event (`getContext()`), then enriches it — resolves
   `parent_type`/`layout` from the parent component, `sibling_type` from the sibling, defaults
   `region` to `_root`, and fills `field_name` / `entity_type` / `entity_bundle` from the
   Paragraphs reference field's host entity.
2. Iterates every rule in config `layout_paragraphs_restrictions.settings:restrictions`. A rule's
   `context` may be a single map or a numerically indexed list of maps (any-of).
3. For each context set, every key must match `$context` (with `!` negation supported). Only when
   **all** conditions in a set match does it apply the rule.
4. On match, it calls `$event->setTypes()` with `array_intersect_key()` for `components` (allow
   list) and `array_diff_key()` for `exclude_components` (deny list), shrinking the set of types
   offered in the add-component dialog.

Because this is a standard event subscriber, other modules can register their own subscriber to
the same `LayoutParagraphsAllowedTypesEvent` (different priority) to add or relax types
programmatically instead of via YAML.

## Client-side: drag-and-drop guard
`js/restrictions.js` (library `layout_paragraphs_restrictions/restrictions`, deps
`core/jquery` + `core/once`) mirrors the rules in the browser. The module's
`hook_preprocess_layout_paragraphs_builder()` (in the `.module` file) passes each layout's rules
to `drupalSettings.lpBuilder.restrictions[layoutId]` and stamps data attributes on the builder
markup (`data-lp-reference-field`, `data-lp-entity-type`, `data-lp-entity-bundle`);
`hook_preprocess_paragraph()` adds `data-lp-component-type` (bundle, plus `__<variation>` when a
component variation style option is set). The JS:

- Registers a `Drupal.registerLpbMoveError` callback that recomputes the context from DOM data
  attributes and returns `"This component cannot be moved here."` when a move violates an allow or
  exclude list.
- Supports a `transform` map on a rule: on `lpb-component:move` / `lpb-component:drop`, if a
  dropped type matches a transform source (a trailing `*` is treated as a prefix match), it sets
  `data-lp-transform` and calls the transform route instead of rejecting the drop.

## Transform controller (variation morphing)
`src/Controller/TransformComponentController.php` serves route
`layout_paragraphs_restrictions.builder.transform_item`
(`/layout-paragraphs-restrictions/transform/{layout_paragraphs_layout}/{component_uuid}/{variation}`),
guarded by `_layout_paragraphs_builder_access: 'TRUE'` and using the layout tempstore. It loads
the component, rewrites its `style_options[*]['component_variation']` behavior setting to the new
`variation`, saves the layout to tempstore (and to Mercury Editor context if that service exists),
and returns an AJAX `ReplaceCommand` re-render of the component (or full layout when a refresh is
needed) plus a `component:update` event. The class notes it is a near-copy of Layout Paragraphs'
`DuplicateController`.

## Config schema
`config/schema/layout_paragraph_restrictions.schema.yml` types
`layout_paragraphs_restrictions.settings` as a sequence of free-form objects (the rule set is
open-ended YAML, so individual keys are not strictly typed).
