# Footnotes Group block & the "footnotes" extra field

Two ways to render the collected footnotes **outside** the body text — pair either with the
filter's `footnotes_footer_disable: true` so the notes are not also printed inline.

## Footnotes Group block

Class `\Drupal\footnotes\Plugin\Block\FootnotesGroupBlock`.

```
@Block(
  id = "footnotes_group",
  admin_label = @Translation("Footnotes Group"),
)
```

- **Setting:** `group_via_js` (default `false`). When true, footnotes are grouped/collected on
  the client via the `footnotes.group_block_via_js` JS library (useful when several fields or
  blocks on the page each contribute footnotes). Config schema:
  `block.settings.footnotes_group.group_via_js` (bool).
- Place it in a region (Block layout) or render it programmatically, e.g. with Twig Tweak and a
  node context:
  ```twig
  {{ drupal_block('footnotes_group', { context_mapping: { entity: '@node.node_route_context:node' } }) }}
  ```

## The "footnotes" extra field

`footnotes_entity_extra_field_info()` adds a **pseudo-field** named `footnotes` to entity view
displays that have footnote-bearing text, and `footnotes_entity_view()` populates it. So on
*Manage display* you can position **Footnotes** as a display component (e.g. below links, in a
region) instead of inline. This also relies on `footnotes_footer_disable` to avoid duplicate
output.

## Typical "notes in the sidebar" recipe

1. On the text format: `filter_footnotes.settings.footnotes_footer_disable: true`.
2. `drush cr` (the footer-disable note says a cache clear is required).
3. Place the **Footnotes Group** block in the sidebar region (or position the `footnotes` extra
   field on the entity's Manage display).
