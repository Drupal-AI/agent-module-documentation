# hook_form_alter — the generate-image integration

This is the module's core surface. `ai_media_image_form_alter()` (in `ai_media_image.module`)
injects the AI generation UI into three core media forms and wires validate/submit handlers. The
element building and the save logic live in the service `ai_media_image.add_form`
(`Drupal\ai_media_image\Form\AiMediaImageAddForm`, using `AiMediaImageFormTrait`).

## Which forms are altered
`media_image_add_form`, `media_library_add_form_upload`, `media_library_add_form_dropzonejs`.
The alteration only runs when **both** hold:
1. current user has `generate image with ai`; and
2. the resolved media type is `image` (from `media_library_state`'s selected type, else `'image'`).

It adds an `image_source` select (`upload` / `ai`, default `upload`, weight `-1`). `#states` hide
the normal upload/image field when `ai` is chosen and vice-versa. The source image field is made
non-required so the form can submit with an AI image instead. `buildInputElement()` →
`buildAiForm()` appends the `ai_media_image` details fieldset, and `ai_media_image_add_form_validate`
is appended to `#validate`.

## The generate UI (`buildAiForm`, AiMediaImageFormTrait)
- `ai_media_image` (details, open) → `generator_container`:
  - `prompt` (textarea, required when `image_source == ai`).
  - `options_group`: the AI provider/model config form, built by
    `\Drupal::service('ai.form_helper')->generateAiProvidersForm(..., 'text_to_image', 'image_generator', AiProviderFormHelper::FORM_CONFIGURATION_FULL)`. The image-count field
    (`image_generator_ajax_prefix_configuration_n`) is forced to `1` and disabled. The
    "Provider Configuration" fieldset's default open state comes from
    `ai_media_image.settings:provider_configuration_open`.
  - `generate_image` submit button (`#name` `addAiImage`, AJAX → `generateImageAjaxCallback`,
    replaces `#image-preview-wrapper`).
  - `image_preview` container (id `image-preview`); after a generation it renders an inline
    `data:image/jpeg;base64,...` `<img>` plus a required `alt_text` textfield (pre-filled with the
    first 255 chars of the prompt) and, in the Media Library flow, a "Save to Media Library" button.

## Generate flow (`addAiImage` → `generateImageInAiModule`)
On the generate click, all `image_generator_ajax_prefix_configuration_*` values are collected into a
`$config` array; `prompt`, `image_generator_ai_provider`, and `image_generator_ai_model` are read.
Then:
```php
$ai_provider = \Drupal::service('ai.provider')->createInstance($provider);
$ai_provider->setConfiguration($config);
$response = $ai_provider->textToImage(new TextToImageInput($prompt), $model);
// binary is taken directly from the normalized response — no URL is fetched:
$image_data = base64_encode($response->getNormalized()[0]->getBinary());
```
The base64 result is stored in `$form_state->set('image_data', ...)` and the form rebuilds to show
the preview. All provider I/O (and its TLS) is entirely inside the `ai` provider plugin; this module
performs no HTTP request and never dereferences a provider-returned URL.

## Validation (`ai_media_image_add_form_validate`)
Runs on every submit of the altered form. It calls `$form_state->clearErrors()`, then branches:
- Triggering element is **not** `addAiImage` (i.e. the final save):
  - `upload` source → requires the media source image field to be non-empty.
  - `ai` source → requires `image_data` to exist and `alt_text` to be provided, then installs
    `ai_media_image_add_form_submit` as the submit handler.
- Triggering element **is** `addAiImage` (the generate click) → requires a non-empty `prompt`.

## Save (`ai_media_image_add_form_submit` → `processGeneratedFile`)
Decodes `image_data`, writes it to `public://ai_generated_image_<uniqid()>.jpg` via
`\Drupal::service('file.repository')->writeData(... FileSystemInterface::EXISTS_REPLACE)`, then
creates a `Media::create(['bundle' => 'image', 'name' => <name>|filename, <image_field> => ['target_id' => $fid, 'alt' => <alt_text>]])`, saves it, and redirects to `entity.media.collection`
(the Media Library flow instead updates the library via AJAX). The image field name is resolved
generically from the `image` media type's source field (`_ai_media_image_get_image_field_name`).
The saved file extension is always `.jpg`.
