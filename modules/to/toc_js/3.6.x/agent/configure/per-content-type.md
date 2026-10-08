<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable a TOC on a content type

No settings page. You enable and configure the TOC per **content type**; the settings live as
**third-party settings** on the `node.type.<bundle>` config entity under the `toc_js` namespace, and
a `toc_js` extra field renders the TOC in the chosen view display.

## Via the UI

1. *Structure → Content types → edit* the type → **Table of contents** section (in Additional
   settings). Requires `administer toc_js` or `administer nodes`.
2. Tick **Enable Table of contents** and adjust the settings (title, selectors, etc.).
3. Save. Then on that type's **Manage display**, place the **Toc** extra field where you want it.

## Storage (third-party settings)

```yaml
# node.type.<bundle>
third_party_settings:
  toc_js:
    toc_js_active: true
    title: 'Table of contents'
    selectors: 'h2,h3'
    container: '.node'
    list_type: 'ul'
    smooth_scrolling: 1
    highlight_on_scroll: 1
    # ... ~40 keys total (see below)
```

Scriptable:

```php
$type = \Drupal\node\Entity\NodeType::load('article');
$type->setThirdPartySetting('toc_js', 'toc_js_active', TRUE);
$type->setThirdPartySetting('toc_js', 'title', 'On this page');
$type->setThirdPartySetting('toc_js', 'selectors', 'h2,h3,h4');
$type->save();
```

Read back: `drush cget node.type.article third_party_settings.toc_js`.

## The extra field

When `toc_js_active` is TRUE the module exposes an extra display field `toc_js` on that bundle
(`hook_entity_extra_field_info`). Place it via Manage display (or config):

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('toc_js', ['weight' => 0, 'region' => 'content'])->save();
```

`hook_node_view()` builds the TOC render array (via `TocJsService::buildToc()`) when the `toc_js`
component is present and `toc_js_active` is set.

## The settings keys

All keys come from `TocJsService::defaultSettings()` (defaults in parentheses): `title`
("Table of contents"), `title_tag` (div), `title_classes` (toc-title,h2), `selectors` (h2,h3),
`selectors_minimum` (0), `container` (.node), `prefix` (toc), `list_type` (ul), `list_classes`,
`li_classes`, `inheritable_classes`, `classes`, `heading_classes`, `skip_invisible_headings` (0),
`use_heading_html` (0), `heading_cleanup_selector` (.visually-hidden, .sr-only),
`collapsible_items` (0), `collapsible_expanded` (1), `back_to_top` (0), `back_to_top_label`,
`back_to_top_selector`, `heading_focus` (0), `back_to_toc` (0), `back_to_toc_label`,
`back_to_toc_classes`, `smooth_scrolling` (1), `scroll_to_offset`, `highlight_on_scroll` (1),
`highlight_offset` (0), `sticky` (0), `sticky_offset` (0), `toc_container`, `ajax_page_updates` (0),
`observable_selector`. Most are rendered as `data-*` attributes on the `.toc-js` element for the JS
library (see [../theming/template.md](../theming/template.md)).
