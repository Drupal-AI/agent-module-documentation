<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How the class reaches the markup

The entire output path is one hook in `node_class.module`:

```php
function node_class_preprocess_node(&$variables) {
  if (!empty($variables['node'])) {
    $entity = $variables['node'];
    $classes = $entity->get('node_class')->getValue();
    if (!empty($classes)) {
      $variables['attributes']['class'][] = $classes['0']['value'];
    }
  }
}
```

So the stored string is pushed onto `attributes.class` in the node template. In the default
`node.html.twig` (and most themes) `attributes` is printed on the wrapping `<article>` element:

```twig
<article{{ attributes }}>
```

Result: a node whose `node_class` value is `featured` renders as roughly
`<article class="node node--type-article ... featured">`.

## Things an agent should know

- The value is appended as **one class token**. If the field holds `featured two-column`, that whole
  string becomes a single entry in the `class` array. Drupal's `Attribute` renderer prints it as
  `class="... featured two-column"`, so space-separated classes still work as multiple CSS classes in
  the final HTML — but internally it is a single array element, not one per word.
- Only `$classes[0]` (delta 0) is used; the field is single-value anyway.
- Class values are rendered through Drupal's `Attribute` object, which HTML-escapes attribute values,
  so a stored value cannot break out of the attribute.
- The hook runs for **every** node view (teaser, full, any view mode) because it keys off the node
  template's preprocess, not a specific display.
- Target the class from your theme CSS/JS directly, e.g. `.featured { ... }`.
- There is no separate theme hook, template, or library shipped by the module; it only augments core's
  existing `node` theme hook variables.
