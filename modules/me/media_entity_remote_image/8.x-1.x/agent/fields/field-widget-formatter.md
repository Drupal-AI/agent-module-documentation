# Field type, widget, and formatter

The module ships one field type built on core Link, with a matching widget and formatter. They exist
to hold a remote image URL plus alt text and to render it as an `<img>`.

## Field type — `remote_image_url`

- `Plugin/Field/FieldType/RemoteImageUrl.php`, extends `link\…\LinkItem`.
- `default_widget = "remote_image_url_widget"`, `default_formatter = "remote_image_url_formatter"`,
  `category = "general"`.
- Properties/columns: keeps `uri` from Link, **adds `alt`** (`varchar` 255 — "Img alt text"),
  **removes** `title` and `options`. `isEmpty()` is true only when both `uri` and `alt` are empty.
- `defaultFieldSettings()` adds `alt_field_required => 1`. `fieldSettingsForm()` exposes the Link
  `link_type` (recommended **External links only**, `LinkItemInterface::LINK_EXTERNAL`) and an
  `Alt field required` checkbox; the `title` setting is unset.

## Widget — `remote_image_url_widget`

- `Plugin/Field/FieldWidget/RemoteImageUrlWidget.php`, extends `link\…\LinkWidget`.
- Renders **Image URL** (`uri`) and **Alt text** (`alt`) inputs; removes the Link `title` and
  `attributes` sub-elements. Description adapts to the field's `link_type` (external URL vs internal
  path vs both).
- Element validators: filters out the inherited `validateTitleElement`/`validateTitleNoLink`, adds
  `validateRemoteImageElement` (URL required when alt is set; alt required when
  `alt_field_required` and the URL is filled — enforced with `#states` too) and overrides
  `validateUriElement` for the internal-path rules (manual internal paths must start with `/`, `?`,
  `#`, or `<front>`).
- On saved (non-new) media the widget shows a small preview (`buildImagePreview()`): the generated
  thumbnail via `#theme => image_style` (`medium`) when one exists, otherwise `#theme => image` of the
  stored URL. Attaches the `media_entity_remote_image/admin` library.
- Widget settings: inherits Link's `placeholder_url` (`placeholder_title` removed);
  `settingsSummary()` reports the URL placeholder.
- `massageFormValues()` drops items whose `uri` is empty (so an alt-only row is not stored on real
  entities). `formMultipleElements()` special-cases the unlimited-cardinality default-value widget.

## Formatter — `remote_image_url_formatter`

- `Plugin/Field/FieldFormatter/RemoteImageUrlFormatter.php`, label **"Image"**, extends
  `link\…\LinkFormatter`. Config schema `field.formatter.settings.remote_image_url_formatter`.
- `viewElements()` builds `#theme => image` with `#uri => $item->uri` (internal values resolved via
  `_media_entity_remote_image_get_internal_url()`), `#alt => $item->alt`, plus a `loading` attribute
  and optional inline `max-width`/`max-height` style. Optionally wraps the image in a `#type => link`
  to the media entity (`content`) or the image URL (`image`).

| Setting | Default | Meaning |
|---|---|---|
| `max_width` | `0` | Max display width in px (`0` = no max; applied as inline `max-width`, `width:auto`). |
| `max_height` | `0` | Max display height in px (`0` = no max). |
| `image_loading` (`attribute`) | `lazy` | Native `loading` attribute — `lazy` or `eager`. |
| `image_link` | `''` | Link image to nothing (`''`), the `content` (media entity), or the `image` URL. |

The formatter does **not** run the remote image through Drupal image styles — remote bytes stay
remote, so core image-style derivatives cannot be applied to the displayed image (only to a locally
stored thumbnail, if generated). Set it from code:

```php
\Drupal::service('entity_display.repository')
  ->getViewDisplay('media', 'remote_image', 'default')
  ->setComponent('field_media_remote_image_url', [
    'type' => 'remote_image_url_formatter',
    'settings' => ['max_width' => 800, 'image_loading' => ['attribute' => 'lazy']],
  ])->save();
```

## Enforced "required" behavior

`hook_form_field_config_edit_form_alter()`, `_media_entity_remote_image_field_config_required_entity_builder()`,
and `hook_ENTITY_TYPE_presave(field_config)` all force the source field to be **required** and lock the
"Required field" checkbox on the field-config form (`_media_entity_remote_image_is_source_field()`
detects the configured source field of a `remote_image`-source media type).
