<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Responsive wrappers filter

Single filter plugin. Enable it per text format; it rewrites the rendered HTML.

- **Plugin id:** `filter_bootstrap_responsive_wrapper`
- **Title:** "Responsive wrappers filter"
- **Type:** `TYPE_TRANSFORM_IRREVERSIBLE` (mutates markup; not undoable).
- Class: `Drupal\responsivewrappers\Plugin\Filter\FilterResponsiveWrappers`.

## Enable / configure

UI: `/admin/config/content/formats` → edit a format → check "Responsive wrappers filter",
then set its options in the filter's settings fieldset. **Ordering matters** — as an
irreversible transform it should run after other markup-producing filters (its own description
says place it after the Video Embed WYSIWYG filter).

Per-format filter settings (schema `filter_settings.filter_bootstrap_responsive_wrapper`):

| Setting | Type | Default | Effect |
|---|---|---|---|
| `responsive_table` | bool | off | Wrap `<table>` in a wrapper div and add the table class. |
| `responsive_image` | bool | off | Add the image class to every `<img>`. |
| `responsive_iframe` | bool | off | Wrap matching `<iframe>` and add the iframe class. |
| `responsive_iframe_pattern` | string | `#.*(youtube.\|vimeo.).*#ui` | PCRE tested against the iframe `src`; only matches are wrapped. |

If none of the three booleans is on, the filter returns the text unchanged (and attaches no CSS).

## What it emits

Classes come from the **global** config object `responsivewrappers.settings` (see
[../configure/settings.md](../configure/settings.md)); the values below are the shipped Bootstrap 4/5 defaults.

- **Tables** (`responsive_table`): if the `<table>` is not already inside a div carrying the
  wrapper class, it is wrapped in `<div class="table-responsive">`; the `table` class
  (`table`) is added to the `<table>` unless already present.
- **Images** (`responsive_image`): the image class (`img-fluid`) is added to each `<img>`
  unless the class string already contains it.
- **Iframes** (`responsive_iframe`): only iframes whose `src` matches the pattern are touched.
  A matching iframe is wrapped in `<div class="embed-responsive embed-responsive-16by9">` and
  gets `embed-responsive-item`. If its parent div already carries Video Embed Field's
  `video-embed-field-responsive-video` class, that class is replaced in place with the wrapper
  class instead of adding a second wrapper; an existing correct wrapper is left alone.

Verified output (all three on, defaults) for
`<table><tr><td>a</td></tr></table><img src="x.png"><iframe src="https://youtube.com/embed/1"></iframe>`:

    <div class="table-responsive"><table class="table"><tr><td>a</td></tr></table></div><img src="x.png" class="img-fluid"><div class="embed-responsive embed-responsive-16by9"><iframe src="https://youtube.com/embed/1" class="embed-responsive-item"></iframe></div>

## Attached CSS

The filter attaches a CSS library **only when** the global `add_css` = 1: version 3 →
`responsivewrappers/responsivewrappers_v3`, version 4 or 5 → `responsivewrappers/responsivewrappers_v4`.
With `add_css` = 0 (default) no library is attached — rely on the Bootstrap theme's own CSS.

## Set filter settings by code / config

Filter settings live on the text format entity, e.g. in `filter.format.<id>.yml`:

    filters:
      filter_bootstrap_responsive_wrapper:
        status: true
        weight: 20
        settings:
          responsive_iframe: true
          responsive_iframe_pattern: '#.*(youtube.|vimeo.).*#ui'
          responsive_table: true
          responsive_image: true

Adjust `weight` so it sorts after other markup filters in that format.
