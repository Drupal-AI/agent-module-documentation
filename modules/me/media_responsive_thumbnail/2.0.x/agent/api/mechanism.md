<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How it works (mechanism)

The whole module is one class,
`Drupal\media_responsive_thumbnail\Plugin\Field\FieldFormatter\MediaResponsiveThumbnailFormatter`,
extending `Drupal\responsive_image\Plugin\Field\FieldFormatter\ResponsiveImageFormatter`. There
is no service, no plugin manager, no hooks — just an overridden formatter plugin plus a
one-line config schema alias.

## What it overrides from `ResponsiveImageFormatter`

- **`isApplicable()`** — restricts the formatter to entity-reference fields whose field
  storage `target_type` setting is `media` (core's `ResponsiveImageFormatter` itself only
  applies to `image` fields; this class instead declares `field_types: {entity_reference}`
  and narrows further here).
- **`needsEntityLoad()`** — overridden to `!$item->hasNewEntity()`. This exists because the
  formatter chain (`FileFormatterBase`) otherwise calls `isDisplayed()` on the field item,
  which `EntityReferenceItem` does not implement — without this override the formatter would
  fatal on Media reference fields.
- **`viewElements()`** — for each referenced media entity: gets the media type's *source
  field* (`$file->getSource()->getConfiguration()['source_field']`, e.g. `field_media_image`
  for the core Image media type) and uses that field's first value **if it is non-empty**;
  otherwise falls back to the media entity's own `thumbnail` field. That image item is
  rendered via the `#theme: responsive_image_formatter` element (same theme hook core's
  Responsive Image formatter uses) with the configured `responsive_image_style_id`.
- **`getMediaThumbnailUrl()`** — computes the optional link target: `image_link: content`
  links to the entity that owns the field (translated if applicable); `image_link: media`
  links to the media item's own canonical URL. Any other value (including the inherited
  form's `file` option) yields no link.
- **`checkAccess()`** — ANDs the referenced media entity's own `view` access with whatever
  `ResponsiveImageFormatter`/`ImageFormatterBase` already checks, so a media item the current
  user cannot view is not rendered.
- **`settingsSummary()`** — appends "Linked to content" / "Linked to media item" (module-
  specific labels; core's version says "Linked to file").
- **`settingsForm()`** and **`defaultSettings()`** are not actually changed — both just call
  `parent::` and return the result unmodified, so the settings form and defaults
  (`responsive_image_style: ''`, `image_link: ''`, `image_loading: ['attribute' => 'lazy']`)
  are exactly core's Responsive Image formatter's.

## Consequences an agent should know

- Because `field_types` is `entity_reference` but `isApplicable()` gates on `target_type ==
  'media'`, the formatter is invisible on entity-reference fields to any non-Media entity —
  no need to hide it manually.
- Picking "File" for `image_link` in the settings form is a dead option for this formatter:
  `getMediaThumbnailUrl()` doesn't handle it, so the image renders unlinked.
- The rendered image is whichever field the media type actually stores its source in — for
  audio/video/remote-oembed media types with no populated source field, the module falls back
  to `thumbnail`, so something still renders.
- Cache tags are added for the responsive image style, the image styles it maps to, and each
  referenced media entity — plus the entity access check — so cache invalidation follows
  normal Drupal render-cache rules when a media item, image style, or responsive image style
  changes.
