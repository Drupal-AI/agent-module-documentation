# ib_dam_wysiwyg: deprecation & migration

This module is **deprecated** and should not be used on new sites. There is no configuration
UI (`configure` = null).

## The filter (no-op in 5.x)

`src/Plugin/Filter/IbDamWysiwygFilter.php`:

```php
@Filter(id = "ib_dam_wysiwyg", title = "IntelligenceBank DAM WYSIWYG", type = TYPE_MARKUP_LANGUAGE)
public function process($text, $langcode): FilterProcessResult {
  @trigger_error('ib_dam_wysiwyg text filter is deprecated …', E_USER_DEPRECATED);
  return new FilterProcessResult($text); // text returned unchanged
}
```

- Enabling the filter on a text format is still possible (stored at
  `filter.format.<id>` → `filters.ib_dam_wysiwyg.status: true`) but has **no effect** — the text
  passes through untouched.
- `hook_requirements('runtime')` adds a `REQUIREMENT_WARNING` telling you the module is deprecated.

## Migration: `ib_dam_wysiwyg_update_9000()`

The real value of the module now is the one-time upgrade path. The update hook:

1. Loads every `FilterFormat` and, where the `ib_dam_wysiwyg` filter is present, removes it and
   saves the format.
2. Scans `text` / `text_long` / `text_with_summary` fields for legacy inline IB JSON markup
   (`{"source_type":…}`), and for each match:
   - builds an `Asset` from the JSON, sets its source (`IbDamResourceModel`) and a MediaStorage
     storage type (via `ib_dam_media.media_type_matcher`),
   - saves a real `media` entity,
   - replaces the JSON with a `<drupal-media data-entity-type="media" data-entity-uuid="…">` tag.

Run it with `drush updatedb`. After migrating, embed IntelligenceBank assets via **ib_dam_media**
(the Media Library `ib_dam_embed` source) rather than this filter.
