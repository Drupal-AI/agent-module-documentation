# Interactive flush form

Route `flush_single_image.flush` → `/admin/config/media/image-styles/flush-single`
(`_admin_route`, permission `administer flush_single_image`).
Form: `Drupal\flush_single_image\Form\FlushSingleImageForm` (form id `flush_single_image_form`).
An action link "Flush single image" to this form is added to the image-styles collection page
(`/admin/config/media/image-styles`).

## Fields

| Field | Type | Notes |
|---|---|---|
| `path` | textfield | Required. Source image URI, e.g. `public://assets/foo/image.jpg`. A scheme-less relative path uses the default scheme (`system.file:default_scheme`). |
| `check` → "Check Styles" | AJAX button | Calls `FlushSingleImageForm::checkStyles()` → `service->getStylePaths($path)`; lists the derivative URIs currently cached for `path` (read-only, deletes nothing). |
| `action` | select | `1` Unlink (default) / `2` Regenerate. Empty falls back to Unlink. |
| `submit` → "Flush" | submit | Calls `service->flush($path, $action)`. |

On submit it adds a message per flushed derivative plus a final "Flushed all images for @path",
then rebuilds the form. Validation only requires `path` to be non-empty. This is a standard Form
API form, so it is CSRF-token protected; it is not a GET link.
