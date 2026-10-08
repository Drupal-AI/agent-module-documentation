Twig Attributes adds an `add_attr` (aliased `with_attr`) Twig filter that sets HTML attributes on elements inside a render array straight from a Twig template, so theme developers can add a class or id without a template override or preprocess hook. It also wires attribute support into several core field templates (images, responsive images, file links).

---

The module registers a Twig extension (`src/TwigExtension.php`, priority 100) exposing the `add_attr`/`with_attr` filter: `{{ content.field_x|add_attr(key, attributes, add_to_children = true, override = false) }}`. `key` names the render-array property to receive the attributes (a leading `#` is added automatically); `attributes` is a map of attribute name → value (string or array); by default it applies to the array's child elements, and by default array values are deep-merged rather than replaced. Because Drupal's own `#attributes` on many field elements are only rendered by their templates, the module additionally augments core templates via `hook_theme_registry_alter` + preprocess hooks (`twig_attributes.module`): it adds `image_attributes`/`link_attributes` variables to `image_formatter` and `responsive_image_formatter`, and `link_attributes` to `file_link`, merging those into the rendered `<img>`/`<a>`. This makes it possible to add attributes to fields that don't normally accept them (notably links and images). There is no config, no permissions, no schema, no services beyond the Twig extension — it is a pure theming/developer helper used entirely from template markup.

---

- Add a CSS class to an `<img>` when rendering an image field, from the template.
- Add an `id` to an `<a>` when rendering a link field.
- Set attributes on a field without creating a template override.
- Set attributes on a field without writing a preprocess hook.
- Chain the filter to set attributes on multiple elements in one expression.
- Add `link_attributes` to a file-download link (`file_link`).
- Add `image_attributes` and `link_attributes` to an image formatter output.
- Add attributes to a responsive image formatter's `<img>` and wrapping link.
- Add data-* attributes (e.g. `data-lightbox`) to rendered field images.
- Add ARIA attributes to a rendered link or image for accessibility.
- Merge new classes into an element's existing classes (default merge behavior).
- Override an existing attribute value instead of merging (pass `true` as the 4th arg).
- Target the parent element instead of children (pass `false` as the 3rd arg).
- Add a `rel="nofollow"` to a rendered link field from Twig.
- Add a `loading="lazy"` attribute to a field image from the template.
- Add a `target="_blank"` to a link field's anchor.
- Attach JS-hook classes to field markup for front-end behaviors.
- Add a `title` attribute to a rendered image or link.
- Apply BEM/utility classes to field output in a component-based theme.
- Keep templates DRY by attaching attributes inline rather than per-field overrides.
