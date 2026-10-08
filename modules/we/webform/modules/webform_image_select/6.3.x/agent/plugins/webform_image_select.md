# Image-select element

`@WebformElement` id `webform_image_select` (label "Image select", category "Options elements"),
extending Webform's `Select` element. Class:
`src/Plugin/WebformElement/WebformImageSelect.php`; render element
`src/Element/WebformImageSelect.php`.

## Add it to a form
In the Webform UI add an element of type **Image select**. Provide choices either:
- **Inline** — a `#images` map of `value: { text, src, ... }`, or
- **From a set** — set `#images` to a `webform_image_select_images` entity id (see the
  configure doc) so the gallery is reusable.

Key properties (beyond standard select props like `#multiple`, `#required`):
- `#images` — associative array of options or an image-set machine name.
- `#images_randomize` — shuffle option order.
- `#show_label` — show/hide the text label under each image.
- `#filter` — enable the client-side filter box for long lists.

Values submitted are the option keys (same as a normal select), so the element works with
conditional logic, defaults, and exports like any options element. The picker markup/behavior
comes from the `webform_image_select` library (`css/`, `js/`).
