<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Attribute pass-through for RSS item elements

The whole module is `views_rss_format_preprocess_views_view_row_rss(&$variables)`, a
`hook_preprocess_HOOK()` implementation for the `views_view_row_rss` theme hook (the row
plugin's `themeFunctions()` target). It:

1. Reads `$variables['row']` (the `\stdClass` `$item` the `views_rss_fields` row plugin built
   in its `render()`/`mapRow()`) and republishes `title`, `link` (via
   `UrlHelper::stripDangerousProtocols()`), and `description` as top-level template variables —
   these three are hardcoded in `views-view-row-rss.html.twig`.
2. Builds `$variables['item_elements']` from `$item->elements` — every other configured RSS
   element (enclosure, category, media:*, dc:*, guid, ...) — converting each element's raw
   `attributes` array into a `Drupal\Core\Template\Attribute` object:
   ```php
   if (isset($element['attributes']) && is_array($element['attributes'])) {
     $element['attributes'] = new Attribute($element['attributes']);
   }
   ```

## Why this matters

Every element definition across `views_rss_core`, `views_rss_media`, and
`views_rss_media_getid3` that needs XML attributes rather than (or in addition to) a text
value — `<enclosure url="..." length="..." type="...">`,
`<media:content bitrate="..." width="...">`, `<guid isPermaLink="true">`,
`<cloud domain="..." port="...">` — sets `$element['attributes']` as a plain PHP array in its
preprocess function. Without this module's conversion step, `views-view-row-rss.html.twig`'s
`{{ item.attributes }}` would print a PHP array cast to string instead of `key="value"` XML
attributes. This module is what makes that final conversion happen; disabling it degrades
every attribute-bearing element from every other submodule, not just its own (it defines none).

## Diagnosing

If an RSS item's `<enclosure>`/`<media:content>`/`<guid>` tag is present but its attributes are
missing or malformed, check `views_rss_format` is enabled before looking anywhere else.
