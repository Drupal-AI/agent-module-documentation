# Rendering the class onto the term markup

`taxonomy_class_preprocess_taxonomy_term(&$variables)` in `taxonomy_class.module` runs whenever a
taxonomy term is rendered through the theme layer. It:

1. Reads the rendered entity from `$variables['elements']['#taxonomy_term']` (skips if absent).
2. Fetches the field value: `$entity->get('taxonomy_class')->getValue()`.
3. If non-empty, appends the **first** value only to the term's attribute class list:
   `$variables['attributes']['class'][] = $classes['0']['value'];`

So the class lands on the wrapper element of `taxonomy-term.html.twig`, i.e. wherever the template
prints `{{ attributes }}` (core's default `<div{{ attributes }}>`). Only the first stored value is
used — a multi-word/space-separated entry is emitted as a single class token, not split into
multiple classes.

Notes for integrators:
- The class is added at preprocess time to `$variables['attributes']`, which the Twig engine turns
  into a `Drupal\Core\Template\Attribute` object before rendering, so the value is emitted through
  the standard attribute rendering path.
- The hook only fires for the `taxonomy_term` render (the term page or any term view mode) — it does
  NOT add the class to nodes or other entities tagged with the term. To reuse the value elsewhere,
  read `$term->get('taxonomy_class')->value` yourself in your own preprocess/template.
- The in-code docblock mislabels this as `hook_preprocess_html()`, but the function name keys it to
  `taxonomy_term`; it is a `hook_preprocess_HOOK` for the `taxonomy_term` theme hook.
