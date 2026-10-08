<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How it works (mechanism) + extending it

The module is two small services plus a set of hooks in `media_parent_entity_link.module`.
No plugins, no config entity of its own.

## The render-time behavior

`hook_media_media_view()` (implements `hook_ENTITY_TYPE_view` for `media`) runs when a media
entity is rendered. For each display component whose formatter is in the supported list and
whose `third_party_settings.media_parent_entity_link.link_to_parent` is set, it:

1. Confirms the media is being rendered as a referenced item — `$entity->_referringItem` is set.
2. Walks up to the **parent (referencing) entity**:
   `$entity->_referringItem->getParent()->getParent()->getValue()`.
3. If that parent exists, is not new, and has a URL (`$parent->toUrl()`), it sets each rendered
   image item's `#url` to that parent URL via `_media_parent_entity_link_set_url()` — overriding
   whatever link the formatter itself would have produced.

It handles both plain field rendering (`$build[$field]['#items']`) and **Layout Builder**
(iterates `_layout_builder` sections/regions to find the matching component).

## Cache correctness

`hook_entity_build_defaults_alter()` adds a `media_parent_entity` **cache context** keyed
`media_parent_entity:<parent_bundle>-<parent_id>` whenever a link-to-parent component is present,
so the same media renders (and caches) a different link per referencing parent. The context
service is `cache_context.media_parent_entity`.

## Supported formatters + the alter hook

`InitialSettingsService` (service `media_parent_entity_link.initial`) holds the default
supported formatter ids `['image', 'responsive_image']` and invokes an alter hook so other
modules can add formatters that are compatible with the implementation:

```php
/**
 * Implements hook_media_parent_entity_link_alter_formatters().
 */
function mymodule_media_parent_entity_link_alter_formatters(&$formatters) {
  $formatters[] = 'blazy';
}
```

(See `media_parent_entity_link.api.php`. Note the doc warns you must verify the formatter is
actually compatible — not every formatter will honor the injected `#url`.)

## Summary form hooks

`hook_field_formatter_third_party_settings_form()` adds the checkbox (media + `image` field +
supported formatter), and `hook_field_formatter_settings_summary_alter()` appends
"Link to parent entity (if media has a parent)" to the formatter summary when it is on.
