<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mechanism: body classes on node pages

The whole module is one procedural hook in `body_node_id_class.module`:

```php
function body_node_id_class_preprocess_html(&$variables) {
  $node = \Drupal::routeMatch()->getParameter('node');
  if (isset($node)) {
    if ($node instanceof \Drupal\node\Entity\Node) {
      $variables['attributes']['class'][] = 'page-node-' . $node->id();
      $variables['attributes']['class'][] = 'page-node-type-' . $node->bundle();
    }
    else {
      $variables['attributes']['class'][] = 'page-node-' . $node;
    }
  }
}
```

## What you get

- On a canonical node page (`/node/{nid}`, or a node used as the front page) the `<body>` tag
  gains:
  - `page-node-<nid>` — e.g. `page-node-42`
  - `page-node-type-<bundle>` — e.g. `page-node-type-article`
- If the `node` route parameter is present but **not** upcast to a `Node` object (a bare ID
  string), only `page-node-<nid>` is added.

## When it does / does not fire

- Fires in `hook_preprocess_html()`, so it affects the **outermost `<body>`** of a full HTML
  page response only.
- Runs only when the current route has a `node` parameter (node canonical pages). It does
  **nothing** on non-node routes (front page that isn't a node, views pages, admin pages,
  taxonomy pages) and does not alter entity view render arrays or stored values.
- No configuration exists — the classes are always added when a node is in the route. Just
  enable the module and `drush cr`.

## How to target it

CSS in your theme:

```css
.page-node-42 { /* one specific node */ }
.page-node-type-landing_page { /* all nodes of a content type */ }
```

Client-side, read `document.body.classList` for `page-node-type-<bundle>`.
