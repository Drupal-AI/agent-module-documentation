# How enforcement works — LayoutParagraphsAllowedTypesEvent subscriber

**Service:** `layout_paragraphs_limit.allowed_types_subscriber` →
`Drupal\layout_paragraphs_limit\EventSubscriber\LayoutParagraphsLimitAllowedTypesSubscriber`
(arg `@config.factory`). It subscribes to
`Drupal\layout_paragraphs\Event\LayoutParagraphsAllowedTypesEvent` (`EVENT_NAME`), which
Layout Paragraphs dispatches while building the list of Paragraph types offered in a region's
"add component" menu.

## Logic (`typeRestrictions()`)

1. From the event it reads the parent component's UUID, the target `region`, and the parent
   component's `layout` setting (`$parent->getSettings()['layout']`). If there is no parent,
   no layout, or no region, it returns without changing anything.
2. It loads `layout_paragraphs_limit.settings` → `disallowed_types[$layout][$region]`.
3. **Type filtering** (only if `paragraph_types` is non-empty):
   - `negate` empty/false → `array_diff_key(event types, checked types)` — the checked types
     are **removed** (exclude mode).
   - `negate` true → `array_intersect_key(event types, checked types)` — only the checked
     types **remain** (include mode).
   - The result is written back via `$event->setTypes($allowed)`.
4. **Numeric limit** (`numeric_limit` > 0): it counts the components already in that region
   (`getLayoutSection()->getComponentsForRegion($region)`); if the count is `>= numeric_limit`
   it calls `$event->setTypes([])`, allowing nothing further.

The filter runs only for the layout id + region key matching a configured entry; unconfigured
regions are untouched. Because it operates on the event's allowed-types list, the effect is
purely on the editing UI (which types the editor may add / move into the region) — it does not
alter or delete already-stored paragraphs.

There is no public API to call; you drive behavior entirely through the
`layout_paragraphs_limit.settings` config (see [../configure/settings.md](../configure/settings.md)).
The module exposes no hooks and defines no plugin types.
