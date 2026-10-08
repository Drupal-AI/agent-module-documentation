# Theming the tabs output

## Theme hook

`hook_theme()` registers `field__bootstrap_horizontal_tabs` with `base hook => field`. The module
template is `templates/field--bootstrap-horizontal-tabs.html.twig`. Override it by copying that file
into your theme (or use a more specific suggestion such as
`field--node--field-my-tabs--article.html.twig`).

## Variables exposed (via `hook_preprocess_field()`)

For fields of type `bootstrap_horizontal_tabs` the preprocess adds:

| Variable | Source | Use |
|---|---|---|
| `tabs_wrapper_attributes` | `Attribute` | Attributes for the `<ul>` nav (classes `nav nav-tabs`/`nav-pills`, optional `flex-column nav-stacked`, `id`, `role="tablist"`). |
| `content_wrapper_attributes` | `Attribute` | Attributes for the `.tab-content` wrapper (`id` = `<instance>-content`). |
| `items[n].header_attributes` | `Attribute` | The tab `<a>`: `nav-link`, `href="#<id>"`, `id="<id>-tab"`, `role="tab"`, `aria-selected`, toggle attr. |
| `items[n].body_attributes` | `Attribute` | The tab pane `<div>`: `tab-pane fade`, `id`, `role="tabpanel"`, `aria-labelledby`. |
| `items[n].tabs_item_attributes` | `Attribute` | The `<li>`: `nav-item`, `role="presentation"`. |
| `items[n].content.header` | render array | The tab label (`#markup`). |
| `items[n].content.body` | render array | The body (`#type => processed_text` with the item's text format). |

The default template prints the `<ul>` of headers only when `items|length > 1`, then the
`.tab-content` with one `<div>` per body.

## Output & escaping responsibilities (by design)

- **Body** is rendered through `processed_text` with the field item's stored text format, so it is
  filtered by that format — the usual "editors can only use what the format allows" model.
- **Header** is emitted as `#markup` (`'#markup' => $item->header`). Drupal runs `#markup` through
  `Xss::filterAdmin()`, which strips `<script>` but permits a broad set of HTML tags. Treat the tab
  header as an admin-level HTML sink: only grant create/edit access on this field to trusted roles.
  This is normal Field API behavior, not a module vulnerability.

## Deep-linking

When `tab_display` is `tabs`, the formatter attaches `bootstrap_horizontal_tabs/deep-linking`
(`js/deep-linking.js`): on page load it reads the URL fragment, clicks the matching
`#bootstrap-horizontal-tabs a[href="#<anchor>"]`, and scrolls it into view after ~750ms. Anchor ids are
the transliterated, lowercased, underscore-joined tab headers (made unique per render).
