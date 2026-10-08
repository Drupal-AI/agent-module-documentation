<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extending media:content / media:thumbnail with getID3 metadata

The entire module is `views_rss_media_getid3_views_rss_item_elements_alter(&$elements)`:

```php
function views_rss_media_getid3_views_rss_item_elements_alter(&$elements) {
  $elements['views_rss_media']['media:content']['preprocess functions'][] = 'views_rss_media_getid3_preprocess_media_content';
  $elements['views_rss_media']['media:thumbnail']['preprocess functions'][] = 'views_rss_media_getid3_preprocess_media_thumbnail';
}
```

This is the canonical example of the alter-hook extension pattern described in the parent's
[hooks/element-hooks.md](../../../../../2.4.x/agent/hooks/element-hooks.md): it does not
define a `media:*` element (that's [views_rss_media](../../../views_rss_media/2.4.x/agent/configure/media-elements.md)),
it appends to that element's existing `preprocess functions` list so both the base
`views_rss_media` preprocessor and this module's run, in order, on the same element.

## What each added preprocessor does

Both locate the underlying `FileInterface` (from a file field or an image field's referenced
entity), resolve the real filesystem path (`\Drupal::service('file_system')->realpath()`,
against the image-style derivative URI if one is configured), and call
`(new \JamesHeinrich\GetID3\GetID3())->analyze($realpath)`.

- **`views_rss_media_getid3_preprocess_media_content()`** (on `media:content`) adds, when
  present in the analysis: video `framerate`, `bitrate`, `width` (`resolution_x`), `height`
  (`resolution_y`); audio `bitrate`, `samplingrate` (Hz ÷ 1000), `channels`; and `duration`
  (`(int) playtime_seconds`) for either.
- **`views_rss_media_getid3_preprocess_media_thumbnail()`** (on `media:thumbnail`) adds video
  `width`/`height` only.

Attributes are only added when the corresponding getID3 analysis key is non-empty — a file
getID3 can't parse (or a non-file/rendered-markup element) simply gets none of these extra
attributes, same as if the module were disabled.

## Library requirement

`use JamesHeinrich\GetID3\GetID3;` at the top of `views_rss_media_getid3.module` is just an
import; it doesn't fail until `new GetID3()` actually executes inside a preprocess function, so
the module **can be enabled without the library installed** — it will only fatal when a feed
containing a `media:content`/`media:thumbnail` element is actually rendered. `hook_requirements()`
checks `class_exists(GetID3::class)` at the `install` phase and reports a `REQUIREMENT_ERROR`
if it's missing, pointing at the module's `README.md`
(`composer require "james-heinrich/getid3:^2.0@beta"` — no stable v2 tag exists yet at time of
writing, hence the `@beta` constraint).
