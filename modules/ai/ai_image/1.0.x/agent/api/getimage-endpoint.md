<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ai_image generation endpoint & service

## Route
`POST /api/ai-image/getimage` (`ai_image.getimage`) → `\Drupal\ai_image\Controller\AIImgController::getimage`
Requirement: `_permission: 'access content'`.

### Request body (JSON)
```json
{ "prompt": "a red bicycle", "options": { "prompt_extra": "watercolor", "source": "openai__dall-e-3" } }
```
- `prompt` + `options.prompt_extra` are joined with ", " into the final prompt.
- `options.source` is `"<provider>__<model>"`. Empty or `"000-AI-IMAGE-DEFAULT"` → the site's default `text_to_image` provider (`AiProviderPluginManager::getSimpleDefaultProviderOptions('text_to_image')`).

### Response
```json
{ "text": "https://site/sites/default/files/generated_image.png" }
```
On any exception the controller returns the path to the module's `icons/error.jpg`.

## Service `ai_image.get_image` (`GetAIImage::getImage($provider,$model,$prompt)`)
- Builds provider-specific config: OpenAI → `n/response_format/size/quality/style`; models containing `stable-diffusion` → a Stable-Diffusion config with a baked negative prompt.
- Fires `hook_ai_image_alter_config()` allowing full config replacement.
- Calls `$provider->textToImage(new TextToImageInput($prompt), $model, ["ai_image"])`, saves the first `ImageFile` to `public://generated_image.png`, returns its absolute URL.

## Override config
```php
function mymodule_ai_image_alter_config() {
  return ['response_format' => 'url', 'size' => '512x512'];
}
```