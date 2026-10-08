<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugins — what Lightning Media implements

The module **defines no plugin type of its own**. It implements other people's.

## Entity Browser widgets (need `entity_browser` + `inline_entity_form`)

Registered imperatively in `hook_entity_browser_widget_info_alter()` — they only appear
when `inline_entity_form` is installed, and they are **not** annotated plugin classes:

| Widget id | Class | Label |
|---|---|---|
| `file_upload` | `Plugin\EntityBrowser\Widget\FileUpload` | File Upload |
| `embed_code` | `Plugin\EntityBrowser\Widget\EmbedCode` | Embed Code |

Both extend `EntityFormProxy`: type/drop something into the widget's `input` element, the
widget asks `MediaHelper` which media type matches, and then renders that unsaved media
entity's inline entity form so the editor can fill in the rest before selecting it.

Shared configuration (`EntityFormProxy::defaultConfiguration()`):

```yaml
target_bundles: []          # empty = all media types the user can create
form_mode: media_browser    # inline entity form mode
submit_text: …              # from WidgetBase
```

`FileUpload` adds:

```yaml
return_file: false          # TRUE returns the underlying file entity instead of the media entity
upload_validators: []       # extra validators merged into the ajax_upload element
```

`EmbedCode`'s input is a textarea with an AJAX `change` handler; `FileUpload`'s input is an
`ajax_upload` element whose validators come from the matching media types.
Config schema keys: `entity_browser.browser.widget.file_upload` and
`entity_browser.browser.widget.embed_code`.

## Form elements

| `#type` | Class | Notes |
|---|---|---|
| `upload` | `Element\Upload` (extends core `FileElement`) | plain file upload |
| `interactive_upload` | `Element\InteractiveUpload` | upload **or** delete, with a Remove button |
| `ajax_upload` | `Element\AjaxUpload` (extends `InteractiveUpload`) | the same, AJAX-driven; carries the `js-form-managed-file` class so core's file JS binds |

Use `ajax_upload` when you want "drop a file, immediately react to it" behaviour in a custom
form.

## Entity Embed display plugin

```php
@EntityEmbedDisplay(
  id = "media_image",
  label = @Translation("Media Image"),
  entity_types = {"media"},
  field_type = "image",
  provider = "image"
)
class MediaImage extends ImageFieldFormatter
```

Renders an embedded media item through core's **image formatter** — using the item's own
image source field when it has one, otherwise its thumbnail. `lightning_media_image` sets
`$sources['image']['entity_embed_display'] = 'media_image'` so image media prefers it, and
`Form\EntityEmbedDialog` honours that when `lightning_media.settings:entity_embed.choose_display`
is FALSE.

## Media source plugins

The base module ships **none**. Each submodule contributes an input-matching subclass of a
core source plugin (`audio_file`, `file`, `image`, `video_file`, `oembed:video`,
`oembed:instagram`, `twitter`) and registers it with `hook_media_source_info_alter()` +
`Override::pluginClass()`. See `api/media-helper.md` for the `InputMatchInterface` contract
and the two traits that implement it.

To add input matching to your own source plugin:

```php
// mymodule.module
function mymodule_media_source_info_alter(array &$sources) {
  $sources['my_source']['input_match'] = [
    'constraint' => 'MyEmbedCode',            // for ValidationConstraintMatchTrait
    'field_types' => ['string', 'string_long'],
  ];
  $sources['my_source']['preview'] = TRUE;    // enables the live preview on the media form
  Override::pluginClass($sources['my_source'], MySourceWithMatching::class);
}
```

`Override::pluginClass()` only swaps the class when your class's **immediate parent** is the
class currently in the definition, so chain carefully.

## Views

No Views plugins of its own. It alters the `media_library` view at runtime
(`hook_views_pre_view()`) and adds `data-selectable` attributes to entity-browser grid views
(`hook_preprocess_views_view_grid()`).
