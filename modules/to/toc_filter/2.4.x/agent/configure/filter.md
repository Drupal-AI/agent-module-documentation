<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable and configure the TOC filter

TOC Filter has no settings form of its own; it is configured **per text format** (plus TOC types
from TOC API). Its `configure` route `entity.toc_type.list` points at *Structure → Table of
contents* (`/admin/structure/toc`), which manages TOC **types**, not the filter.

## Enable the filter on a text format

UI: *Configuration → Content authoring → Text formats and editors*
(`/admin/config/content/formats`) → configure a format → check **"Display a table of contents"** →
Save. Make sure the format's "Limit allowed HTML tags" filter permits your header tags
(`<h2>`…`<h6>`) so the TOC has something to index.

Config location: `filter.format.<format_id>` → `filters.toc_filter`:

```yaml
filters:
  toc_filter:
    id: toc_filter
    provider: toc_filter
    status: true
    weight: 0
    settings:
      type: default        # a TOC type id (default|simple|full|full_numbered|simple_numbered|...)
      auto: ''             # '' | top | bottom  (auto-insert a [toc] when none present)
      block: false         # true = render the TOC via the block, not inline
      exclude_above: false # true = ignore headers above the [toc] token
```

Programmatic enable (drush php:eval):

```php
$f = \Drupal\filter\Entity\FilterFormat::load('full_html');
$f->setFilterConfig('toc_filter', [
  'status' => TRUE,
  'settings' => ['type' => 'default', 'auto' => '', 'block' => FALSE, 'exclude_above' => FALSE],
]);
$f->save();
```

Read it back: `drush cget filter.format.full_html filters.toc_filter`.

## Filter settings

| Setting | Values | Effect |
|---|---|---|
| `type` | a `toc_type` id | Which TOC type (style) to render. Defaults to `default`. |
| `auto` | `''`, `top`, `bottom` | If the text has no `[toc]` token, inject one at the top or bottom; `''` = do nothing. |
| `block` | bool | If true, the TOC is rendered by the **"Table of contents"** block instead of inline; the token is removed from the body. |
| `exclude_above` | bool | If true, headers appearing before the `[toc]` token are excluded from the TOC. |

## The `[toc]` token and inline options

Put `[toc]` in the body where the TOC should appear. Inline options are HTML-style attributes on
the token and are merged over the TOC type's options (`TocFilter::parseOptions()`):

```
[toc]
[toc type="simple"]
[toc type="tree" title="On this page"]
[toc block="true"]
```

- `type` — override the TOC type for this token.
- `title` — heading shown above the TOC.
- `block="true"` — render via the block for this token.
- `h1`…`h6` attributes map to the TOC's `headers` option (which header levels to include).
- Values `true`/`false` become booleans; numeric values become numbers.

The filter only replaces the **first** `[toc]` token. Block tags wrapping the token
(`<p>[toc]</p>`, `<div>[toc]</div>`, `<h2>[toc]</h2>`, `<blockquote>`) are stripped so the token
resolves cleanly.

## Rendering it as a block

1. Set the filter's `block` setting to true (or use `[toc block="true"]`).
2. Place the **"Table of contents"** block (plugin id `toc_filter`, category "TOC filter") in a
   region at *Structure → Block layout*.

The block only shows on a node whose `body` actually produces a TOC (it re-runs the body through
`check_markup()` to detect one), and returns *forbidden* otherwise.

## TOC types (from TOC API)

The `type` you choose refers to a `toc_type` config entity managed by **TOC API** at
`/admin/structure/toc` (route `entity.toc_type.list`). Default types include `default`, `simple`,
`simple_numbered`, `full`, `full_numbered`. Create/clone types there to control markup, header
levels, and CSS classes; TOC Filter just references them by id.
