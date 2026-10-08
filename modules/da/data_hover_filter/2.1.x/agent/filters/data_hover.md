<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Filter: data-hover attribute

## Plugin

`Drupal\data_hover_filter\Plugin\Filter\FilterAttribute`
(`src/Plugin/Filter/FilterAttribute.php`).

```
@Filter(
  id = "filter_attribute",
  title = "Data hover Filter",
  description = "Adds a data-hover attribute containing the link text to <a> tags.",
  type = TYPE_TRANSFORM_IRREVERSIBLE,
)
```

Extends `FilterBase`, uses `StringTranslationTrait`. No `settingsForm()`, so the filter has
no configurable options — it is simply enabled/disabled per text format.

## Behavior

`process($text, $langcode)`:

1. `Html::load($text)` parses the incoming HTML into a `DOMDocument`.
2. `getElementsByTagName('a')` collects every anchor.
3. For each link, `$label = trim($link->textContent)`; if `$label !== ''` it calls
   `$link->setAttribute('data-hover', $label)`. Links with empty text (e.g. image-only
   anchors) are skipped.
4. `Html::serialize($html_dom)` re-renders the HTML and it is returned in a
   `FilterProcessResult`.

Only the `data-hover` attribute is added; `href`, classes, and existing attributes are
untouched. The attribute value is the anchor's plain text content, and because it is applied
through DOM `setAttribute` and re-serialized, the serializer handles attribute-value
encoding. No cache metadata or attachments are added to the `FilterProcessResult`.

`tips($long = FALSE)` returns: "Adds a `data-hover` attribute containing the link text to
every link." — shown beneath the format's editor.

## Enable

1. `drush en data_hover_filter` (or via the Extend page).
2. Go to `/admin/config/content/formats`, edit a text format, tick **Data hover Filter**.
3. Because it rewrites generated markup, place it *after* filters that create links
   (e.g. "Convert URLs into links") in the "Filter processing order".

## Theming example

With the filter on, `<a href="/x">Read more</a>` becomes
`<a href="/x" data-hover="Read more">Read more</a>`. A theme can then style, e.g.:

```css
a::before { content: attr(data-hover); /* animated hover overlay */ }
```

## Notes / limits

- No configuration, permissions, services, routes, config schema, or Drush commands.
- Depends only on core's `filter` module. Core `^8`–`^12`.
