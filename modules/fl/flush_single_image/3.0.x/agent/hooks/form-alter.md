# `hook_form_alter` — media edit form widget

`flush_single_image_form_alter()` (in `flush_single_image.module`) injects a "Flush single image"
`details` element into media **edit** forms, letting an editor flush a single derivative of the
image they are editing.

## When it appears

- The form object has a `getEntity()` method and a non-empty entity (i.e. an entity form).
- The `$form_id` matches `media_{TYPE}_edit_form` for one of the bundles enabled in
  `flush_single_image.settings:media_image_types` (see
  [configure/settings.md](../configure/settings.md)).
- The entity has a non-empty `field_media_image`.

## The widget

| Element | Type | Notes |
|---|---|---|
| `fsi_image_style` | select | Options come from `service->getStylePaths($image_uri)` — only styles that currently have a cached derivative for this image. Required (validated). |
| `fsi_action` | select | `1` Unlink (default) / `2` Regenerate. |
| `fsi_submit` | submit | Its own `#submit`/`#validate` handlers, separate from the media form's save. |

Submit handler `flush_single_image_media_image_edit_form_submit()` reads the media's own
`field_media_image` file URI and calls `service->flushStyle($image_uri, $fsi_image_style, $action)`,
then messages success or failure. The path is always the media's managed file URI, never
user-supplied. There is no dedicated permission on this widget — visibility follows the ability to
reach the media edit form.
